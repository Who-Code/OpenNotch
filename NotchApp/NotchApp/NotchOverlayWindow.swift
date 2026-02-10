import SwiftUI
import AppKit

class NotchOverlayWindow: NSWindow {
    private var hostingView: NSHostingView<ContentView>?
    private let notchHeight: CGFloat = 32
    private let notchWidth: CGFloat = 300
    
    init() {
        let screen = NSScreen.main ?? NSScreen.screens[0]
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
        
        let contentView = ContentView(window: self)
        hostingView = NSHostingView(rootView: contentView)
        self.contentView = hostingView
        
        setupTrackingArea()
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
    
    func expand() {
        let settings = AppSettings.shared
        let screen = NSScreen.main ?? NSScreen.screens[0]
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
        let screen = NSScreen.main ?? NSScreen.screens[0]
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
