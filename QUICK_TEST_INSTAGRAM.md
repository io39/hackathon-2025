# 🚀 Quick Test: Instagram Share

## Prerequisites
- [ ] iPhone connected via USB or on same Wi-Fi
- [ ] Backend running on your Mac (`cd backend && ./start.sh`)
- [ ] Know your Mac's IP address

## Find Your Mac's IP Address
```bash
ipconfig getifaddr en0
# Example output: 10.10.131.31
```

## Update Backend URL (if needed)
Edit `flutter_app/ios/MyAppShareExtension/ShareViewController.swift` line 10:
```swift
private let backendURL = "http://YOUR_MAC_IP:8000"
```

## Build & Install on iPhone

### Method 1: Using Xcode
```bash
cd "/Users/frantisek/hackaton 2025 telcom/flutter_app"
open ios/Runner.xcworkspace
```
Then in Xcode:
1. Select your iPhone
2. Click ▶️ Play button

### Method 2: Using Flutter
```bash
cd "/Users/frantisek/hackaton 2025 telcom/flutter_app"
flutter run --release
```

## Test in Instagram

1. Open **Instagram** app
2. Go to any **post or reel**
3. Tap the **Share** button (paper airplane icon)
4. Look for **"Video Analyzer"** in the app list
5. Tap it → Should open your extension!

## Expected Behavior

✅ Extension opens with dark theme bottom sheet  
✅ Shows "Analyze Video" title  
✅ Shows three colorful buttons:
   - 🛡️ Hoax Check (red)
   - 💡 Explain This (yellow)
   - 🌟 Expand This Idea (cyan)

✅ Tap a button → Shows "Analyzing..." with spinner  
✅ Results appear in text view  
✅ "Done" button closes the extension

## Quick Troubleshooting

### App doesn't appear in Instagram share sheet
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run --release
```

### Backend connection fails
- Check backend is running: `http://YOUR_IP:8000` should work in browser
- iPhone and Mac must be on **same Wi-Fi**
- Disable any VPN on Mac or iPhone

### "Code Signing Error"
In Xcode:
1. Select "Runner" target → Signing & Capabilities
2. Select "MyAppShareExtension" target → Signing & Capabilities  
3. Choose your Apple ID for both
4. Check "Automatically manage signing"

## Debugging

### View logs from iPhone:
```bash
# In flutter_app directory:
flutter logs
```

### View extension-specific logs:
```bash
idevicesyslog | grep "SHARE EXTENSION"
```

## What You Should See in Logs

```
[SHARE EXTENSION] Processing 1 attachments
[SHARE EXTENSION] ✓ Received URL: https://www.instagram.com/...
[SHARE EXTENSION] Sending to backend: http://10.10.131.31:8000/api/video
[SHARE EXTENSION] ✓ Video received by backend
```

When you tap an action:
```
[SHARE EXTENSION] Analyzing with action: hoax_check
[SHARE EXTENSION] Waiting for backend response...
[SHARE EXTENSION] ✓ Analysis complete (1234 chars)
```

## Success Criteria

- ✅ App appears in Instagram share sheet
- ✅ Tapping it opens your custom UI
- ✅ URL is extracted from Instagram post
- ✅ Backend receives the request
- ✅ Analysis works and shows results
- ✅ User can close and return to Instagram

## Next Steps After Success

1. Test with different Instagram content types:
   - Regular posts
   - Reels
   - Stories
   - IGTV videos

2. Test with other apps:
   - TikTok
   - YouTube
   - Safari (any video page)

3. Customize the UI/branding in ShareViewController.swift

---

**Need help?** Check the full guide: `INSTAGRAM_SHARE_SETUP.md`

