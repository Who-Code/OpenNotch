import SwiftUI
import AppKit

class NotchOverlayWindow: NSWindow {
    private var hostingView: NSHostingView<ContentView>?
    private let notchHeight: CGFloat = 32
    private let notchWidth: CGFloat = 300
    private let targetScreen: NSScreen
    
    init() {
        // Cache the screen reference to avoid repeated lookups
        self.targetScreen = NotchOverlayWindow.getBuiltInScreen()
        let screenFrame = targetScreen.frame
        
        print("📍 Using screen frame: \(screenFrame)")
        print("📍 Screen origin: (\(screenFrame.origin.x), \(screenFrame.origin.y))")
        
        // Calculate center position relative to screen's coordinate space
        let centerX = screenFrame.origin.x + (screenFrame.width - notchWidth) / 2
        let topY = screenFrame.origin.y + screenFrame.height - notchHeight
        
        print("📍 Calculated window position: (\(centerX), \(topY))")
        
        let windowRect = NSRect(
            x: centerX,
            y: topY,
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
        
        // Enable mouse events
        self.acceptsMouseMovedEvents = true
    }
    
    // Override to allow borderless window to become key and receive events
    override var canBecomeKey: Bool {
        return true
    }
    
    override var canBecomeMain: Bool {
        return false
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
        print("🔍 Searching for screen with notch...")
        print("🔍 Total screens connected: \(NSScreen.screens.count)")
        
        // Check all screens for notch (safeAreaInsets.top > 0)
        if #available(macOS 12.0, *) {
            for (index, screen) in NSScreen.screens.enumerated() {
                print("🔍 Screen \(index): frame=\(screen.frame), safeAreaInsets=\(screen.safeAreaInsets)")
                if screen.safeAreaInsets.top > 0 {
                    print("✅ Found screen with notch at index \(index)!")
                    return screen
                }
            }
        }
        
        print("⚠️ No screen with notch found, using main screen as fallback")
        return NSScreen.main ?? NSScreen.screens.first ?? NSScreen.screens[0]
    }
    
    func expand() {
        let settings = AppSettings.shared
        let screenFrame = targetScreen.frame
        
        let newHeight = settings.expandedHeight
        let newWidth = settings.expandedWidth
        
        let newFrame = NSRect(
            x: screenFrame.origin.x + (screenFrame.width - newWidth) / 2,
            y: screenFrame.origin.y + screenFrame.height - newHeight,
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
        let screenFrame = targetScreen.frame
        
        let newFrame = NSRect(
            x: screenFrame.origin.x + (screenFrame.width - notchWidth) / 2,
            y: screenFrame.origin.y + screenFrame.height - notchHeight,
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
