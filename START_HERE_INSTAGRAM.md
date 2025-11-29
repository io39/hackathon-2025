# 🚀 START HERE: Instagram Share Extension

## Your App is Ready! ✅

I've configured your Flutter app to appear in Instagram's share sheet. Here's everything you need to know:

---

## 📋 Quick Start (Copy & Paste)

### 1. Find Your Mac's IP Address
```bash
ipconfig getifaddr en0
```
**Example output:** `10.10.131.31`

### 2. Update Backend URL (if your IP changed)
Edit this file: `flutter_app/ios/MyAppShareExtension/ShareViewController.swift`

Change line 10 to your IP:
```swift
private let backendURL = "http://YOUR_IP_HERE:8000"
```

### 3. Start Backend
```bash
cd "/Users/frantisek/hackaton 2025 telcom/backend"
./start.sh
```

### 4. Build & Install App
```bash
cd "/Users/frantisek/hackaton 2025 telcom/flutter_app"
flutter run --release
```

**OR** open in Xcode:
```bash
cd "/Users/frantisek/hackaton 2025 telcom/flutter_app"
open ios/Runner.xcworkspace
```
Then click the Play button ▶️

### 5. Test in Instagram
1. Open Instagram app on iPhone
2. Go to any post/reel
3. Tap Share button (📤)
4. Find "Video Analyzer" 
5. Tap it → Your extension opens!

---

## 🎯 What You Should See

**In Instagram's Share Sheet:**
```
[Messages] [Mail] [WhatsApp]
[Video Analyzer] ← Your app!
```

**When You Tap It:**
```
┌─────────────────────┐
│  Analyze Video      │
│                     │
│  🛡️ Hoax Check      │
│  💡 Explain This    │
│  🌟 Expand This     │
│                     │
│     [Done]          │
└─────────────────────┘
```

---

## 📁 Documentation Files

| File | What It Contains |
|------|------------------|
| **INSTAGRAM_SHARE_SUMMARY.md** | Complete overview of setup |
| **QUICK_TEST_INSTAGRAM.md** | Quick test instructions |
| **WHAT_TO_EXPECT.md** | Visual flow and behavior |
| **INSTAGRAM_SHARE_SETUP.md** | Detailed setup guide |
| **INSTAGRAM_CHECKLIST.md** | Testing checklist |
| **THIS FILE** | Quick start reference |

---

## 🔧 Configuration Summary

**What's Configured:**
- ✅ Share Extension created (`MyAppShareExtension`)
- ✅ Xcode project updated with extension target
- ✅ Activation rules set (images, videos, URLs, text)
- ✅ App groups configured for data sharing
- ✅ Deployment target set to iOS 12.0
- ✅ UI designed with dark theme
- ✅ Backend integration ready

**Bundle IDs:**
- Main App: `com.videoanalyzer.videoAnalyzer`
- Extension: `com.videoanalyzer.videoAnalyzer.MyAppShareExtension`

**Display Name:**
- "Video Analyzer"

---

## ⚡ Common Issues & Solutions

### "Video Analyzer" doesn't appear in share sheet
```bash
# Clean and rebuild
flutter clean
flutter run --release
# Also try: Restart iPhone
```

### Backend connection fails
- ✅ Check backend is running: `http://YOUR_IP:8000` in browser
- ✅ iPhone and Mac on **same Wi-Fi**
- ✅ Correct IP in ShareViewController.swift
- ✅ Disable VPN on both devices

### Code signing error in Xcode
1. Select "Runner" target → Signing & Capabilities
2. Select "MyAppShareExtension" target → Signing & Capabilities
3. Choose your Apple ID for both
4. Check "Automatically manage signing"

---

## 📊 How It Works

```
User opens Instagram
     ↓
Taps share on post
     ↓
iOS shows share sheet
     ↓
User taps "Video Analyzer"
     ↓
Extension extracts URL
     ↓
Sends URL to backend (your Mac)
     ↓
Backend processes video
     ↓
Extension shows results
     ↓
User taps "Done" → back to Instagram
```

---

## 🐛 Debugging

**View extension logs:**
```bash
flutter logs | grep "SHARE EXTENSION"
```

**Expected log output:**
```
[SHARE EXTENSION] Processing 1 attachments
[SHARE EXTENSION] ✓ Received URL: https://www.instagram.com/...
[SHARE EXTENSION] Sending to backend: http://10.10.131.31:8000/api/video
[SHARE EXTENSION] ✓ Video received by backend
[SHARE EXTENSION] Analyzing with action: hoax_check
[SHARE EXTENSION] ✓ Analysis complete (1234 chars)
```

---

## ✨ Features

Your extension supports:
- 🛡️ **Hoax Check** - Verify authenticity
- 💡 **Explain This** - Get detailed explanation
- 🌟 **Expand This Idea** - Explore related concepts

Works with:
- ✅ Instagram Posts
- ✅ Instagram Reels
- ✅ Instagram Stories
- ✅ TikTok videos
- ✅ YouTube videos
- ✅ Any video URL

---

## 🎨 Customization

**Change UI colors:**
Edit: `flutter_app/ios/MyAppShareExtension/ShareViewController.swift`
- Line 35: Container background color
- Lines 65-67: Button colors and text

**Change app name:**
Edit: `flutter_app/ios/MyAppShareExtension/Info.plist`
- Key: `CFBundleDisplayName`

**Change activation rules:**
Edit: `flutter_app/ios/MyAppShareExtension/Info.plist`
- Section: `NSExtensionActivationRule`

---

## ✅ Success Checklist

- [ ] Backend running
- [ ] App installed on iPhone
- [ ] Extension appears in Instagram share sheet
- [ ] Extension opens when tapped
- [ ] All three actions work
- [ ] Results display correctly
- [ ] Can return to Instagram

---

## 🆘 Need Help?

1. **Quick fix:** Check `QUICK_TEST_INSTAGRAM.md`
2. **Detailed setup:** Check `INSTAGRAM_SHARE_SETUP.md`
3. **Visual guide:** Check `WHAT_TO_EXPECT.md`
4. **Checklist:** Check `INSTAGRAM_CHECKLIST.md`

---

## 🎓 Key Files to Know

**Extension Code:**
```
flutter_app/ios/MyAppShareExtension/
├── ShareViewController.swift  ← Main extension logic
├── Info.plist                 ← Configuration
└── MyAppShareExtension.entitlements ← Permissions
```

**Main App:**
```
flutter_app/
├── lib/main.dart              ← Flutter app
└── ios/Runner/
    └── Runner.entitlements    ← App permissions
```

---

## 📱 Test It Now!

**30-Second Test:**
1. Make sure backend is running
2. Open Instagram on iPhone
3. Share any post
4. Tap "Video Analyzer"
5. Choose an action
6. See results!

---

## 🎉 You're All Set!

Your app is ready to:
- ✅ Appear in Instagram's share sheet
- ✅ Accept shared content from Instagram
- ✅ Process videos with your backend
- ✅ Display AI-powered analysis
- ✅ Return users to Instagram

**Time to test:** Right now! 🚀

**Everything working?** Great! You can now demo your hackathon project!

**Having issues?** Check the troubleshooting section or the detailed guides.

---

Good luck with your hackathon! 🏆

