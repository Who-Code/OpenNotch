# Contributing to NotchApp

Thank you for your interest in contributing to NotchApp! This document provides guidelines and instructions for contributing to the project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Project Structure](#project-structure)
- [Development Workflow](#development-workflow)
- [Coding Standards](#coding-standards)
- [Testing](#testing)
- [Submitting Changes](#submitting-changes)
- [Reporting Bugs](#reporting-bugs)
- [Feature Requests](#feature-requests)

## Code of Conduct

By participating in this project, you agree to maintain a respectful and inclusive environment for all contributors.

## Getting Started

### Prerequisites

- macOS 13.0 (Ventura) or later
- Xcode 15.0 or later
- Git
- A Mac with a notch (for testing the full experience)

### Fork and Clone

1. Fork the repository on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/yourusername/NotchApp.git
   cd NotchApp
   ```

3. Add the upstream repository:
   ```bash
   git remote add upstream https://github.com/originalowner/NotchApp.git
   ```

## Development Setup

### Opening the Project

1. Navigate to the project directory:
   ```bash
   cd MacOsxNotchApp/NotchApp
   ```

2. Open the Xcode project:
   ```bash
   open NotchApp.xcodeproj
   ```

### Building the Project

1. In Xcode, select the NotchApp scheme
2. Choose your Mac as the destination
3. Press `Cmd + B` to build or `Cmd + R` to build and run

### First Build

On first build, you may need to:
1. Select your development team in the project settings
2. Update the bundle identifier if necessary
3. Grant permissions when prompted during runtime

## Project Structure

```
NotchApp/
├── NotchApp.xcodeproj/          # Xcode project file
└── NotchApp/                    # Source code
    ├── NotchAppApp.swift        # App entry point and delegate
    ├── AppSettings.swift        # User settings and preferences
    ├── NotchOverlayWindow.swift # Main overlay window
    ├── ContentView.swift        # Main content view
    ├── WaveformView.swift       # Waveform animations
    ├── MusicMonitor.swift       # Music playback detection
    ├── PrivacyIndicator.swift   # Camera/mic indicator
    ├── SettingsView.swift       # Settings interface
    ├── Assets.xcassets/         # App assets and icons
    ├── Info.plist               # App configuration
    └── NotchApp.entitlements    # App capabilities
```

### Key Components

#### NotchAppApp.swift
- App lifecycle management
- Status bar menu setup
- Window initialization

#### NotchOverlayWindow.swift
- Custom NSWindow subclass
- Handles window positioning and behavior
- Manages expand/collapse animations

#### MusicMonitor.swift
- Monitors Apple Music and Spotify
- Uses AppleScript for playback information
- Publishes music state changes

#### PrivacyIndicator.swift
- Monitors camera and microphone usage
- Displays orange dot indicator
- Uses system APIs for detection

#### WaveformView.swift
- Renders animated waveforms
- Supports multiple animation styles
- Customizable colors and effects

#### AppSettings.swift
- Manages user preferences
- Persists settings to UserDefaults
- Observable object for SwiftUI

## Development Workflow

### Branching Strategy

- `main` - Stable release branch
- `develop` - Development branch
- `feature/feature-name` - Feature branches
- `bugfix/bug-name` - Bug fix branches
- `hotfix/issue-name` - Urgent fixes

### Creating a Feature Branch

```bash
git checkout develop
git pull upstream develop
git checkout -b feature/your-feature-name
```

### Making Changes

1. Make your changes in your feature branch
2. Test thoroughly on your local machine
3. Commit your changes with clear, descriptive messages:
   ```bash
   git add .
   git commit -m "Add feature: description of what you added"
   ```

### Commit Message Guidelines

Follow this format:
```
<type>: <subject>

<body>

<footer>
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

Example:
```
feat: Add circular waveform animation style

Implemented a new circular animation style that displays
concentric rings pulsing to the music beat.

Closes #123
```

## Coding Standards

### Swift Style Guide

- Follow Apple's [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- Use 4 spaces for indentation (not tabs)
- Maximum line length: 120 characters
- Use meaningful variable and function names
- Add documentation comments for public APIs

### SwiftUI Best Practices

- Use `@StateObject` for owned objects
- Use `@ObservedObject` for passed objects
- Use `@EnvironmentObject` for shared state
- Keep views small and focused
- Extract complex views into separate files

### Code Organization

- Group related functionality together
- Use `// MARK: -` comments to organize code sections
- Keep files under 500 lines when possible
- One type per file (with exceptions for small helper types)

### Example Code Style

```swift
// MARK: - Properties

@StateObject private var musicMonitor = MusicMonitor.shared
@State private var isExpanded = false

// MARK: - Body

var body: some View {
    ZStack {
        backgroundView
        contentView
    }
    .onAppear {
        setupView()
    }
}

// MARK: - Private Methods

private func setupView() {
    // Implementation
}
```

## Testing

### Manual Testing Checklist

Before submitting a PR, test the following:

- [ ] App launches successfully
- [ ] Notch overlay appears in correct position
- [ ] Music playback detection works (Apple Music)
- [ ] Music playback detection works (Spotify)
- [ ] Waveform animations display correctly
- [ ] Hover expansion/collapse works smoothly
- [ ] Privacy indicator shows when camera/mic active
- [ ] Settings can be opened and modified
- [ ] Settings persist after app restart
- [ ] Launch at login can be toggled
- [ ] App quits cleanly
- [ ] No memory leaks during extended use

### Testing on Different Macs

If possible, test on:
- MacBook Pro 14" (2021+)
- MacBook Pro 16" (2021+)
- Different macOS versions (13.0+)

## Submitting Changes

### Pull Request Process

1. Update your branch with the latest changes:
   ```bash
   git checkout develop
   git pull upstream develop
   git checkout your-feature-branch
   git rebase develop
   ```

2. Push your changes to your fork:
   ```bash
   git push origin your-feature-branch
   ```

3. Create a Pull Request on GitHub:
   - Use a clear, descriptive title
   - Reference any related issues
   - Provide a detailed description of changes
   - Include screenshots/videos if applicable
   - List any breaking changes

### PR Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Tested on macOS 13.x
- [ ] Tested on macOS 14.x
- [ ] Manual testing completed
- [ ] No regressions found

## Screenshots
If applicable, add screenshots

## Related Issues
Closes #issue_number
```

### Code Review

- Be responsive to feedback
- Make requested changes promptly
- Keep discussions professional and constructive
- Update your PR based on review comments

## Reporting Bugs

### Before Reporting

1. Check existing issues to avoid duplicates
2. Test with the latest version
3. Verify it's not a configuration issue

### Bug Report Template

```markdown
**Describe the Bug**
Clear description of the bug

**To Reproduce**
Steps to reproduce:
1. Go to '...'
2. Click on '...'
3. See error

**Expected Behavior**
What you expected to happen

**Screenshots**
If applicable, add screenshots

**Environment:**
- macOS Version: [e.g., 13.5]
- Mac Model: [e.g., MacBook Pro 14" 2021]
- NotchApp Version: [e.g., 1.0.0]

**Additional Context**
Any other relevant information
```

## Feature Requests

We welcome feature requests! Please:

1. Check if the feature has already been requested
2. Provide a clear use case
3. Explain why this feature would be valuable
4. Consider implementation complexity

### Feature Request Template

```markdown
**Feature Description**
Clear description of the feature

**Use Case**
Why is this feature needed?

**Proposed Solution**
How should this work?

**Alternatives Considered**
Other approaches you've thought about

**Additional Context**
Mockups, examples, or references
```

## Development Tips

### Debugging

- Use `print()` statements for quick debugging
- Use Xcode's debugger for complex issues
- Check Console.app for system logs
- Use Instruments for performance profiling

### Common Issues

**Window not appearing:**
- Check window level settings
- Verify collection behavior
- Ensure screen coordinates are correct

**Music detection not working:**
- Verify AppleScript permissions
- Check for syntax errors in scripts
- Test scripts in Script Editor

**Performance issues:**
- Profile with Instruments
- Check for retain cycles
- Optimize animation frame rates

### Useful Resources

- [Apple Developer Documentation](https://developer.apple.com/documentation/)
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [AppKit Documentation](https://developer.apple.com/documentation/appkit)
- [Swift Forums](https://forums.swift.org/)

## Questions?

If you have questions about contributing:
- Open a discussion on GitHub
- Check existing documentation
- Review closed issues for similar questions

Thank you for contributing to NotchApp! 🎉
