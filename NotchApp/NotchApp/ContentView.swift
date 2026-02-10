import SwiftUI

struct ContentView: View {
    @StateObject private var musicMonitor = MusicMonitor.shared
    @StateObject private var settings = AppSettings.shared
    @State private var isHovering = false
    weak var window: NotchOverlayWindow?
    
    var body: some View {
        ZStack {
            // Semi-transparent black background
            Color.black.opacity(0.85)
            
            if isHovering {
                expandedView
            } else {
                compactView
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: isHovering ? 20 : 16))
        .overlay(
            RoundedRectangle(cornerRadius: isHovering ? 20 : 16)
                .stroke(Color.white.opacity(0.3), lineWidth: 1)
        )
        .onHover { hovering in
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                isHovering = hovering
            }
            
            if hovering {
                window?.expand()
            } else {
                window?.collapse()
            }
        }
    }
    
    private var compactView: some View {
        HStack(spacing: 12) {
            if musicMonitor.isPlaying {
                WaveformView(isCompact: true)
                    .frame(width: 200, height: 24)
            } else {
                // Show a visible indicator when no music is playing
                HStack(spacing: 4) {
                    Circle()
                        .fill(Color.white.opacity(0.4))
                        .frame(width: 6, height: 6)
                    Text("OpenNotch")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.5))
                }
            }
            
            Spacer()
            
            PrivacyIndicator()
        }
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var expandedView: some View {
        VStack(spacing: 16) {
            HStack {
                Spacer()
                PrivacyIndicator()
                    .padding(.trailing, 8)
            }
            
            if musicMonitor.isPlaying {
                VStack(spacing: 12) {
                    if let artwork = musicMonitor.currentArtwork {
                        Image(nsImage: artwork)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    } else {
                        Image(systemName: "music.note")
                            .font(.system(size: 40))
                            .foregroundColor(.white.opacity(0.6))
                            .frame(width: 80, height: 80)
                    }
                    
                    VStack(spacing: 4) {
                        Text(musicMonitor.currentTrack)
                            .font(.headline)
                            .foregroundColor(.white)
                            .lineLimit(1)
                        
                        Text(musicMonitor.currentArtist)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                            .lineLimit(1)
                    }
                    
                    WaveformView(isCompact: false)
                        .frame(height: 60)
                        .padding(.horizontal, 20)
                }
            } else {
                VStack(spacing: 8) {
                    Image(systemName: "music.note.list")
                        .font(.system(size: 40))
                        .foregroundColor(.white.opacity(0.3))
                    
                    Text("No music playing")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.5))
                }
            }
            
            Spacer()
        }
        .padding()
    }
}
