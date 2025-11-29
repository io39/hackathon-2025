# Xcode Setup - Step by Step with Screenshots Guide

## 🎯 Goal
Add Share Extension so your app appears when sharing from Instagram!

## ⏱️ Time Required
~15 minutes

## 📱 What You'll Create

When you tap "Share" on Instagram, your app will appear in the share sheet and show a beautiful bottom overlay with analysis options!

---

## Step 1: Open Xcode

```bash
cd "/Users/frantisek/hackaton 2025 telcom/flutter_app"
open ios/Runner.xcworkspace
```

**⚠️ IMPORTANT:** Open `Runner.xcworkspace` NOT `Runner.xcodeproj`!

Wait for Xcode to open and indexing to complete (~30 seconds).

---

## Step 2: Create Share Extension Target

### 2.1 Add New Target

1. In Xcode top menu → **File** → **New** → **Target...**
2. A template chooser appears

### 2.2 Select iOS Share Extension

1. In the left sidebar, make sure **iOS** is selected (not macOS/watchOS)
2. Scroll down or search for **Share Extension**
3. Click on **Share Extension** template
4. Click **Next** button (bottom right)

### 2.3 Configure Extension

Fill in the form:

| Field | Value |
|-------|-------|
| **Product Name** | `ShareExtension` |
| **Team** | Select your Apple Developer team |
| **Language** | Swift |
| **Project** | Runner (should be pre-selected) |
| **Embed in Application** | Runner (should be checked ✓) |

Click **Finish**

### 2.4 Activate Scheme

A dialog appears: "Activate 'ShareExtension' scheme?"

Click **Activate**

---

## Step 3: Configure App Groups

App Groups let the Share Extension talk to your main app.

### 3.1 Add App Group to Main App (Runner)

1. In Xcode left sidebar (Project Navigator), click **Runner** (the blue icon at top)
2. In the main area, under **TARGETS**, select **Runner** (the first one)
3. Click the **Signing & Capabilities** tab at the top
4. Click the **+ Capability** button
5. Scroll down and double-click **App Groups**
6. You'll see a new "App Groups" section appear
7. Click the **+** button (under "App Groups")
8. In the dialog, enter: `group.com.videoanalyzer.shared`
9. Click **OK**
10. Make sure the checkbox next to it is **checked ✓**

### 3.2 Add App Group to Share Extension

1. Still in TARGETS list, click **ShareExtension** (second item)
2. Click **Signing & Capabilities** tab
3. Click **+ Capability** button
4. Double-click **App Groups**
5. You'll see the group you just created: `group.com.videoanalyzer.shared`
6. Make sure the checkbox is **checked ✓**

---

## Step 4: Replace ShareViewController.swift

The files I created are already in place! Let's verify:

1. In Xcode left sidebar, expand folders:
   - **Runner** (project)
   - **ios**
   - **ShareExtension**
2. You should see:
   - `ShareViewController.swift` ← Click to open
   - `Info.plist`
   - `MainInterface.storyboard`

**If `ShareViewController.swift` is empty or has default code:**

1. Open the file from terminal:
   ```bash
   open "/Users/frantisek/hackaton 2025 telcom/flutter_app/ios/ShareExtension/ShareViewController.swift"
   ```
2. Copy ALL the content
3. In Xcode, select all (Cmd+A) and paste (Cmd+V)
4. Save (Cmd+S)

---

## Step 5: Update Backend URL

**IMPORTANT:** The extension needs to reach your backend!

### 5.1 Find Your Computer's IP Address

Open Terminal and run:
```bash
ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}'
```

Example output: `192.168.1.100`

### 5.2 Update ShareViewController.swift

1. In Xcode, open `ShareViewController.swift`
2. Find line ~13:
   ```swift
   private let backendURL = "http://192.168.1.100:8000"
   ```
3. Replace `192.168.1.100` with YOUR IP address
4. Save (Cmd+S)

---

## Step 6: Update Info.plist (Main App)

We need to add URL scheme to the main app.

### 6.1 Open Runner Info.plist

1. In left sidebar: **Runner** → **Runner** (folder) → **Info.plist**
2. Right-click on `Info.plist`
3. Choose **Open As** → **Source Code**

### 6.2 Add URL Scheme

Find the closing `</dict>` tag near the end of the file.

**Before the LAST `</dict></plist>`, add:**

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

**It should look like:**
```xml
	... (other keys) ...
	<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>videoanalyzer</string>
			</array>
		</dict>
	</array>
</dict>
</plist>
```

Save (Cmd+S)

---

## Step 7: Build and Install

### 7.1 Connect Your iPhone

1. Connect iPhone to Mac with cable
2. Unlock iPhone
3. Trust computer if prompted

### 7.2 Select Your iPhone

In Xcode top bar:
- Click on device selector (left of "Runner" scheme)
- Choose your iPhone from the list

### 7.3 Select ShareExtension Scheme

In Xcode top bar:
- Click on the scheme selector (says "Runner" or "ShareExtension")
- Choose **ShareExtension**

### 7.4 Build and Run

1. Click the **▶️ Play button** (top left)
2. Xcode will build and install
3. On your iPhone, you'll see a dialog asking which app to share to
4. **Just cancel it** - we're testing from Instagram next!

---

## Step 8: Test on Your iPhone!

### 8.1 Start Your Backend

On your Mac:
```bash
cd backend
source venv/bin/activate
python app.py
```

Should see: `📡 Server running on http://0.0.0.0:8000`

### 8.2 Verify Connection

From iPhone or Mac:
```bash
curl http://YOUR_IP:8000/health
```

Should return JSON with "healthy"

### 8.3 Test from Instagram

1. **Open Instagram** on your iPhone
2. **Find any post** (video, photo, reel)
3. **Tap the Share button** (paper airplane icon)
4. **Scroll down** in the share sheet
5. **Look for "Video Analyzer"** with your app icon!
6. **Tap it!**

### 8.4 What You Should See

```
╔═══════════════════════════════╗
║ Analyze Video                 ║
║                               ║
║ 🛡️  Hoax Check               ║
║    Verify authenticity        ║
║                               ║
║ 💡  Explain This              ║
║    Get detailed explanation   ║
║                               ║
║ 🌟  Expand This Idea          ║
║    Explore related concepts   ║
║                               ║
║ [Done]                        ║
╚═══════════════════════════════╝
```

7. **Tap an option** (e.g., "Hoax Check")
8. See "Analyzing..." for 2 seconds
9. See the result!
10. Tap "Done" to return to Instagram

---

## 🎉 Success Checklist

- [ ] Xcode project opens without errors
- [ ] ShareExtension target created
- [ ] App Groups configured for both targets
- [ ] Backend URL updated with your IP
- [ ] URL scheme added to Info.plist
- [ ] Extension builds successfully
- [ ] App installed on iPhone
- [ ] "Video Analyzer" appears in Instagram share sheet
- [ ] Bottom sheet opens when tapped
- [ ] Options are visible
- [ ] Backend receives request (check logs!)
- [ ] Results show after 2 seconds
- [ ] Can return to Instagram

---

## 🐛 Troubleshooting

### Extension Not Appearing in Share Sheet

**Problem:** Don't see "Video Analyzer" when sharing

**Solutions:**
1. **Rebuild the app:**
   - In Xcode: Product → Clean Build Folder (Shift+Cmd+K)
   - Delete app from iPhone
   - Run again from Xcode

2. **Check signing:**
   - Runner target → Signing & Capabilities
   - ShareExtension target → Signing & Capabilities
   - Both should have valid team selected

3. **Restart iPhone:**
   - Sometimes iOS needs a restart to recognize new extensions

### "Connection Refused" Error

**Problem:** Extension can't reach backend

**Solutions:**
1. **Backend not running:**
   ```bash
   cd backend && python app.py
   ```

2. **Wrong IP address:**
   - Run: `ifconfig | grep inet | grep -v 127.0.0.1`
   - Update IP in `ShareViewController.swift` line 13
   - Rebuild in Xcode

3. **Firewall blocking:**
   - Mac: System Settings → Network → Firewall → Options
   - Add exception for Python or port 8000

4. **Different WiFi:**
   - Make sure iPhone and Mac are on SAME WiFi network

### Extension Crashes

**Problem:** Extension opens then crashes

**Solutions:**
1. **Check Console:**
   - Xcode: View → Debug Area → Activate Console
   - Look for error messages in red

2. **Check Logs:**
   - Run extension from Xcode with iPhone connected
   - Crash logs appear in console immediately

3. **Verify Code:**
   - Make sure `ShareViewController.swift` matches the one I provided
   - Check for typos in backend URL

### Build Errors

**Problem:** Xcode shows errors when building

**Solutions:**
1. **Missing files:**
   - Make sure both files exist:
     - `ios/ShareExtension/ShareViewController.swift`
     - `ios/ShareExtension/Info.plist`

2. **Clean build:**
   - Product → Clean Build Folder (Shift+Cmd+K)
   - Try building again

3. **Update dependencies:**
   ```bash
   cd flutter_app
   flutter clean
   flutter pub get
   ```

---

## 📝 Testing Checklist

Test each feature:

1. **Share from Instagram:**
   - [ ] Open Instagram
   - [ ] Share a post
   - [ ] See "Video Analyzer" in share sheet
   - [ ] Tap it

2. **Hoax Check:**
   - [ ] Tap "Hoax Check"
   - [ ] See "Analyzing..."
   - [ ] Wait 2 seconds
   - [ ] See hoax check result
   - [ ] Check backend logs show "hoax_check"

3. **Explain This:**
   - [ ] Back to Instagram
   - [ ] Share another post
   - [ ] Tap "Explain This"
   - [ ] See explanation result

4. **Expand Idea:**
   - [ ] Test "Expand This Idea"
   - [ ] Verify different response

5. **Close:**
   - [ ] Tap "Done" button
   - [ ] Returns to Instagram smoothly

---

## 🎓 What Each File Does

```
ios/
├── Runner/                          ← Main app
│   ├── Info.plist                   ← App config (added URL scheme)
│   └── [other files]
│
└── ShareExtension/                  ← Share Extension (NEW!)
    ├── ShareViewController.swift    ← Extension logic & UI
    ├── Info.plist                   ← Extension config
    └── MainInterface.storyboard     ← (not used, we use code-based UI)
```

**ShareViewController.swift:**
- Receives shared URL from Instagram
- Shows bottom sheet UI
- Sends to backend
- Shows results
- Handles close action

**Info.plist:**
- Tells iOS what content types to accept
- URL, Text, Images, Videos

**App Groups:**
- Allow extension to share data with main app
- Could be used for history/cache

---

## 🚀 Next Steps

**Working?** Awesome! Now you can:
1. ✅ Share from TikTok (works same way!)
2. ✅ Share from YouTube
3. ✅ Share from Safari (any video URL)
4. ✅ Customize the UI colors in `ShareViewController.swift`
5. ✅ Add custom question feature
6. ✅ Save analysis history

**Not working?** 
- Check backend logs for errors
- Check Xcode console for crashes
- Review troubleshooting section above

---

**You're all set! Go test it on Instagram!** 📱✨


