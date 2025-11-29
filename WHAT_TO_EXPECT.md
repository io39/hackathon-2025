# 📱 What to Expect: Instagram Share Flow

## Visual Flow

```
┌─────────────────────────┐
│     Instagram Post      │
│   (Reel/Video/Post)     │
│                         │
│   [Share Button 📤]     │ ← User taps here
└─────────────────────────┘
            ↓
┌─────────────────────────┐
│   iOS Share Sheet       │
│                         │
│  [Messages]  [Mail]     │
│  [WhatsApp]  [Twitter]  │
│  [Video Analyzer] ★     │ ← Your app appears here!
│     [More...]           │
└─────────────────────────┘
            ↓
┌─────────────────────────┐
│  Video Analyzer         │ ← Your custom UI
│  ═══════════════════    │
│                         │
│  Analyze Video          │
│                         │
│  ┌───────────────────┐  │
│  │ 🛡️ Hoax Check     │  │
│  │ Verify authenticity│  │
│  └───────────────────┘  │
│                         │
│  ┌───────────────────┐  │
│  │ 💡 Explain This   │  │
│  │ Get explanation   │  │
│  └───────────────────┘  │
│                         │
│  ┌───────────────────┐  │
│  │ 🌟 Expand Idea    │  │
│  │ Explore concepts  │  │
│  └───────────────────┘  │
│                         │
│      [Done]             │
└─────────────────────────┘
            ↓ User taps an action
┌─────────────────────────┐
│  Analyzing...           │
│       ⏳                │
└─────────────────────────┘
            ↓
┌─────────────────────────┐
│  ✓ Analysis Complete    │
│                         │
│  ┌───────────────────┐  │
│  │                   │  │
│  │  Analysis results │  │
│  │  displayed here   │  │
│  │  in scrollable    │  │
│  │  text view...     │  │
│  │                   │  │
│  └───────────────────┘  │
│                         │
│      [Done]             │
└─────────────────────────┘
```

## Step-by-Step Expectations

### 1. Before Sharing (Setup)
✅ App installed on iPhone  
✅ Backend running on Mac  
✅ iPhone and Mac on same Wi-Fi

### 2. In Instagram
- You're looking at a post/reel
- You tap the **Share** button (looks like: 📤 or ✈️)
- iOS shows the share sheet with various apps

### 3. Share Sheet Appears
**What you should see:**
- Grid of app icons
- Your app icon might show as a generic square
- Text below says "Video Analyzer"
- If not visible immediately, scroll left/right or tap "More"

**Note:** First time using an app from share sheet, it might be in "More" section. After first use, iOS will promote it to the main row.

### 4. Tap "Video Analyzer"
**What happens:**
- Bottom sheet slides up from bottom
- Dark blue/purple gradient background (#0A0E27)
- "Analyze Video" title at top
- Three colorful action buttons appear

**UI Colors:**
- Background: Deep blue (#0A0E27)
- Buttons: Dark purple (#1A1E3E)
- Hoax Check border: Red (#FF6B6B)
- Explain This border: Yellow (#FFD93D)
- Expand Idea border: Cyan (#4ECDC4)
- Primary accent: Purple (#6C63FF)

### 5. Choose an Action
**What happens immediately:**
- Buttons disappear
- Title changes to "Analyzing..."
- Spinner appears in center
- Backend processes request (5-30 seconds typically)

**In Console Logs:**
```
[SHARE EXTENSION] Processing 1 attachments
[SHARE EXTENSION] ✓ Received URL: https://www.instagram.com/p/...
[SHARE EXTENSION] Sending to backend: http://10.10.131.31:8000/api/video
[SHARE EXTENSION] ✓ Video received by backend
[SHARE EXTENSION] Analyzing with action: hoax_check
[SHARE EXTENSION] Waiting for backend response...
[SHARE EXTENSION] ✓ Analysis complete (1523 chars)
```

### 6. Results Appear
**What you should see:**
- Title changes to "✓ Analysis Complete"
- Text view appears with results
- Results are scrollable if long
- "Done" button remains at bottom
- Results shown in white text on dark background

### 7. Tap "Done"
**What happens:**
- Extension closes
- Returns to Instagram
- Instagram remains on the same post you were viewing

## Common Scenarios

### ✅ Perfect Success
```
Instagram → Share → Video Analyzer → Choose Action → See Results → Done → Back to Instagram
```
**Time:** ~10-30 seconds total

### ⚠️ Backend Not Running
```
Instagram → Share → Video Analyzer → Choose Action → Error: "Failed to connect to backend"
```
**Solution:** Start backend with `cd backend && ./start.sh`

### ⚠️ Wrong Network
```
Extension appears frozen or times out
```
**Solution:** Ensure iPhone and Mac on same Wi-Fi, check Mac IP is correct

### ⚠️ App Doesn't Appear
```
Instagram → Share → No "Video Analyzer" visible
```
**Solutions:**
1. Scroll through all apps in share sheet
2. Check "More" section
3. Reinstall app
4. Restart iPhone

## Behind the Scenes (Technical)

When you share from Instagram:

1. **Instagram** provides the extension with:
   - URL of the post
   - Possibly image/video data
   - Post metadata

2. **Your Extension**:
   - Runs in a separate process from main app
   - Has ~30MB memory limit
   - Must finish in <30 seconds or iOS kills it
   - Extracts URL from Instagram's shared data

3. **Backend Processing**:
   - Receives URL via HTTP POST
   - Downloads video from URL
   - Processes with AI/ML
   - Returns analysis

4. **Display Results**:
   - Extension shows formatted text
   - User can scroll through results
   - Tapping "Done" completes the extension

## Supported Content Types

Your extension activates for:
- ✅ Instagram Posts (with videos)
- ✅ Instagram Reels
- ✅ Instagram Stories (with video)
- ✅ IGTV videos
- ✅ Any Instagram content with a URL

Also works with:
- ✅ TikTok videos
- ✅ YouTube videos
- ✅ Twitter videos
- ✅ Any video URL from Safari

## What Users Will Experience

1. **Fast** - Extension loads in <1 second
2. **Beautiful** - Modern, gradient UI with smooth animations
3. **Simple** - Three clear action buttons
4. **Informative** - Rich text results
5. **Seamless** - Returns to Instagram when done

## Testing Checklist

- [ ] App installs without errors
- [ ] Extension appears in Instagram share sheet
- [ ] Extension UI displays correctly (dark theme, buttons visible)
- [ ] URL is extracted (check logs)
- [ ] Backend receives request (check backend logs)
- [ ] Loading state shows (spinner visible)
- [ ] Results display (text readable)
- [ ] Done button works (returns to Instagram)
- [ ] Can share multiple posts in a row

## Performance Expectations

- **Extension Load Time:** <1 second
- **URL Extraction:** Instant
- **Backend Request:** 5-30 seconds (depends on video length)
- **Results Display:** Instant once received
- **Memory Usage:** <20MB typically
- **Network Usage:** Minimal (just sends URL, receives text)

## What If It's Not Working?

Check in this order:

1. **Is the app installed?**
   - Look for "Video Analyzer" icon on home screen

2. **Is the extension configured?**
   - Run: `open flutter_app/ios/Runner.xcworkspace`
   - Check both targets have valid signing

3. **Is the backend running?**
   - Visit: `http://YOUR_MAC_IP:8000` in browser
   - Should see API documentation or response

4. **Are devices on same network?**
   - iPhone Settings → Wi-Fi (check network name)
   - Mac System Preferences → Network (check network name)
   - Must match exactly

5. **Is the IP address correct?**
   - In ShareViewController.swift line 10
   - Run: `ipconfig getifaddr en0` to verify

6. **Are logs showing anything?**
   - Run: `flutter logs` while testing
   - Look for "[SHARE EXTENSION]" messages

---

**Everything working?** Your users can now analyze Instagram content directly from the share sheet! 🎉

