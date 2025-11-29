# Testing on Your iPhone - Quick Guide

## 🎯 Goal
Test the Share Extension on your actual iPhone with Instagram!

## ⚡ Quick Setup (5 minutes)

### 1. Get Your Mac's IP Address

```bash
ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}'
```

**Example output:** `192.168.1.100` ← This is YOUR IP!

**Write it down!** ✍️ `___.___.___.___`

### 2. Update Backend URL

```bash
cd "/Users/frantisek/hackaton 2025 telcom/flutter_app"
open ios/ShareExtension/ShareViewController.swift
```

Find line 13 and change it to YOUR IP:
```swift
private let backendURL = "http://YOUR_IP_HERE:8000"  // ← Change this!
```

Example:
```swift
private let backendURL = "http://192.168.1.100:8000"  // ← Use your IP!
```

Save and close.

### 3. Start Backend

```bash
cd "/Users/frantisek/hackaton 2025 telcom/backend"
source venv/bin/activate
python app.py
```

**Should see:**
```
📡 Server running on http://0.0.0.0:8000
```

**Leave this terminal open!**

### 4. Test Backend Connection

Open Safari on your iPhone and go to:
```
http://YOUR_IP:8000/health
```

**Should see:**
```json
{
  "status": "healthy",
  "message": "Backend is running"
}
```

✅ **If you see this, you're ready!**

❌ **If you see error:**
- Check Mac and iPhone are on same WiFi
- Check firewall isn't blocking port 8000
- Check backend is running

### 5. Open Xcode and Build

```bash
cd "/Users/frantisek/hackaton 2025 telcom/flutter_app"
open ios/Runner.xcworkspace
```

**In Xcode:**
1. Connect iPhone with cable
2. Unlock iPhone and trust computer
3. Select your iPhone from device dropdown (top bar)
4. Select **ShareExtension** scheme (top bar)
5. Click **▶️ Run button**

**First time:**
- iPhone may ask to "Verify Developer"
- Go to: Settings → General → VPN & Device Management
- Trust your developer certificate

### 6. Test on Instagram!

1. **Open Instagram** on iPhone
2. **Find any post**
3. **Tap Share button** (paper airplane icon)
4. **Look for "Video Analyzer"** in the share sheet
5. **Tap it!**

---

## 📱 What You Should See

### Step 1: Share from Instagram
```
┌─────────────────────────────┐
│ Instagram Post              │
│ [Photo/Video]               │
│                             │
│ [Share button 📤]           │ ← Tap this
└─────────────────────────────┘
```

### Step 2: iOS Share Sheet Appears
```
┌─────────────────────────────┐
│ Share                       │
├─────────────────────────────┤
│ 💬 Messages                 │
│ 📧 Mail                     │
│ 🎬 Video Analyzer           │ ← Your app!
│ 📋 Copy Link                │
│ ...                         │
└─────────────────────────────┘
```

### Step 3: Bottom Sheet Opens!
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
║ │    Explore related        │ ║
║ └───────────────────────────┘ ║
║                               ║
║            [Done]             ║
╚═══════════════════════════════╝
```

### Step 4: Select Option
Tap "Hoax Check" (or any option)

```
╔═══════════════════════════════╗
║ Analyzing...                  ║
║                               ║
║         [Loading ⚪]          ║
║                               ║
║                               ║
║                               ║
║                               ║
╚═══════════════════════════════╝
```

### Step 5: See Results! (after 2 seconds)
```
╔═══════════════════════════════╗
║ ✓ Analysis Complete           ║
║                               ║
║ 🔍 HOAX CHECK ANALYSIS        ║
║                               ║
║ Selected Option: Hoax Check   ║
║                               ║
║ Simulation of conversation... ║
║                               ║
║ After analyzing the video...  ║
║ ✓ Video authenticity: Likely  ║
║ ✓ Source credibility: Medium  ║
║ ...                           ║
║                               ║
║            [Done]             ║
╚═══════════════════════════════╝
```

### Step 6: Return to Instagram
Tap "Done" → Back to Instagram! ✅

---

## 🔍 Monitoring

### On Your Mac (Backend Terminal)

You should see logs like:
```
============================================================
[2025-11-29 10:30:20] [REQUEST] POST /api/video
[2025-11-29 10:30:20] [DATA] {'video_url': 'https://www.instagram.com/...'}
============================================================
[2025-11-29 10:30:20] [INFO] Received video URL: https://www.instagram.com/...
[2025-11-29 10:30:20] [✓ SUCCESS] Video stored successfully
[2025-11-29 10:30:20] [RESPONSE ✓] Status: 200
------------------------------------------------------------

============================================================
[2025-11-29 10:30:25] [REQUEST] POST /api/analyze
[2025-11-29 10:30:25] [DATA] {'action': 'hoax_check', ...}
============================================================
[2025-11-29 10:30:25] [INFO] Starting analysis...
[2025-11-29 10:30:25] [INFO]   - Action: hoax_check
[2025-11-29 10:30:25] [INFO] Processing... (simulating 2 second delay)
[2025-11-29 10:30:27] [✓ SUCCESS] Analysis complete for action: hoax_check
------------------------------------------------------------
```

### In Xcode Console (if connected)

You should see logs like:
```
[SHARE EXTENSION] Processing 1 attachments
[SHARE EXTENSION] ✓ Received URL: https://www.instagram.com/...
[SHARE EXTENSION] Sending to backend: http://192.168.1.100:8000/api/video
[SHARE EXTENSION] ✓ Video received by backend
[SHARE EXTENSION] Analyzing with action: hoax_check
[SHARE EXTENSION] Waiting for backend response...
[SHARE EXTENSION] ✓ Analysis complete (450 chars)
[SHARE EXTENSION] Closing extension
```

---

## ✅ Success Checklist

Test everything:

- [ ] Backend starts and shows "Server running on 0.0.0.0:8000"
- [ ] Can access `/health` from iPhone Safari
- [ ] Xcode builds ShareExtension successfully
- [ ] App installs on iPhone
- [ ] "Video Analyzer" appears in Instagram share sheet
- [ ] Bottom sheet opens when tapped
- [ ] Can see all 3 option buttons
- [ ] Tapping option shows "Analyzing..."
- [ ] Backend logs show request
- [ ] After 2 seconds, result appears
- [ ] Can scroll through result text
- [ ] "Done" button works
- [ ] Returns to Instagram smoothly

---

## 🐛 Common Issues

### 1. "Video Analyzer" Not in Share Sheet

**Try:**
```bash
# Delete app from iPhone
# In Xcode: Product → Clean Build Folder (Shift+Cmd+K)
# Run again
```

### 2. "Connection Refused"

**Check:**
- [ ] Backend is running (see "Server running..." message)
- [ ] IP address is correct in `ShareViewController.swift`
- [ ] Mac and iPhone on same WiFi
- [ ] Try accessing `http://YOUR_IP:8000/health` from iPhone Safari

**Fix firewall:**
```bash
# Allow port 8000
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --add /usr/local/bin/python3
```

### 3. Crashes on Open

**Check Xcode console for errors:**
- Red text shows crash reason
- Common: typo in backend URL, missing files

**Rebuild:**
```bash
cd flutter_app
flutter clean
cd ..
# Then rebuild in Xcode
```

### 4. Blank/Empty Screen

**Verify files:**
```bash
ls -la "/Users/frantisek/hackaton 2025 telcom/flutter_app/ios/ShareExtension/"
```

Should show:
- `ShareViewController.swift`
- `Info.plist`

### 5. "Cannot Verify Developer"

**On iPhone:**
1. Settings
2. General
3. VPN & Device Management
4. Find your developer name
5. Trust

---

## 🧪 Quick Test Sequence

Test all features in 2 minutes:

### Test 1: Hoax Check (30 sec)
1. Share Instagram post
2. Tap "Video Analyzer"
3. Tap "Hoax Check"
4. Wait 2 seconds
5. See red-themed hoax check result
6. ✅ Backend logs show "hoax_check"

### Test 2: Explain This (30 sec)
1. Back to Instagram
2. Share another post
3. Tap "Video Analyzer"
4. Tap "Explain This"
5. See yellow-themed explanation
6. ✅ Backend logs show "explain_this"

### Test 3: Expand Idea (30 sec)
1. Share another post
2. Tap "Expand This Idea"
3. See teal-themed expansion
4. ✅ Backend logs show "expand_idea"

### Test 4: Different Content (30 sec)
1. Share from TikTok or YouTube
2. Verify it still works
3. ✅ Works with all platforms!

---

## 📸 Take Screenshots!

For your presentation/demo:
1. Instagram share sheet showing your app
2. Bottom sheet with options
3. Analyzing state
4. Results displayed
5. Backend logs in terminal

---

## 🎉 Working?

**Congratulations!** 🎊

Your app now:
- ✅ Receives shares from Instagram
- ✅ Shows as beautiful bottom overlay
- ✅ Processes with backend
- ✅ Shows results
- ✅ Returns to Instagram

**Demo ready for hackathon!** 🏆

---

## 🚀 Next: Advanced Features

Now that it works, you can:

1. **Add Custom Question:**
   - Add text field to bottom sheet
   - Pass question to backend

2. **Improve UI:**
   - Add animations
   - Better loading states
   - Show video thumbnail

3. **Save History:**
   - Store analyzed videos
   - Show in main app

4. **Real AI:**
   - Connect OpenAI API
   - Replace mock responses

---

**Happy testing!** 📱✨

**Need help?** Check:
- `SHARE_EXTENSION_SETUP.md` - Detailed setup
- `XCODE_STEPS.md` - Step-by-step Xcode guide
- Backend logs - See what's happening
- Xcode console - Check for crashes


