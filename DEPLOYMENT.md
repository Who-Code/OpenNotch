# Deployment Guide for OpenNotch

This guide covers building, archiving, and deploying OpenNotch to the Mac App Store.

**OpenNotch** is the only open source, completely free, ad-free notch app for macOS.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Development Build](#development-build)
- [Release Build](#release-build)
- [App Store Preparation](#app-store-preparation)
- [Code Signing](#code-signing)
- [Archiving](#archiving)
- [App Store Submission](#app-store-submission)
- [Post-Submission](#post-submission)
- [Troubleshooting](#troubleshooting)

## Prerequisites

### Required Accounts and Memberships

1. **Apple Developer Account**
   - Enroll at [developer.apple.com](https://developer.apple.com)
   - Cost: $99/year
   - Required for App Store distribution

2. **App Store Connect Access**
   - Access at [appstoreconnect.apple.com](https://appstoreconnect.apple.com)
   - Automatically available with Developer Account

### Required Software

- macOS 13.0 or later
- Xcode 15.0 or later
- Command Line Tools for Xcode
- Valid Apple Developer certificates

### Certificates and Provisioning

1. **Development Certificate**
   - For testing on your own devices
   - Created automatically by Xcode

2. **Distribution Certificate**
   - For App Store submission
   - Must be created in Apple Developer Portal

## Development Build

### Running in Development Mode

1. Open the project in Xcode:
   ```bash
   cd MacOsxNotchApp/NotchApp
   open NotchApp.xcodeproj
   ```

2. Select your development team:
   - Select the NotchApp target
   - Go to "Signing & Capabilities"
   - Choose your team from the dropdown

3. Build and run:
   - Press `Cmd + R` or click the Run button
   - Grant permissions when prompted
   - Test all features thoroughly

### Debug Configuration

The Debug configuration includes:
- Debug symbols
- Verbose logging
- Faster compilation
- No optimization

### Testing Locally

Test these scenarios:
- Launch and quit
- Music playback detection
- Privacy indicators
- Settings persistence
- Hover interactions
- Launch at login

## Release Build

### Preparing for Release

1. **Update Version Numbers**
   
   In Xcode, select the NotchApp target:
   - General tab
   - Update "Version" (e.g., 1.0.0)
   - Update "Build" (e.g., 1)

2. **Update Info.plist**
   
   Verify these keys are set:
   ```xml
   <key>CFBundleShortVersionString</key>
   <string>1.0.0</string>
   <key>CFBundleVersion</key>
   <string>1</string>
   ```

3. **Clean Build Folder**
   ```
   Product > Clean Build Folder (Cmd + Shift + K)
   ```

### Release Configuration

The Release configuration includes:
- Optimized code
- Stripped debug symbols
- Smaller binary size
- Production-ready build

### Building for Release

1. Select the Release scheme:
   - Product > Scheme > Edit Scheme
   - Select "Release" for Run configuration

2. Build the project:
   ```
   Product > Build (Cmd + B)
   ```

3. Verify the build succeeds without warnings

## App Store Preparation

### App Store Connect Setup

1. **Create App Record**
   
   Go to [App Store Connect](https://appstoreconnect.apple.com):
   - Click "My Apps"
   - Click "+" and select "New App"
   - Fill in the details:
     - Platform: macOS
     - Name: OpenNotch
     - Primary Language: English
     - Bundle ID: com.whocode.OpenNotch
     - SKU: opennotch-001

2. **App Information**
   
   Fill in required fields:
   - **Name**: OpenNotch
   - **Subtitle**: Open Source Music Visualization for Your Notch
   - **Category**: Utilities
   - **Secondary Category**: Music (optional)

3. **Pricing and Availability**
   
   Set your pricing:
   - Free or Paid
   - Available territories
   - Release date

4. **App Privacy**
   
   Declare data collection:
   - OpenNotch does not collect any data
   - Select "No, this app does not collect data"
   - Emphasize open source nature and privacy-first approach

### Required Assets

#### App Icon

Create app icons in these sizes:
- 16x16
- 32x32
- 64x64
- 128x128
- 256x256
- 512x512
- 1024x1024

Place in `Assets.xcassets/AppIcon.appiconset/`

#### Screenshots

Required screenshots (minimum 3):
- 1280x800 (or larger)
- Show key features
- Highlight music visualization
- Show settings interface
- Demonstrate privacy indicators

#### App Preview Video (Optional)

- 30 seconds maximum
- Show app in action
- Demonstrate key features

### App Description

Write compelling copy:

**Description** (4000 characters max):
```
OpenNotch - The only open source, completely free, ad-free notch app for macOS!

Transform your MacBook's notch into a beautiful, functional display that shows music visualizations and privacy indicators.

FEATURES:
• Beautiful waveform animations that respond to your music
• Multiple animation styles: Bars, Wave, Circular, and Pulse
• Privacy indicators for camera and microphone usage
• Customizable colors and sizes
• Seamless integration with the hardware notch
• Support for Apple Music
• Launch at login option

OPEN SOURCE & PRIVACY FIRST:
OpenNotch is 100% open source and respects your privacy. All processing happens locally on your device. No data is collected or transmitted. No ads, no tracking, no subscriptions.

Source code: https://github.com/Who-Code/OpenNotch

REQUIREMENTS:
• macOS 13.0 or later
• MacBook Pro with notch (2021 or later)

Transform your notch today!
```

**Keywords** (100 characters max):
```
notch,music,visualizer,waveform,privacy,open source,free,utility,menubar
```

**What's New** (4000 characters max):
```
Initial release of OpenNotch - the only open source notch app!

• Music visualization with 4 animation styles
• Privacy indicators for camera and microphone
• Fully customizable appearance
• Launch at login support
• Support for Apple Music
```

## Code Signing

### Setting Up Code Signing

1. **Create Certificates**
   
   In Xcode:
   - Xcode > Preferences > Accounts
   - Select your Apple ID
   - Click "Manage Certificates"
   - Click "+" and select "Apple Distribution"

2. **Configure Signing**
   
   In project settings:
   - Select NotchApp target
   - Go to "Signing & Capabilities"
   - Check "Automatically manage signing"
   - Select your team
   - Verify "Apple Distribution" certificate is selected

3. **Verify Entitlements**
   
   Check `NotchApp.entitlements`:
   ```xml
   <key>com.apple.security.app-sandbox</key>
   <true/>
   <key>com.apple.security.device.audio-input</key>
   <true/>
   <key>com.apple.security.device.camera</key>
   <true/>
   <key>com.apple.security.automation.apple-events</key>
   <true/>
   ```

### Hardened Runtime

Enable Hardened Runtime:
- Select NotchApp target
- Go to "Signing & Capabilities"
- Verify "Hardened Runtime" is enabled
- Check required exceptions if needed

## Archiving

### Creating an Archive

1. **Select Generic Mac Destination**
   
   In Xcode:
   - Select "Any Mac" from the destination menu

2. **Archive the App**
   ```
   Product > Archive
   ```
   
   Wait for the archive to complete (may take several minutes)

3. **Organizer Window**
   
   The Organizer window opens automatically:
   - Shows your archive
   - Displays version and build number
   - Ready for distribution

### Validating the Archive

Before submission, validate:

1. Click "Validate App"
2. Select your distribution certificate
3. Choose "Upload" for distribution method
4. Wait for validation to complete
5. Fix any errors or warnings

Common validation issues:
- Missing icons
- Invalid entitlements
- Code signing errors
- Missing privacy descriptions

## App Store Submission

### Uploading to App Store Connect

1. **Distribute App**
   
   In Organizer:
   - Select your archive
   - Click "Distribute App"
   - Choose "App Store Connect"
   - Click "Upload"

2. **Upload Options**
   
   Select:
   - ✅ Include bitcode: No (not applicable for macOS)
   - ✅ Upload symbols: Yes
   - ✅ Manage version and build number: Yes

3. **Wait for Processing**
   
   - Upload takes 5-15 minutes
   - Processing takes 10-30 minutes
   - You'll receive an email when complete

### Submitting for Review

1. **Go to App Store Connect**
   
   - Navigate to your app
   - Go to the version you want to submit

2. **Complete App Information**
   
   Ensure all required fields are filled:
   - App description
   - Screenshots
   - Keywords
   - Support URL
   - Marketing URL (optional)
   - Privacy Policy URL

3. **Select Build**
   
   - In the "Build" section
   - Click "+" to select a build
   - Choose your uploaded build

4. **App Review Information**
   
   Provide:
   - Contact information
   - Demo account (if needed)
   - Notes for reviewer:
     ```
     OpenNotch is an open source utility that overlays the MacBook notch.
     
     To test:
     1. Launch the app
     2. Grant requested permissions
     3. Play music in Apple Music or Spotify
     4. Hover over the notch to see expanded view
     5. Click menu bar icon to access settings
     
     Note: Best tested on a MacBook Pro with notch.
     ```

5. **Submit for Review**
   
   - Review all information
   - Click "Submit for Review"
   - Wait for Apple's review (typically 24-48 hours)

## Post-Submission

### Review Process

**Timeline:**
- Waiting for Review: 1-2 days
- In Review: Few hours to 1 day
- Total: 1-3 days typically

**Status Updates:**
- Waiting for Review
- In Review
- Pending Developer Release
- Ready for Sale
- Rejected (if issues found)

### If Rejected

1. **Read Rejection Reasons**
   - Check App Store Connect
   - Review detailed feedback

2. **Common Rejection Reasons**
   - Crashes or bugs
   - Missing functionality
   - Privacy issues
   - Misleading description
   - Guideline violations

3. **Fix and Resubmit**
   - Address all issues
   - Create new build
   - Upload and resubmit
   - Respond to reviewer notes

### After Approval

1. **Release Options**
   
   Choose when to release:
   - Automatically after approval
   - Manual release
   - Scheduled release

2. **Monitor Reviews**
   
   - Check user reviews regularly
   - Respond to feedback
   - Plan updates based on feedback

3. **Analytics**
   
   Track in App Store Connect:
   - Downloads
   - Crashes
   - Usage metrics
   - User engagement

## Troubleshooting

### Build Issues

**"No signing certificate found"**
- Solution: Create distribution certificate in Developer Portal
- Xcode > Preferences > Accounts > Manage Certificates

**"Provisioning profile doesn't include entitlements"**
- Solution: Regenerate provisioning profile
- Enable required capabilities in App ID

**"Archive failed"**
- Solution: Clean build folder and try again
- Check for code errors
- Verify all dependencies are available

### Upload Issues

**"Invalid binary"**
- Solution: Check entitlements and Info.plist
- Verify bundle identifier matches App Store Connect
- Ensure all required icons are included

**"Missing compliance"**
- Solution: Declare encryption usage
- If using standard encryption, select "No" for export compliance

**"Invalid signature"**
- Solution: Verify code signing settings
- Ensure distribution certificate is valid
- Check that all frameworks are signed

### Validation Issues

**"Missing required icon"**
- Solution: Add all required icon sizes to Assets.xcassets
- Use Icon Set Creator or similar tool

**"Missing privacy descriptions"**
- Solution: Add all required usage descriptions to Info.plist
- Include NSCameraUsageDescription, NSMicrophoneUsageDescription

**"App sandbox not enabled"**
- Solution: Enable App Sandbox in entitlements
- Add required entitlements for functionality

## Continuous Deployment

### Automating Builds

Consider using:
- Xcode Cloud
- GitHub Actions
- Fastlane

### Version Management

Best practices:
- Use semantic versioning (MAJOR.MINOR.PATCH)
- Increment build number for each upload
- Tag releases in Git
- Maintain changelog

### Update Strategy

Plan regular updates:
- Bug fixes: As needed
- Minor features: Monthly
- Major features: Quarterly
- macOS compatibility: With each macOS release

## Additional Resources

- [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- [App Store Connect Help](https://help.apple.com/app-store-connect/)
- [Xcode Documentation](https://developer.apple.com/documentation/xcode)
- [Code Signing Guide](https://developer.apple.com/support/code-signing/)

## Support

For deployment issues:
- Check Apple Developer Forums
- Contact Apple Developer Support
- Review App Store Connect documentation

---

Good luck with your App Store submission! 🚀
