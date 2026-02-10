import SwiftUI
import AppKit

class NotchOverlayWindow: NSWindow {
    private var hostingView: NSHostingView<ContentView>?
    private let notchHeight: CGFloat = 32
    private let notchWidth: CGFloat = 300
    
    init() {
        let screen = NotchOverlayWindow.getBuiltInScreen()
        let screenFrame = screen.frame
        
        let windowRect = NSRect(
            x: (screenFrame.width - notchWidth) / 2,
            y: screenFrame.height - notchHeight,
            width: notchWidth,
            height: notchHeight
        )
        
        super.init(
            contentRect: windowRect,
            styleMask: [.borderless, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        
        self.level = .statusBar
        self.collectionBehavior = [.canJoinAllSpaces, .stationary, .ignoresCycle]
        self.isOpaque = false
        self.backgroundColor = .clear
        self.hasShadow = false
        self.ignoresMouseEvents = false
        self.isMovable = false
        self.isReleasedWhenClosed = false
        
        let contentView = ContentView(window: self)
        hostingView = NSHostingView(rootView: contentView)
        self.contentView = hostingView
        
        setupTrackingArea()
        
        // Make window visible
        self.makeKeyAndOrderFront(nil)
        self.orderFrontRegardless()
    }
    
    private func setupTrackingArea() {
        let trackingArea = NSTrackingArea(
            rect: self.frame,
            options: [.mouseEnteredAndExited, .activeAlways, .inVisibleRect],
            owner: self,
            userInfo: nil
        )
        self.contentView?.addTrackingArea(trackingArea)
    }
    
    private static func getBuiltInScreen() -> NSScreen {
        // Try to find the built-in display (the one with the notch)
        // Built-in displays typically have specific characteristics:
        // 1. They are the main screen when no external displays are connected
        // 2. They have a safeAreaInsets.top > 0 (for the notch)
        // 3. They are usually the screen with the highest pixel density
        
        // First, check for screen with notch (safeAreaInsets.top > 0)
        if #available(macOS 12.0, *) {
            for screen in NSScreen.screens {
                if screen.safeAreaInsets.top > 0 {
                    return screen
                }
            }
        }
        
        // Fallback: Use main screen (which is typically the built-in display)
        // or the first screen if main is nil
        return NSScreen.main ?? NSScreen.screens.first ?? NSScreen.screens[0]
    }
    
    func expand() {
        let settings = AppSettings.shared
        let screen = NotchOverlayWindow.getBuiltInScreen()
        let screenFrame = screen.frame
        
        let newHeight = settings.expandedHeight
        let newWidth = settings.expandedWidth
        
        let newFrame = NSRect(
            x: (screenFrame.width - newWidth) / 2,
            y: screenFrame.height - newHeight,
            width: newWidth,
            height: newHeight
        )
        
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.3
            context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            self.animator().setFrame(newFrame, display: true)
        })
    }
    
    func collapse() {
        let screen = NotchOverlayWindow.getBuiltInScreen()
        let screenFrame = screen.frame
        
        let newFrame = NSRect(
            x: (screenFrame.width - notchWidth) / 2,
            y: screenFrame.height - notchHeight,
            width: notchWidth,
            height: notchHeight
        )
        
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.3
            context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            self.animator().setFrame(newFrame, display: true)
        })
    }
}
