import SwiftUI
import ServiceManagement

@main
struct OpenNotchApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var settings = AppSettings.shared
    
    var body: some Scene {
        Settings {
            SettingsView()
                .environmentObject(settings)
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var notchWindow: NotchOverlayWindow?
    var statusItem: NSStatusItem?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
        
        setupStatusBarItem()
        setupNotchWindow()
        
        if AppSettings.shared.launchAtLogin {
            enableLaunchAtLogin()
        }
    }
    
    private func setupStatusBarItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "waveform", accessibilityDescription: "OpenNotch")
        }
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Settings...", action: #selector(openSettings), keyEquivalent: ","))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit OpenNotch", action: #selector(quitApp), keyEquivalent: "q"))
        
        statusItem?.menu = menu
    }
    
    private func setupNotchWindow() {
        // Debug: Print screen info BEFORE creating window
        if let screen = NSScreen.main {
            print("🖥️ Main screen frame: \(screen.frame)")
            print("🖥️ Main screen visible frame: \(screen.visibleFrame)")
            if #available(macOS 12.0, *) {
                print("🖥️ Main screen safe area insets: \(screen.safeAreaInsets)")
            }
        }
        
        notchWindow = NotchOverlayWindow()
        notchWindow?.makeKeyAndOrderFront(nil)
        notchWindow?.orderFrontRegardless()
        
        // Debug: Print window info
        if let window = notchWindow {
            print("✅ NotchWindow created at frame: \(window.frame)")
            print("✅ Window is visible: \(window.isVisible)")
            print("✅ Window level: \(window.level.rawValue)")
            print("✅ Window alpha: \(window.alphaValue)")
            print("✅ Window is on screen: \(window.isOnActiveSpace)")
        }
    }
    
    @objc private func openSettings() {
        NSApp.activate(ignoringOtherApps: true)
        NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
    }
    
    @objc private func quitApp() {
        NSApplication.shared.terminate(nil)
    }
    
    private func enableLaunchAtLogin() {
        if #available(macOS 13.0, *) {
            do {
                try SMAppService.mainApp.register()
            } catch {
                print("Failed to enable launch at login: \(error)")
            }
        }
    }
}
