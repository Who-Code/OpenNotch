# Quick Start Guide

Get NotchApp up and running in minutes!

## Prerequisites

- macOS 13.0 (Ventura) or later
- Xcode 15.0 or later
- MacBook Pro with notch (2021 or later models)

## Development Setup

### 1. Clone or Open the Project

```bash
cd /Users/robertkeller/Documents/Experiments/MacOsxNotchApp
```

### 2. Open in Xcode

```bash
cd NotchApp
open NotchApp.xcodeproj
```

### 3. Configure Signing

1. Select the **NotchApp** target in Xcode
2. Go to **Signing & Capabilities** tab
3. Select your **Team** from the dropdown
4. Xcode will automatically manage signing

### 4. Build and Run

Press `Cmd + R` or click the **Run** button in Xcode.

### 5. Grant Permissions

On first launch, you'll be prompted to grant:
- **Accessibility** access (for music detection)
- **Automation** access (for Apple Music/Spotify)
- **Camera** access (for privacy indicator)
- **Microphone** access (for privacy indicator)

Grant these permissions in **System Settings > Privacy & Security**.

## Testing the App

### Test Music Visualization

1. Open **Apple Music** or **Spotify**
2. Play a song
3. Watch the waveform animation appear in the notch

### Test Hover Expansion

1. Move your cursor over the notch overlay
2. The notch should expand smoothly
3. You'll see album artwork and track information

### Test Settings

1. Click the **waveform icon** in the menu bar
2. Select **Settings...**
3. Try changing:
   - Waveform color
   - Animation style
   - Expanded dimensions

### Test Privacy Indicator

1. Open an app that uses camera/microphone (FaceTime, Zoom, etc.)
2. An **orange dot** should appear in the notch

## Common Issues

### "NotchApp wants to control Music"
- Click **OK** to allow music playback detection
- This is required for the waveform feature

### Notch overlay not visible
- Ensure you're on a Mac with a notch
- Check that the app is running (menu bar icon visible)
- Try quitting and relaunching

### Music not detected
- Grant Automation permissions in System Settings
- Restart Apple Music or Spotify
- Restart NotchApp

## Project Structure

```
MacOsxNotchApp/
├── NotchApp/                    # Xcode project
│   ├── NotchApp.xcodeproj/     # Project file
│   └── NotchApp/               # Source code
│       ├── NotchAppApp.swift   # App entry point
│       ├── ContentView.swift   # Main UI
│       ├── WaveformView.swift  # Animations
│       ├── MusicMonitor.swift  # Music detection
│       └── ...
├── README.md                    # Full documentation
├── CONTRIBUTING.md              # Contribution guide
├── DEPLOYMENT.md                # App Store guide
└── LICENSE                      # MIT License
```

## Next Steps

- Read [README.md](README.md) for full documentation
- Check [CONTRIBUTING.md](CONTRIBUTING.md) to contribute
- See [DEPLOYMENT.md](DEPLOYMENT.md) for App Store deployment

## Development Tips

### Hot Reload
SwiftUI supports live previews. Use `Cmd + Option + P` to resume preview.

### Debugging
- Use `print()` statements for quick debugging
- Check **Console.app** for system logs
- Use Xcode's debugger for breakpoints

### Clean Build
If you encounter build issues:
```
Product > Clean Build Folder (Cmd + Shift + K)
```

## Getting Help

- Check existing [GitHub Issues](https://github.com/yourusername/NotchApp/issues)
- Read the full [README.md](README.md)
- Review [CONTRIBUTING.md](CONTRIBUTING.md)

Happy coding! 🎉
