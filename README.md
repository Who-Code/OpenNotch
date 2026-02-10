# NotchApp

A beautiful macOS utility application that enhances your notch experience with music visualization and privacy indicators.

![macOS](https://img.shields.io/badge/macOS-13.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

## Features

- 🎵 **Music Visualization**: Beautiful waveform animations that respond to music playback from Apple Music and Spotify
- 🔒 **Privacy Indicators**: Orange dot indicator when camera or microphone is accessed
- 🎨 **Customizable Appearance**: Choose from multiple animation styles and customize colors
- 📏 **Adjustable Size**: Configure the expanded notch dimensions to your preference
- 🚀 **Launch at Startup**: Automatically start NotchApp when you log in
- 🖤 **Seamless Integration**: Black background that blends perfectly with the hardware notch
- 🎯 **Hover Interaction**: Expand the notch on hover to see current song information

## Screenshots

### Compact View
The notch overlay in its compact state, showing waveform animation when music is playing.

### Expanded View
Hover over the notch to see album artwork, track name, and artist information.

### Settings
Customize colors, animation styles, and notch dimensions.

## Requirements

- macOS 13.0 (Ventura) or later
- Mac with a notch (MacBook Pro 14" or 16" 2021+)
- Xcode 15.0 or later (for development)

## Installation

### From Release (Coming Soon)

1. Download the latest release from the [Releases](https://github.com/yourusername/NotchApp/releases) page
2. Open the `.dmg` file
3. Drag NotchApp to your Applications folder
4. Launch NotchApp from Applications
5. Grant necessary permissions when prompted

### Building from Source

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed build instructions.

## Usage

### First Launch

1. Launch NotchApp from your Applications folder
2. The app will appear in your menu bar with a waveform icon
3. Grant permissions for:
   - Accessibility (for detecting music playback)
   - Automation (for Apple Music/Spotify integration)
   - Camera/Microphone (for privacy indicators)

### Menu Bar

Click the NotchApp icon in the menu bar to access:
- **Settings**: Customize appearance and behavior
- **Quit**: Exit the application

### Settings

#### Appearance Tab
- **Waveform Color**: Choose any color for the waveform animation
- **Animation Style**: Select from Bars, Wave, Circular, or Pulse animations
- **Expanded Width**: Adjust the width when hovering (300-600px)
- **Expanded Height**: Adjust the height when hovering (80-200px)

#### Behavior Tab
- **Launch at Login**: Automatically start NotchApp when you log in

### Supported Music Players

- Apple Music
- Spotify
- Any media player that broadcasts playback information

## Privacy

NotchApp respects your privacy:
- No data is collected or transmitted
- All processing happens locally on your device
- Camera and microphone permissions are only used to detect when they're active
- Music information is read from system notifications

## Troubleshooting

### The notch overlay doesn't appear
- Ensure you're using a Mac with a notch
- Check that NotchApp is running (look for the icon in the menu bar)
- Try quitting and relaunching the app

### Music information not showing
- Make sure Apple Music or Spotify is running
- Grant Automation permissions in System Settings > Privacy & Security > Automation
- Restart the music player and NotchApp

### Privacy indicator not working
- Grant Camera and Microphone permissions in System Settings > Privacy & Security
- Note: The indicator shows when apps are actively using these devices

### Launch at login not working
- Check System Settings > General > Login Items
- Ensure NotchApp is listed and enabled
- On macOS 13+, this should be managed automatically

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## App Store Deployment

For information on deploying to the Mac App Store, see [DEPLOYMENT.md](DEPLOYMENT.md).

## Roadmap

- [ ] Support for additional music players
- [ ] More animation styles
- [ ] Customizable keyboard shortcuts
- [ ] Widget support for macOS 14+
- [ ] Dynamic Island-style interactions

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Inspired by the iPhone Dynamic Island
- Built with SwiftUI and AppKit
- Icons from SF Symbols

## Support

If you encounter any issues or have questions:
- Open an issue on [GitHub](https://github.com/yourusername/NotchApp/issues)
- Check existing issues for solutions
- Read the documentation thoroughly

## Changelog

### Version 1.0.0 (Initial Release)
- Music visualization with multiple animation styles
- Privacy indicators for camera/microphone
- Customizable appearance
- Launch at login support
- Settings interface
- Support for Apple Music and Spotify

---

Made with ❤️ for macOS
