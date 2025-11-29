# ✅ Instagram Share Extension - Ready to Test!

## What I've Set Up For You

Your Flutter app is now configured to appear in Instagram's share sheet! 🎉

### Files Created/Modified

1. **Share Extension Created** ✅
   - `flutter_app/ios/MyAppShareExtension/ShareViewController.swift`
   - `flutter_app/ios/MyAppShareExtension/Info.plist`
   - `flutter_app/ios/MyAppShareExtension/MyAppShareExtension.entitlements`

2. **Xcode Project Updated** ✅
   - Extension target added
   - Signing configured
   - Deployment target fixed (was 26.1, now 12.0)

3. **Activation Rules Configured** ✅
   - Accepts: Images, Videos, URLs, Text, Files
   - Will appear when sharing Instagram posts/reels

4. **Documentation Created** ✅
   - `INSTAGRAM_SHARE_SETUP.md` - Complete setup guide
   - `QUICK_TEST_INSTAGRAM.md` - Quick start guide
   - `WHAT_TO_EXPECT.md` - Visual flow and expectations

## 🚀 Quick Start (3 Steps)

### Step 1: Update Backend URL (if needed)
Edit `flutter_app/ios/MyAppShareExtension/ShareViewController.swift` line 10:
```swift
private let backendURL = "http://YOUR_MAC_IP:8000"
```

Find your Mac's IP:
```bash
ipconfig getifaddr en0
```

### Step 2: Build and Install
```bash
cd "/Users/frantisek/hackaton 2025 telcom/flutter_app"
flutter run --release
```

Or open in Xcode:
```bash
open ios/Runner.xcworkspace
```

### Step 3: Test in Instagram
1. Open Instagram
2. Go to any post/reel
3. Tap Share button (📤)
4. Look for "Video Analyzer"
5. Tap it!

## What You Should See

```
Instagram Share Sheet
↓
"Video Analyzer" appears
↓
Tap it
↓
Beautiful bottom sheet opens
↓
Three action buttons:
  🛡️ Hoax Check
  💡 Explain This
  🌟 Expand This Idea
↓
Choose one
↓
"Analyzing..." with spinner
↓
Results appear
↓
Tap "Done" → back to Instagram
```

## Activation Rules Set

Your app will appear when sharing:
- ✅ Instagram Posts
- ✅ Instagram Reels
- ✅ Instagram Stories
- ✅ Videos from any source
- ✅ Images
- ✅ URLs
- ✅ Text content

## Technical Details

**Bundle IDs:**
- Main App: `com.videoanalyzer.videoAnalyzer`
- Extension: `com.videoanalyzer.videoAnalyzer.MyAppShareExtension`

**App Group:**
- `group.com.videoanalyzer.shared`

**Deployment Target:**
- iOS 12.0+ (compatible with most devices)

**Extension Type:**
- Share Extension (`com.apple.share-services`)

**Display Name:**
- "Video Analyzer"

## Key Configuration

**Info.plist Activation Rules:**
```xml
<key>NSExtensionActivationSupportsImageWithMaxCount</key>
<integer>10</integer>
<key>NSExtensionActivationSupportsMovieWithMaxCount</key>
<integer>10</integer>
<key>NSExtensionActivationSupportsText</key>
<true/>
<key>NSExtensionActivationSupportsWebURLWithMaxCount</key>
<integer>10</integer>
<key>NSExtensionActivationSupportsWebPageWithMaxCount</key>
<integer>10</integer>
<key>NSExtensionActivationSupportsFileWithMaxCount</key>
<integer>10</integer>
```

This means your app will accept up to 10 items of each type, making it very flexible.

## Architecture

```
┌─────────────────┐
│   Instagram     │
│      App        │
└────────┬────────┘
         │ User shares content
         ↓
┌─────────────────┐
│  iOS System     │
│  Share Sheet    │
└────────┬────────┘
         │ Shows available extensions
         ↓
┌─────────────────┐
│ Video Analyzer  │
│   Extension     │  ← Your code runs here
└────────┬────────┘
         │ Extracts URL
         ↓
┌─────────────────┐
│  Backend API    │
│  (on your Mac)  │  ← Processes video
└────────┬────────┘
         │ Returns analysis
         ↓
┌─────────────────┐
│  Extension UI   │  ← Shows results
└─────────────────┘
```

## Important Notes

### ⚠️ Prerequisites
- Backend must be running on your Mac
- iPhone and Mac must be on **same Wi-Fi network**
- Firewall must allow connections on port 8000

### 🔄 When to Rebuild
Rebuild the app after changing:
- ShareViewController.swift code
- Info.plist settings
- Entitlements
- Backend URL

### 🐛 Debugging
View logs in real-time:
```bash
flutter logs | grep "SHARE EXTENSION"
```

### 🎨 Customization
All UI is in `ShareViewController.swift`:
- Colors (lines 35, 52, 71, 85, etc.)
- Button text (lines 65-67)
- Layout (lines 92-118)

## Files You Can Modify

**Extension Code:**
- `flutter_app/ios/MyAppShareExtension/ShareViewController.swift`
  - Change UI colors, layout, button text
  - Modify backend URL
  - Add new features

**Extension Display Name:**
- `flutter_app/ios/MyAppShareExtension/Info.plist`
  - Change `CFBundleDisplayName` key

**Activation Rules:**
- `flutter_app/ios/MyAppShareExtension/Info.plist`
  - Modify `NSExtensionActivationRule` to change when extension appears

## Next Steps

1. ✅ **Test Basic Functionality**
   - Does extension appear in Instagram?
   - Does it receive the URL?
   - Does backend connection work?

2. ✅ **Test All Actions**
   - Hoax Check
   - Explain This
   - Expand This Idea

3. ✅ **Test Edge Cases**
   - Private Instagram posts
   - Stories
   - Reels
   - Regular posts

4. ✅ **Test Other Apps**
   - TikTok
   - YouTube
   - Twitter/X
   - Safari

5. 🎨 **Customize** (optional)
   - Change colors to match your brand
   - Modify button text
   - Add your logo

## Troubleshooting Quick Reference

| Problem | Solution |
|---------|----------|
| App doesn't appear | Reinstall app, restart iPhone |
| Connection fails | Check backend running, verify IP address |
| Code signing error | Update signing in Xcode for both targets |
| Extension crashes | Check logs, verify iOS version compatibility |
| Slow response | Normal for long videos, check backend logs |

## Support Files Reference

- **Complete Guide**: `INSTAGRAM_SHARE_SETUP.md`
- **Quick Test**: `QUICK_TEST_INSTAGRAM.md`
- **What to Expect**: `WHAT_TO_EXPECT.md`
- **This Summary**: `INSTAGRAM_SHARE_SUMMARY.md`

## Success Criteria

✅ Extension appears in Instagram share sheet  
✅ Tapping it opens your custom UI  
✅ URL is extracted from Instagram content  
✅ Backend receives and processes request  
✅ Results are displayed in extension  
✅ User can return to Instagram

## Current Status

🟢 **Ready to Test**

All configuration is complete. Your app should now:
1. Build successfully
2. Install on iPhone
3. Appear in Instagram's share sheet
4. Accept shared content
5. Process with your backend
6. Display results

---

## Ready to Go! 🚀

Your app is fully configured to work with Instagram's share sheet. Follow the Quick Start steps above to test it!

**Any issues?** Check the troubleshooting sections in the detailed guides.

**Want to customize?** Edit the colors and text in `ShareViewController.swift`.

**Everything working?** Share with users and gather feedback!

Good luck with your hackathon! 🎉

