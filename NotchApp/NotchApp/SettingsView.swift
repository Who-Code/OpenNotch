import SwiftUI
import ServiceManagement

struct SettingsView: View {
    @EnvironmentObject var settings: AppSettings
    
    var body: some View {
        TabView {
            AppearanceSettings()
                .environmentObject(settings)
                .tabItem {
                    Label("Appearance", systemImage: "paintbrush")
                }
            
            BehaviorSettings()
                .environmentObject(settings)
                .tabItem {
                    Label("Behavior", systemImage: "gearshape")
                }
            
            AboutView()
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
        }
        .frame(width: 500, height: 400)
        .padding()
    }
}

struct AppearanceSettings: View {
    @EnvironmentObject var settings: AppSettings
    
    var body: some View {
        Form {
            Section(header: Text("Waveform").font(.headline)) {
                ColorPicker("Waveform Color", selection: $settings.waveformColor)
                
                Picker("Animation Style", selection: $settings.animationStyle) {
                    ForEach(AnimationStyle.allCases) { style in
                        Text(style.rawValue).tag(style)
                    }
                }
            }
            
            Section(header: Text("Notch Size").font(.headline)) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Expanded Width: \(Int(settings.expandedWidth))px")
                    Slider(value: $settings.expandedWidth, in: 300...600, step: 10)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Expanded Height: \(Int(settings.expandedHeight))px")
                    Slider(value: $settings.expandedHeight, in: 80...200, step: 10)
                }
            }
        }
        .formStyle(.grouped)
        .padding()
    }
}

struct BehaviorSettings: View {
    @EnvironmentObject var settings: AppSettings
    
    var body: some View {
        Form {
            Section(header: Text("Startup").font(.headline)) {
                Toggle("Launch at Login", isOn: $settings.launchAtLogin)
                    .onChange(of: settings.launchAtLogin) { newValue in
                        toggleLaunchAtLogin(enabled: newValue)
                    }
            }
            
            Section(header: Text("Information").font(.headline)) {
                Text("OpenNotch runs in the background and displays a visual overlay at the top of your screen.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text("The app shows waveform animations when music is playing and displays privacy indicators when your camera or microphone is in use.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text("100% open source, completely free, and ad-free.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .fontWeight(.semibold)
            }
        }
        .formStyle(.grouped)
        .padding()
    }
    
    private func toggleLaunchAtLogin(enabled: Bool) {
        if #available(macOS 13.0, *) {
            do {
                if enabled {
                    try SMAppService.mainApp.register()
                } else {
                    try SMAppService.mainApp.unregister()
                }
            } catch {
                print("Failed to \(enabled ? "enable" : "disable") launch at login: \(error)")
            }
        }
    }
}

struct AboutView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "waveform")
                .font(.system(size: 60))
                .foregroundColor(.accentColor)
            
            Text("OpenNotch")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Version 1.0")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("The only open source, completely free, ad-free notch app for macOS.")
                .multilineTextAlignment(.center)
                .font(.body)
                .foregroundColor(.secondary)
                .fontWeight(.semibold)
                .padding(.horizontal, 40)
            
            Text("A beautiful notch overlay that displays music playback and privacy indicators.")
                .multilineTextAlignment(.center)
                .font(.body)
                .foregroundColor(.secondary)
                .padding(.horizontal, 40)
            
            Link("GitHub: Who-Code/OpenNotch", destination: URL(string: "https://github.com/Who-Code/OpenNotch")!)
                .font(.caption)
            
            Spacer()
            
            Text("© 2026 OpenNotch - Open Source Project")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}
