# 🚀 START TESTING NOW - 10 Minute Guide

## What You'll Do
Share an Instagram post to your app and see it analyze in a beautiful bottom sheet!

---

## Step 1: Get Your IP (30 seconds)

Open Terminal:
```bash
ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}'
```

**Write it down:** ___.___.___.___ (Example: 192.168.1.100)

---

## Step 2: Update Extension (1 minute)

```bash
nano "/Users/frantisek/hackaton 2025 telcom/flutter_app/ios/ShareExtension/ShareViewController.swift"
```

Find line 13:
```swift
private let backendURL = "http://192.168.1.100:8000"
```

Change `192.168.1.100` to YOUR IP from Step 1

Save: `Ctrl+O`, `Enter`, `Ctrl+X`

---

## Step 3: Start Backend (1 minute)

Terminal 1:
```bash
cd "/Users/frantisek/hackaton 2025 telcom/backend"
source venv/bin/activate
python app.py
```

**Look for:**
```
📡 Server running on http://0.0.0.0:8000
```

✅ **Leave this running!**

---

## Step 4: Test Backend (30 seconds)

Terminal 2:
```bash
curl http://YOUR_IP:8000/health
```

**Should show:**
```json
{"status":"healthy","message":"Backend is running"}
```

✅ If yes, continue!
❌ If no, check WiFi and firewall

---

## Step 5: Open Xcode (1 minute)

```bash
cd "/Users/frantisek/hackaton 2025 telcom/flutter_app"
open ios/Runner.xcworkspace
```

Wait for Xcode to open and index (~30 seconds)

---

## Step 6: Create Share Extension (3 minutes)

### 6.1 Add Target
1. Xcode menu: **File** → **New** → **Target...**
2. Select **Share Extension**
3. Click **Next**
4. Product Name: `ShareExtension`
5. Language: Swift
6. Click **Finish**
7. Click **Activate**

### 6.2 Add App Groups to Runner
1. Left sidebar: Click **Runner** (blue icon)
2. Select **Runner** target
3. Tab: **Signing & Capabilities**
4. Click **+ Capability**
5. Add **App Groups**
6. Click **+** button
7. Enter: `group.com.videoanalyzer.shared`
8. Click OK
9. Check the checkbox ✓

### 6.3 Add App Groups to ShareExtension
1. Select **ShareExtension** target
2. Tab: **Signing & Capabilities**
3. Click **+ Capability**
4. Add **App Groups**
5. Check: `group.com.videoanalyzer.shared` ✓

---

## Step 7: Build to iPhone (2 minutes)

1. **Connect iPhone** with cable
2. **Unlock iPhone** and trust computer if asked
3. **Top bar:** Select your iPhone (next to scheme selector)
4. **Top bar:** Select **ShareExtension** scheme
5. Click **▶️ Run** button
6. **Wait for build** (~1-2 minutes)
7. On iPhone: Cancel the share dialog (we'll test from Instagram)

**First time?** iPhone may ask you to trust developer:
- Settings → General → VPN & Device Management → Trust

---

## Step 8: TEST! (1 minute)

### 8.1 Open Instagram on iPhone
📱 Launch Instagram app

### 8.2 Find a Post
📸 Any post, reel, or story

### 8.3 Tap Share
📤 Tap the share/send button (paper airplane icon)

### 8.4 Find Your App
📜 Scroll down in the share sheet
👀 Look for **"Video Analyzer"**

### 8.5 Tap It!
✨ Tap "Video Analyzer"

### 8.6 See the Magic! ✨

You should see:
```
╔═══════════════════════════════╗
║ Analyze Video                 ║
║                               ║
║ 🛡️  Hoax Check               ║
║ 💡  Explain This              ║
║ 🌟  Expand This Idea          ║
║                               ║
║            [Done]             ║
╚═══════════════════════════════╝
```

### 8.7 Tap an Option
🛡️ Tap "Hoax Check"

### 8.8 Wait 2 Seconds
⏳ See "Analyzing..."

### 8.9 See Result!
✅ Analysis appears!

### 8.10 Return
👈 Tap "Done" → Back to Instagram!

---

## ✅ SUCCESS!

If you saw the analysis result, **IT WORKS!** 🎉

### What to Check:

**Backend Terminal should show:**
```
[REQUEST] POST /api/video
[INFO] Received video URL: https://www.instagram.com/...
[✓ SUCCESS] Video stored successfully
[REQUEST] POST /api/analyze
[INFO]   - Action: hoax_check
[✓ SUCCESS] Analysis complete
```

---

## ❌ NOT WORKING?

### Issue: "Video Analyzer" not in share sheet

**Fix:**
1. Delete app from iPhone
2. Xcode: Product → Clean Build Folder (Shift+Cmd+K)
3. Run again

### Issue: "Connection Refused"

**Fix:**
1. Check backend is running (see "Server running...")
2. Check IP is correct in ShareViewController.swift
3. Mac and iPhone on SAME WiFi?
4. Test: Open Safari on iPhone → Go to `http://YOUR_IP:8000/health`

### Issue: Extension crashes

**Fix:**
1. Look at Xcode console (View → Debug Area → Console)
2. Red text shows error
3. Check IP address has no typos

---

## 🎊 Now Test All Features!

### Test 1: Hoax Check
Share post → Hoax Check → ✅

### Test 2: Explain This
Share post → Explain This → ✅

### Test 3: Expand Idea
Share post → Expand This Idea → ✅

### Test 4: TikTok
Open TikTok → Share → Your app → ✅

### Test 5: YouTube
Open YouTube → Share → Your app → ✅

---

## 📚 Need More Help?

Read these detailed guides:

1. **`TEST_ON_IPHONE.md`** - Detailed testing guide
2. **`XCODE_STEPS.md`** - Step-by-step with screenshots
3. **`SHARE_EXTENSION_SETUP.md`** - Complete setup guide
4. **`SHARE_EXTENSION_SUMMARY.md`** - Technical overview

---

## 🎯 What You Just Built

✅ iOS Share Extension
✅ Receives shares from Instagram/TikTok/YouTube
✅ Beautiful bottom sheet UI
✅ Connects to your backend
✅ Shows real analysis results
✅ Returns to Instagram seamlessly

**Ready for demo at hackathon!** 🏆

---

## 📱 Demo Flow

**For showing at hackathon:**

1. Open Instagram
2. "I want to fact-check this post..."
3. Tap Share
4. "My app appears here!" (show your app)
5. Tap your app
6. "Here's my analysis options" (bottom sheet)
7. Tap "Hoax Check"
8. "Processing with AI..." (2 seconds)
9. "Here's the analysis!" (result)
10. "Done! Back to Instagram"

**Total demo time:** 30 seconds
**Wow factor:** 100% 🔥

---

**THAT'S IT! YOU'RE READY!** 🚀📱✨

**Questions?** Check the other documentation files!
**Working?** Congrats! Go build something amazing! 🎉


