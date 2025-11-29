# Instagram Share Extension Setup Guide

## ✅ What's Already Configured

Your app is now configured to appear in Instagram's share sheet! Here's what I've set up:

### 1. Share Extension Created
- Location: `flutter_app/ios/MyAppShareExtension/`
- Files configured:
  - `ShareViewController.swift` - Handles shared content
  - `Info.plist` - Activation rules (what content types trigger your app)
  - `MyAppShareExtension.entitlements` - App group for data sharing

### 2. Activation Rules Configured
Your app will now appear when sharing:
- ✅ Images (Instagram posts/stories)
- ✅ Videos (Instagram reels/videos)
- ✅ URLs (Instagram post links)
- ✅ Text (captions, descriptions)
- ✅ Files

### 3. App Group Configured
- Group ID: `group.com.videoanalyzer.shared`
- Allows main app and extension to share data

## 🚀 How to Test on Your iPhone

### Step 1: Build and Install the App

#### Option A: Using Xcode (Recommended)
1. Open Terminal and navigate to your project:
   ```bash
   cd "/Users/frantisek/hackaton 2025 telcom/flutter_app"
   ```

2. Open the iOS project in Xcode:
   ```bash
   open ios/Runner.xcworkspace
   ```

3. In Xcode:
   - Connect your iPhone via USB
   - Select your iPhone from the device dropdown (top toolbar)
   - Click on "Runner" in the project navigator (left sidebar)
   - Go to "Signing & Capabilities" tab
   - Select your Apple Developer account for both:
     - **Runner** target
     - **MyAppShareExtension** target
   - Change the bundle identifier if needed (e.g., to include your team ID)

4. Click the **Play** button (▶️) in Xcode to build and install

#### Option B: Using Flutter Command
```bash
cd "/Users/frantisek/hackaton 2025 telcom/flutter_app"
flutter run --release
```

### Step 2: Test in Instagram

1. **Open Instagram** on your iPhone

2. **Navigate to any post or reel** you want to share

3. **Tap the Share button** (paper airplane icon in the bottom right)

4. **Look for "Video Analyzer"** in the share sheet
   - It might be in the "More" section initially
   - Scroll horizontally through the app icons
   - If you don't see it, tap "More" (three dots) to see all available apps

5. **Tap "Video Analyzer"** - your extension should open with a beautiful bottom sheet showing:
   - 🛡️ Hoax Check
   - 💡 Explain This  
   - 🌟 Expand This Idea

### Step 3: Verify It Works

1. When you tap Video Analyzer from Instagram, the extension should:
   - Extract the Instagram post URL
   - Send it to your backend (make sure backend is running!)
   - Show the three analysis options

2. Choose an analysis option and verify:
   - The loading indicator appears
   - Results are displayed
   - You can close the extension

## 🔧 Troubleshooting

### "Video Analyzer" doesn't appear in Instagram share sheet

**Solution 1: Check Bundle Identifiers**
The extension bundle ID must be: `{main_app_bundle_id}.MyAppShareExtension`

Example:
- Main app: `com.videoanalyzer.videoAnalyzer`
- Extension: `com.videoanalyzer.videoAnalyzer.MyAppShareExtension`

**Solution 2: Reinstall the App**
```bash
# Delete the app from your iPhone manually, then:
flutter clean
flutter run --release
```

**Solution 3: Check Signing**
In Xcode:
1. Select "Runner" target → Signing & Capabilities
2. Select "MyAppShareExtension" target → Signing & Capabilities
3. Make sure both have valid signing certificates
4. Make sure "Automatically manage signing" is checked

**Solution 4: Reset Share Sheet Cache**
Sometimes iOS caches the available extensions. Try:
1. Delete the app from your iPhone
2. Restart your iPhone
3. Reinstall the app

### Extension opens but doesn't receive the URL

Check the `ShareViewController.swift` logs:
```bash
# While iPhone is connected, run:
xcrun simctl spawn booted log stream --predicate 'subsystem contains "com.videoanalyzer"'
```

### Backend connection fails

Make sure:
1. Your backend is running on your Mac
2. Your iPhone and Mac are on the **same Wi-Fi network**
3. Update the backend URL in `ShareViewController.swift` (line 10):
   ```swift
   private let backendURL = "http://YOUR_MAC_IP:8000"
   ```
4. Find your Mac's IP:
   ```bash
   ipconfig getifaddr en0  # For Ethernet
   # or
   ifconfig | grep "inet " | grep -v 127.0.0.1
   ```

## 📱 What Happens When User Shares from Instagram

1. **User taps share** on Instagram post/reel
2. **Instagram shows share sheet** with available apps
3. **User taps "Video Analyzer"**
4. **Your extension opens** (ShareViewController)
5. **Extension extracts** the Instagram URL/content
6. **Extension sends** URL to your backend (`/api/video`)
7. **Extension shows** three action buttons
8. **User chooses** an action (Hoax Check, Explain This, or Expand Idea)
9. **Extension sends** analysis request to backend (`/api/analyze`)
10. **Extension displays** results in a text view
11. **User taps "Done"** to return to Instagram

## 🎨 Customization Options

### Change the Display Name
Edit `flutter_app/ios/MyAppShareExtension/Info.plist`:
```xml
<key>CFBundleDisplayName</key>
<string>Your Custom Name</string>
```

### Change Activation Rules (What Content Types Show Your App)
Edit the `NSExtensionActivationRule` in Info.plist to only show for specific types:
- Remove `NSExtensionActivationSupportsImageWithMaxCount` to hide from images
- Remove `NSExtensionActivationSupportsText` to hide from text
- Keep only `NSExtensionActivationSupportsWebURLWithMaxCount` for URLs only

### Update Backend URL
Edit `flutter_app/ios/MyAppShareExtension/ShareViewController.swift`:
```swift
private let backendURL = "http://YOUR_NEW_URL:8000"
```

## ✨ Key Files Reference

- **Extension Code**: `flutter_app/ios/MyAppShareExtension/ShareViewController.swift`
- **Extension Config**: `flutter_app/ios/MyAppShareExtension/Info.plist`
- **Extension Entitlements**: `flutter_app/ios/MyAppShareExtension/MyAppShareExtension.entitlements`
- **Main App Entitlements**: `flutter_app/ios/Runner/Runner.entitlements`
- **Xcode Project**: `flutter_app/ios/Runner.xcodeproj/project.pbxproj`

## 🔍 Debugging Tips

### View Extension Logs on Device
```bash
# Connect iPhone via USB, then:
idevicesyslog | grep "SHARE EXTENSION"
```

### View All Logs
```bash
# In Xcode:
Window → Devices and Simulators → Select your iPhone → View Device Logs
```

### Test Without Instagram
You can test the extension from Safari:
1. Open Safari on your iPhone
2. Navigate to any YouTube/TikTok video
3. Tap the Share button
4. Look for "Video Analyzer"
5. This verifies the extension works without Instagram

## 📝 Important Notes

- **Backend must be running** for the extension to work
- **Mac and iPhone** must be on the same network
- **First time setup** may require iOS permissions
- **Extension runs separately** from the main Flutter app
- Changes to extension code require **rebuilding in Xcode**

## 🎯 Next Steps

1. ✅ Build and install the app on your iPhone
2. ✅ Make sure your backend is running
3. ✅ Update the backend IP in ShareViewController.swift if needed
4. ✅ Open Instagram and test sharing a post
5. ✅ Debug any issues using the troubleshooting section

Your app should now appear in Instagram's share sheet! 🎉

