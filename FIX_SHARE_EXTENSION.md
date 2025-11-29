# Fix: Share Extension Not Appearing in Share Sheet

## 🎯 Problem
Your app doesn't appear when sharing from Instagram.

## ✅ Solution Steps

### Step 1: Open Xcode Project

```bash
cd "/Users/frantisek/hackaton 2025 telcom/flutter_app"
open ios/Runner.xcworkspace
```

**⚠️ IMPORTANT:** Open `.xcworkspace` NOT `.xcodeproj`!

---

### Step 2: Check if ShareExtension Target Exists

1. In Xcode left sidebar, click **Runner** (blue project icon at top)
2. In the main area, look at **TARGETS** section
3. **Do you see "ShareExtension" listed?**

**If NO** → Go to Step 3 (Add Target)
**If YES** → Skip to Step 4 (Build & Install)

---

### Step 3: Add Share Extension Target

#### 3.1 Create Target
1. Xcode menu: **File** → **New** → **Target...**
2. In template chooser:
   - Left sidebar: Select **iOS**
   - Main area: Scroll down and select **Share Extension**
   - Click **Next**

#### 3.2 Configure Target
Fill in:
- **Product Name:** `ShareExtension`
- **Team:** Select your Apple Developer team
- **Language:** Swift
- **Project:** Runner (should be pre-selected)
- **Embed in Application:** Runner (should be checked ✓)

Click **Finish**

#### 3.3 Activate Scheme
Dialog appears: "Activate 'ShareExtension' scheme?"
Click **Activate**

#### 3.4 Replace Default Files

**A. Replace ShareViewController.swift:**
1. In Xcode left sidebar, find: **ShareExtension** → **ShareViewController.swift**
2. Open it
3. Select all (Cmd+A) and delete
4. Open terminal:
   ```bash
   cat "/Users/frantisek/hackaton 2025 telcom/flutter_app/ios/ShareExtension/ShareViewController.swift"
   ```
5. Copy ALL the content
6. Paste into Xcode file
7. Save (Cmd+S)

**B. Replace Info.plist:**
1. In Xcode: **ShareExtension** → **Info.plist**
2. Right-click → **Open As** → **Source Code**
3. Replace entire content with:
   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
   <plist version="1.0">
   <dict>
   	<key>CFBundleDevelopmentRegion</key>
   	<string>$(DEVELOPMENT_LANGUAGE)</string>
   	<key>CFBundleDisplayName</key>
   	<string>Video Analyzer</string>
   	<key>CFBundleExecutable</key>
   	<string>$(EXECUTABLE_NAME)</string>
   	<key>CFBundleIdentifier</key>
   	<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
   	<key>CFBundleInfoDictionaryVersion</key>
   	<string>6.0</string>
   	<key>CFBundleName</key>
   	<string>$(PRODUCT_NAME)</string>
   	<key>CFBundlePackageType</key>
   	<string>$(PRODUCT_BUNDLE_PACKAGE_TYPE)</string>
   	<key>CFBundleShortVersionString</key>
   	<string>1.0</string>
   	<key>CFBundleVersion</key>
   	<string>1</string>
   	<key>NSExtension</key>
   	<dict>
   		<key>NSExtensionAttributes</key>
   		<dict>
   			<key>NSExtensionActivationRule</key>
   			<dict>
   				<key>NSExtensionActivationSupportsImageWithMaxCount</key>
   				<integer>1</integer>
   				<key>NSExtensionActivationSupportsMovieWithMaxCount</key>
   				<integer>1</integer>
   				<key>NSExtensionActivationSupportsText</key>
   				<true/>
   				<key>NSExtensionActivationSupportsWebURLWithMaxCount</key>
   				<integer>1</integer>
   				<key>NSExtensionActivationSupportsWebPageWithMaxCount</key>
   				<integer>1</integer>
   			</dict>
   		</dict>
   		<key>NSExtensionPointIdentifier</key>
   		<string>com.apple.share-services</string>
   		<key>NSExtensionPrincipalClass</key>
   		<string>$(PRODUCT_MODULE_NAME).ShareViewController</string>
   	</dict>
   </dict>
   </plist>
   ```
4. Save (Cmd+S)

---

### Step 4: Configure App Groups

#### 4.1 Add to Runner Target
1. Select **Runner** target (in TARGETS list)
2. Click **Signing & Capabilities** tab
3. Click **+ Capability** button
4. Double-click **App Groups**
5. Click **+** button
6. Enter: `group.com.videoanalyzer.shared`
7. Click **OK**
8. Make sure checkbox is **checked ✓**

#### 4.2 Add to ShareExtension Target
1. Select **ShareExtension** target
2. Click **Signing & Capabilities** tab
3. Click **+ Capability** button
4. Double-click **App Groups**
5. Check: `group.com.videoanalyzer.shared` ✓

---

### Step 5: Configure Signing

#### 5.1 Runner Target
1. Select **Runner** target
2. **Signing & Capabilities** tab
3. **Team:** Select your Apple Developer team
4. **Bundle Identifier:** Should be `com.videoanalyzer.video_analyzer` (or similar)

#### 5.2 ShareExtension Target
1. Select **ShareExtension** target
2. **Signing & Capabilities** tab
3. **Team:** Select SAME team as Runner
4. **Bundle Identifier:** Should auto-fill as `com.videoanalyzer.video_analyzer.ShareExtension`

**⚠️ IMPORTANT:** Both must have:
- ✅ Same team
- ✅ Valid signing certificates
- ✅ No errors (red text)

---

### Step 6: Clean Build

1. Xcode menu: **Product** → **Clean Build Folder** (Shift+Cmd+K)
2. Wait for cleaning to complete

---

### Step 7: Build ShareExtension to iPhone

#### 7.1 Connect iPhone
1. Connect iPhone with cable
2. Unlock iPhone
3. Trust computer if asked

#### 7.2 Select Device & Scheme
1. **Top bar:** Click device selector (left of scheme)
2. Select your **iPhone** (not simulator!)
3. **Top bar:** Click scheme selector (says "Runner" or "ShareExtension")
4. Select **ShareExtension**

#### 7.3 Build & Run
1. Click **▶️ Run** button (or press Cmd+R)
2. Wait for build (~1-2 minutes)
3. **First time:** iPhone may ask to trust developer
   - Settings → General → VPN & Device Management → Trust

#### 7.4 What Happens
- Xcode builds ShareExtension
- Installs it on iPhone
- May show a share dialog (just cancel it)
- Extension is now installed!

---

### Step 8: Delete Old App (Important!)

**On your iPhone:**
1. Find the **Video Analyzer** app icon
2. Long press → **Remove App** → **Delete App**
3. This removes old version without extension

---

### Step 9: Rebuild Main App

**In Xcode:**
1. **Top bar:** Change scheme from **ShareExtension** to **Runner**
2. Click **▶️ Run**
3. App installs on iPhone

**Now both app AND extension are installed!**

---

### Step 10: Test!

1. **Open Instagram** on iPhone
2. **Find any post**
3. **Tap Share** button (paper airplane)
4. **Scroll down** in share sheet
5. **Look for "Video Analyzer"** ✨

**Should appear now!**

---

## 🐛 Troubleshooting

### Still Not Appearing?

#### Fix 1: Rebuild Everything
```bash
# In Xcode
Product → Clean Build Folder (Shift+Cmd+K)
# Then rebuild both Runner and ShareExtension
```

#### Fix 2: Check Bundle Identifier
**ShareExtension** bundle ID should be:
```
com.videoanalyzer.video_analyzer.ShareExtension
```
(Or whatever your main app ID is + `.ShareExtension`)

#### Fix 3: Verify Files
In Xcode, check:
- ✅ ShareExtension/ShareViewController.swift exists
- ✅ ShareExtension/Info.plist exists
- ✅ Both have correct content

#### Fix 4: Check Build Log
1. Xcode: **View** → **Navigators** → **Show Report Navigator** (Cmd+9)
2. Look for errors in red
3. Fix any signing or build errors

#### Fix 5: Restart iPhone
Sometimes iOS needs restart to recognize new extensions:
1. Restart iPhone
2. Try sharing again

#### Fix 6: Check Extension is Built
1. In Xcode: **Product** → **Scheme** → **ShareExtension**
2. **Product** → **Build** (Cmd+B)
3. Should build without errors

---

## ✅ Success Checklist

- [ ] ShareExtension target exists in Xcode
- [ ] ShareViewController.swift has correct code
- [ ] Info.plist has correct configuration
- [ ] App Groups configured for both targets
- [ ] Both targets signed with same team
- [ ] Clean build completed
- [ ] ShareExtension built to iPhone
- [ ] Main app rebuilt to iPhone
- [ ] Old app deleted from iPhone
- [ ] "Video Analyzer" appears in share sheet

---

## 🎯 Quick Test

**After following all steps:**

1. Instagram → Share post
2. Scroll down in share sheet
3. **"Video Analyzer" should be there!** ✨

**If still not there:**
- Check Xcode build log for errors
- Verify signing is correct
- Try restarting iPhone
- Make sure you built ShareExtension (not just Runner)

---

## 📝 Important Notes

### Why It Might Not Appear

1. **Extension not built** - Must build ShareExtension target
2. **Not signed** - Both targets need valid signing
3. **Old app still installed** - Delete and reinstall
4. **iOS cache** - Restart iPhone
5. **Wrong scheme** - Must build ShareExtension, not Runner

### The Key Step

**You MUST build ShareExtension target to iPhone!**

Not just the main app. The extension is separate and must be installed separately.

---

**Follow these steps and your app will appear in the share sheet!** 🚀

