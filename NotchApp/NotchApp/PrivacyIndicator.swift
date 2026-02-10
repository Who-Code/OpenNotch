import SwiftUI

struct PrivacyIndicator: View {
    @State private var isCameraActive = false
    @State private var isMicrophoneActive = false
    @State private var timer: Timer?
    
    var body: some View {
        HStack(spacing: 8) {
            if isCameraActive || isMicrophoneActive {
                Circle()
                    .fill(Color.orange)
                    .frame(width: 8, height: 8)
                    .shadow(color: .orange.opacity(0.6), radius: 4)
                    .overlay(
                        Circle()
                            .stroke(Color.orange.opacity(0.3), lineWidth: 2)
                            .scaleEffect(1.5)
                            .opacity(0.8)
                    )
            }
        }
        .onAppear {
            startMonitoring()
        }
        .onDisappear {
            stopMonitoring()
        }
    }
    
    private func startMonitoring() {
        checkPrivacyStatus()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            checkPrivacyStatus()
        }
    }
    
    private func stopMonitoring() {
        timer?.invalidate()
        timer = nil
    }
    
    private func checkPrivacyStatus() {
        checkCameraStatus()
        checkMicrophoneStatus()
    }
    
    private func checkCameraStatus() {
        let script = """
        tell application "System Events"
            set cameraApps to name of every process whose background only is false
            set cameraActive to false
            
            repeat with appName in cameraApps
                if appName contains "Camera" or appName contains "FaceTime" or appName contains "Zoom" or appName contains "Teams" or appName contains "Skype" then
                    set cameraActive to true
                    exit repeat
                end if
            end repeat
            
            return cameraActive
        end tell
        """
        
        executeAppleScript(script) { result in
            DispatchQueue.main.async {
                self.isCameraActive = result == "true"
            }
        }
    }
    
    private func checkMicrophoneStatus() {
        let script = """
        tell application "System Events"
            set micApps to name of every process whose background only is false
            set micActive to false
            
            repeat with appName in micApps
                if appName contains "FaceTime" or appName contains "Zoom" or appName contains "Teams" or appName contains "Skype" or appName contains "Discord" or appName contains "Slack" then
                    set micActive to true
                    exit repeat
                end if
            end repeat
            
            return micActive
        end tell
        """
        
        executeAppleScript(script) { result in
            DispatchQueue.main.async {
                self.isMicrophoneActive = result == "true"
            }
        }
    }
    
    private func executeAppleScript(_ script: String, completion: @escaping (String?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            var error: NSDictionary?
            if let scriptObject = NSAppleScript(source: script) {
                let output = scriptObject.executeAndReturnError(&error)
                if error == nil {
                    completion(output.stringValue)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
}
