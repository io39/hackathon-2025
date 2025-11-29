# MyAppShareExtension Setup Guide

## ✅ What I Just Did

I've implemented the full Share Extension functionality in your `MyAppShareExtension` target:

1. ✅ **Replaced ShareViewController.swift** - Full implementation with:
   - Beautiful dark mode UI
   - Bottom sheet design
   - 3 analysis options (Hoax Check, Explain, Expand)
   - Backend integration
   - Error handling
   - Logging

2. ✅ **Updated Info.plist** - Configured to accept:
   - URLs (Instagram, TikTok, YouTube links)
   - Text (copied URLs)
   - Images
   - Videos
   - Web pages

## 🚀 Next Steps in Xcode

### Step 1: Configure App Groups

**For Runner (Main App):**
1. Select **Runner** target
2. **Signing & Capabilities** tab
3. Click **+ Capability**
4. Add **App Groups**
5. Click **+** button
6. Enter: `group.com.videoanalyzer.shared`
7. Check the checkbox ✓

**For MyAppShareExtension:**
1. Select **MyAppShareExtension** target
2. **Signing & Capabilities** tab
3. Click **+ Capability**
4. Add **App Groups**
5. Check: `group.com.videoanalyzer.shared` ✓

### Step 2: Configure Signing

**Both targets need:**
- ✅ Same team selected
- ✅ Valid signing certificates
- ✅ No errors (red text)

### Step 3: Update Backend URL (if needed)

The backend URL is set to: `http://10.10.131.31:8000`

**If your IP changed**, edit line 11 in:
```
ios/MyAppShareExtension/ShareViewController.swift
```

Change:
```swift
private let backendURL = "http://10.10.131.31:8000"
```

### Step 4: Build to iPhone

1. **Connect iPhone** with cable
2. **Unlock iPhone** and trust computer
3. **Top bar:** Select your **iPhone** (not simulator)
4. **Top bar:** Select **MyAppShareExtension** scheme
5. Click **▶️ Run** button
6. Wait for build (~1-2 minutes)

**First time:** iPhone may ask to trust developer:
- Settings → General → VPN & Device Management → Trust

### Step 5: Delete Old App

**On iPhone:**
- Find "Video Analyzer" app
- Long press → Remove App → Delete App

### Step 6: Rebuild Main App

**In Xcode:**
1. Change scheme to **Runner**
2. Click **▶️ Run**
3. App installs on iPhone

### Step 7: Test!

1. **Open Instagram** on iPhone
2. **Find any post**
3. **Tap Share** button (paper airplane)
4. **Scroll down** in share sheet
5. **Look for "Video Analyzer"** ✨
6. **Tap it!**
7. **See bottom sheet with 3 options**
8. **Tap an option** (e.g., "Hoax Check")
9. **Wait 2 seconds**
10. **See analysis result!**
11. **Tap "Done"** → Back to Instagram

## 🎨 What You'll See

### Bottom Sheet UI:
```
╔═══════════════════════════════╗
║ Analyze Video                 ║
║                               ║
║ ┌───────────────────────────┐ ║
║ │ 🛡️  Hoax Check           │ ║
║ │    Verify authenticity    │ ║
║ └───────────────────────────┘ ║
║                               ║
║ ┌───────────────────────────┐ ║
║ │ 💡  Explain This          │ ║
║ │    Get detailed explain   │ ║
║ └───────────────────────────┘ ║
║                               ║
║ ┌───────────────────────────┐ ║
║ │ 🌟  Expand This Idea      │ ║
║ │    Explore related         │ ║
║ └───────────────────────────┘ ║
║                               ║
║            [Done]             ║
╚═══════════════════════════════╝
```

## 🐛 Troubleshooting

### Extension Not Appearing?

1. **Make sure you built MyAppShareExtension** (not just Runner)
2. **Check App Groups** are configured for both targets
3. **Check signing** - both targets need same team
4. **Delete old app** from iPhone
5. **Restart iPhone** (sometimes needed)

### Connection Errors?

1. **Backend running?** Check terminal: `python app.py`
2. **Same WiFi?** iPhone and Mac must be on same network
3. **Firewall?** Temporarily disable Mac firewall
4. **IP correct?** Verify in ShareViewController.swift line 11

### Build Errors?

1. **Clean build:** Product → Clean Build Folder (Shift+Cmd+K)
2. **Check Info.plist** - Make sure it matches the one I provided
3. **Check ShareViewController.swift** - Make sure it's complete
4. **Check Xcode console** for specific error messages

## ✅ Success Checklist

- [ ] App Groups configured for both targets
- [ ] Both targets signed with same team
- [ ] MyAppShareExtension built to iPhone
- [ ] Main app rebuilt to iPhone
- [ ] Old app deleted from iPhone
- [ ] Backend running on port 8000
- [ ] "Video Analyzer" appears in share sheet
- [ ] Bottom sheet opens when tapped
- [ ] Options are visible
- [ ] Analysis works and shows results

## 🎉 You're Ready!

Once you see "Video Analyzer" in the share sheet, everything is working!

**For demo:**
1. Open Instagram
2. Share a post
3. Tap "Video Analyzer"
4. Choose analysis option
5. Show result
6. Impress judges! 🏆

---

**Need help?** Check Xcode build log for errors or let me know what's happening!

