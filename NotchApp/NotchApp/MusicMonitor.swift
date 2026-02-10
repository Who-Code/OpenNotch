import Foundation
import AppKit
import MediaPlayer
import Combine

class MusicMonitor: ObservableObject {
    static let shared = MusicMonitor()
    
    @Published var isPlaying: Bool = false
    @Published var currentTrack: String = "Unknown Track"
    @Published var currentArtist: String = "Unknown Artist"
    @Published var currentArtwork: NSImage?
    
    private var timer: Timer?
    
    private init() {
        startMonitoring()
        setupNotificationObservers()
    }
    
    private func setupNotificationObservers() {
        DistributedNotificationCenter.default().addObserver(
            self,
            selector: #selector(updatePlaybackInfo),
            name: NSNotification.Name("com.apple.Music.playerInfo"),
            object: nil
        )
    }
    
    private func startMonitoring() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.checkMusicPlayback()
        }
        checkMusicPlayback()
    }
    
    @objc private func updatePlaybackInfo() {
        checkMusicPlayback()
    }
    
    private func checkMusicPlayback() {
        checkAppleMusic()
    }
    
    private func checkAppleMusic() {
        let script = """
        tell application "System Events"
            set isRunning to (name of processes) contains "Music"
        end tell
        
        if isRunning then
            tell application "Music"
                if player state is playing then
                    return name of current track & "|" & artist of current track & "|playing"
                else
                    return "||stopped"
                end if
            end tell
        else
            return "||stopped"
        end if
        """
        
        executeAppleScript(script) { [weak self] result in
            guard let self = self, let result = result else { return }
            
            let components = result.split(separator: "|").map(String.init)
            if components.count >= 3 && components[2] == "playing" {
                DispatchQueue.main.async {
                    self.isPlaying = true
                    self.currentTrack = components[0].isEmpty ? "Unknown Track" : components[0]
                    self.currentArtist = components[1].isEmpty ? "Unknown Artist" : components[1]
                    self.fetchAppleMusicArtwork()
                }
            } else {
                self.checkIfStopped()
            }
        }
    }
    
    private func checkIfStopped() {
        DispatchQueue.main.async {
            self.isPlaying = false
        }
    }
    
    private func fetchAppleMusicArtwork() {
        let script = """
        tell application "Music"
            try
                set artworkData to raw data of artwork 1 of current track
                return artworkData
            on error
                return missing value
            end try
        end tell
        """
        
        executeAppleScript(script) { [weak self] _ in
            DispatchQueue.main.async {
                self?.currentArtwork = NSImage(systemSymbolName: "music.note", accessibilityDescription: nil)
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
    
    deinit {
        timer?.invalidate()
        DistributedNotificationCenter.default().removeObserver(self)
    }
}
