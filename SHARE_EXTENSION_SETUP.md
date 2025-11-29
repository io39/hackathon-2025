# iOS Share Extension Setup Guide

## 🎯 What This Does

When you share an Instagram/TikTok/YouTube post, your app will:
1. ✅ Appear in the iOS share sheet
2. ✅ Open as a bottom sheet overlay (like a widget from below)
3. ✅ Show the 4 analysis options
4. ✅ Process the video and show results
5. ✅ All without leaving Instagram!

## 📱 How It Works on iOS

When you tap "Share" on Instagram:
```
Instagram Post
   ↓ Tap Share
Share Sheet appears (iOS system)
   ↓ Your app appears here
Tap "Video Analyzer"
   ↓
Bottom sheet slides up ⬆️
Shows your 4 analysis options
   ↓
Select option → Shows result
   ↓
Tap "Done" → Back to Instagram
```

## 🛠️ Setup Steps (In Xcode)

### Step 1: Open Project in Xcode

```bash
cd "/Users/frantisek/hackaton 2025 telcom/flutter_app"
open ios/Runner.xcworkspace
```

**Important:** Open `.xcworkspace` NOT `.xcodeproj`!

### Step 2: Add Share Extension Target

1. In Xcode menu: **File → New → Target...**
2. Select **iOS** tab
3. Find and select **Share Extension**
4. Click **Next**
5. Configure:
   - **Product Name:** `ShareExtension`
   - **Team:** Select your team
   - **Language:** Swift
   - **Project:** Runner
   - **Embed in Application:** Runner
6. Click **Finish**
7. When asked "Activate 'ShareExtension' scheme?", click **Activate**

### Step 3: Configure App Groups

App Groups allow the Share Extension to communicate with your main app.

**For Main App (Runner):**
1. Select **Runner** target
2. Go to **Signing & Capabilities** tab
3. Click **+ Capability**
4. Add **App Groups**
5. Click **+** to add a new group
6. Name it: `group.com.videoanalyzer.shared`
7. Make sure it's checked ✓

**For Share Extension:**
1. Select **ShareExtension** target
2. Go to **Signing & Capabilities** tab
3. Click **+ Capability**
4. Add **App Groups**
5. Click the existing group: `group.com.videoanalyzer.shared`
6. Make sure it's checked ✓

### Step 4: Replace Share Extension Files

I've created the files for you. Replace the default files:

**ShareViewController.swift location:**
`ios/ShareExtension/ShareViewController.swift`

**Info.plist location:**
`ios/ShareExtension/Info.plist`

### Step 5: Update Main App Info.plist

Add URL scheme to main app's Info.plist (`ios/Runner/Info.plist`):

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>videoanalyzer</string>
        </array>
    </dict>
</array>
```

### Step 6: Build and Run

1. Select your iPhone from device dropdown
2. Select **ShareExtension** scheme (top bar)
3. Click **Run** (▶️ button)
4. Xcode will install the extension
5. Go to Instagram on your phone
6. Share a post
7. Look for "Video Analyzer" in share sheet!

## 📁 Files Created

```
flutter_app/ios/
├── ShareExtension/
│   ├── ShareViewController.swift     ← Main extension code
│   ├── Info.plist                    ← Extension configuration
│   └── MainInterface.storyboard      ← UI (auto-generated)
└── Runner/
    └── Info.plist                    ← Updated with URL scheme
```

## 🎨 What the User Sees

### 1. Share from Instagram
```
[Instagram Post]
  ↓ Tap Share button
[Share Sheet appears]
  - WhatsApp
  - Messages
  - Video Analyzer ← Your app!
  - More...
```

### 2. Tap Your App
```
[Bottom sheet slides up from bottom]
╔════════════════════════════╗
║  Analyze Video             ║
║                            ║
║  🛡️  Hoax Check           ║
║  💡  Explain This          ║
║  🌟  Expand This Idea      ║
║  ❓  Custom Question       ║
║                            ║
║  [Cancel]                  ║
╚════════════════════════════╝
```

### 3. Select Option & See Result
```
╔════════════════════════════╗
║  Analyzing...              ║
║  [Loading spinner]         ║
╚════════════════════════════╝
   ↓ 2 seconds
╔════════════════════════════╗
║  ✓ Analysis Complete       ║
║                            ║
║  [Detailed result text]    ║
║                            ║
║  [Done]                    ║
╚════════════════════════════╝
   ↓ Tap Done
[Back to Instagram]
```

## ⚙️ Configuration

### Supported Content Types

The extension is configured to accept:
- ✅ URLs (Instagram, TikTok, YouTube links)
- ✅ Text (copied links)
- ✅ Images (Instagram posts)
- ✅ Videos (video links)

### Backend URL

**Important:** For Share Extension to work on physical iPhone:

Edit `ShareViewController.swift` line ~20:
```swift
let backendURL = "http://YOUR_COMPUTER_IP:8000"
```

Find your IP:
```bash
# Mac:
ifconfig | grep "inet " | grep -v 127.0.0.1

# Example: 192.168.1.100
```

Then use:
```swift
let backendURL = "http://192.168.1.100:8000"
```

## 🔍 Troubleshooting

### Share Extension Not Appearing

1. **Check Build:**
   - In Xcode, make sure ShareExtension built successfully
   - Look for errors in build log

2. **Check App Groups:**
   - Both targets should have same group name
   - Both should have it checked ✓

3. **Reinstall App:**
   ```bash
   # Delete app from iPhone
   # Then in Xcode: Product → Clean Build Folder
   # Then run again
   ```

### "Connection Refused" Error

1. **Backend not running:**
   ```bash
   cd backend
   python app.py
   # Should see: Server running on http://0.0.0.0:8000
   ```

2. **Wrong IP address:**
   - Make sure you're using your computer's IP, not localhost
   - iPhone and computer must be on same WiFi

3. **Firewall blocking:**
   - Temporarily disable firewall to test
   - Or add exception for port 8000

### Extension Crashes

1. **Check Console:**
   - In Xcode: View → Debug Area → Activate Console
   - Look for error messages

2. **Check Logs:**
   - On iPhone: Settings → Privacy → Analytics → Analytics Data
   - Find ShareExtension crash logs

## 🧪 Testing Checklist

- [ ] Extension appears in share sheet
- [ ] Tapping extension opens bottom sheet
- [ ] Can see 4 analysis options
- [ ] "Hoax Check" works and shows result
- [ ] "Explain This" works
- [ ] "Expand Idea" works
- [ ] Custom question works
- [ ] Can close extension and return to Instagram
- [ ] Backend logs show received requests

## 📝 Important Notes

### iOS Limitations

❌ **Cannot do:**
- Show overlay on top of other apps (iOS doesn't allow this)
- Access Instagram app directly
- Run in background indefinitely

✅ **Can do:**
- Appear in share sheet
- Show bottom sheet UI (modal)
- Receive shared URLs
- Send to backend
- Show results

### Permissions

No special permissions needed! Share Extensions are sandboxed and secure.

### App Groups Data

Shared data location:
```swift
let sharedDefaults = UserDefaults(suiteName: "group.com.videoanalyzer.shared")
```

Use this to pass data between extension and main app.

## 🚀 Going Further

### Save History

Store analyzed videos:
```swift
sharedDefaults?.set(analyzedVideos, forKey: "history")
```

Then show in main app!

### Custom UI

Edit `ShareViewController.swift` to customize:
- Colors
- Fonts
- Layout
- Animations

### Background Processing

For longer processing:
```swift
// Use URLSession with background configuration
let config = URLSessionConfiguration.background(withIdentifier: "com.videoanalyzer.bg")
```

## 🎉 You're Ready!

1. ✅ Share Extension created
2. ✅ App Groups configured
3. ✅ Backend URL set
4. ✅ UI customized
5. ✅ Ready to test on iPhone!

**Go try it:** Open Instagram, share a post, and look for "Video Analyzer"! 📱✨


