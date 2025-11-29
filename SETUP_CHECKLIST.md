# Setup Checklist ✅

Use this checklist to verify everything is set up correctly.

## 📋 Pre-Setup Verification

### System Requirements

- [ ] **Flutter Installed**
  ```bash
  flutter --version
  # Should show Flutter 3.x or higher
  ```

- [ ] **Python 3.8+ Installed**
  ```bash
  python3 --version
  # Should show Python 3.8 or higher
  ```

- [ ] **pip Installed**
  ```bash
  pip3 --version
  # Should show pip version
  ```

- [ ] **Device/Emulator Available**
  ```bash
  flutter devices
  # Should show at least one device
  ```

## 🔧 Backend Setup

### Step 1: Navigate to Backend
```bash
cd backend
```

### Step 2: Create Virtual Environment
- [ ] Create venv
  ```bash
  python3 -m venv venv
  ```

- [ ] Activate venv
  ```bash
  source venv/bin/activate  # Mac/Linux
  # OR
  venv\Scripts\activate     # Windows
  ```

### Step 3: Install Dependencies
- [ ] Install Python packages
  ```bash
  pip install -r requirements.txt
  ```

### Step 4: Verify Backend Files
- [ ] Check files exist:
  - [ ] `app.py`
  - [ ] `requirements.txt`
  - [ ] `setup.sh`
  - [ ] `start.sh`
  - [ ] `README.md`

### Step 5: Test Backend
- [ ] Start the server
  ```bash
  python app.py
  ```

- [ ] Verify console output shows:
  ```
  🚀 Starting Video Analyzer Backend...
  📡 Server running on http://localhost:5000
  ```

- [ ] Test health endpoint (in new terminal):
  ```bash
  curl http://localhost:5000/health
  # Should return: {"status":"healthy","message":"Backend is running"}
  ```

- [ ] Keep backend running!

## 📱 Flutter Setup

### Step 1: Navigate to Flutter App (New Terminal)
```bash
cd flutter_app
```

### Step 2: Get Dependencies
- [ ] Run pub get
  ```bash
  flutter pub get
  ```

### Step 3: Verify Flutter Files
- [ ] Check files exist:
  - [ ] `lib/main.dart`
  - [ ] `pubspec.yaml`
  - [ ] `README.md`

### Step 4: Check for Linter Errors
- [ ] Verify no errors
  ```bash
  flutter analyze
  # Should show: No issues found!
  ```

### Step 5: Configure Backend URL
- [ ] Open `lib/main.dart`
- [ ] Find line: `final String backendUrl = 'http://localhost:5000';`
- [ ] Update based on your device:
  - [ ] iOS Simulator: `http://localhost:5000` ✅ (default)
  - [ ] Android Emulator: `http://10.0.2.2:5000`
  - [ ] Physical Device: `http://YOUR_IP:5000`

### Step 6: Start App
- [ ] Run the app
  ```bash
  flutter run
  ```

- [ ] Select your device when prompted

## 🧪 Functionality Testing

### Test 1: Quick Test Button
- [ ] App launches successfully
- [ ] Click "Quick Test with Sample" button
- [ ] Loading spinner appears
- [ ] Action overlay slides up from bottom
- [ ] All 4 options are visible with correct icons

### Test 2: Hoax Check
- [ ] Click "Hoax Check" button
- [ ] "Analyzing video..." appears
- [ ] Wait 2 seconds
- [ ] Result appears with hoax check text
- [ ] Text is readable and formatted

### Test 3: Explain This
- [ ] Click refresh button (top right of result card)
- [ ] Click "Quick Test" again
- [ ] Click "Explain This" button
- [ ] Result appears with explanation text

### Test 4: Expand This Idea
- [ ] Repeat process
- [ ] Click "Expand This Idea" button
- [ ] Result appears with expansion text

### Test 5: Custom Question
- [ ] Click "Quick Test" again
- [ ] Type a question in the text field
- [ ] Click send icon
- [ ] Result appears with custom response including your question

### Test 6: Manual URL Entry
- [ ] Click refresh to reset
- [ ] Paste a real video URL (YouTube, TikTok, etc.)
- [ ] Click "Analyze Video" button
- [ ] Verify it works the same as quick test

## 🎨 Visual Verification

### UI Elements to Check
- [ ] Dark mode theme is active
- [ ] Gradient background is visible
- [ ] App icon has purple/teal gradient
- [ ] Cards have rounded corners
- [ ] Buttons have proper colors:
  - [ ] Purple primary buttons
  - [ ] Red for Hoax Check
  - [ ] Yellow for Explain This
  - [ ] Teal for Expand Idea
- [ ] Text is readable on dark background
- [ ] Loading spinners are purple
- [ ] Icons are displayed correctly

## 🐛 Troubleshooting

### Backend Issues

**Issue**: `ModuleNotFoundError: No module named 'flask'`
- [ ] Solution: Activate venv and run `pip install -r requirements.txt`

**Issue**: Port 5000 already in use
- [ ] Solution: Kill existing process or change port in `app.py` and Flutter app

**Issue**: CORS errors in browser
- [ ] Solution: Verify Flask-CORS is installed and imported

### Flutter Issues

**Issue**: No devices found
- [ ] Solution: Start simulator or emulator
  ```bash
  open -a Simulator  # Mac
  # Or start Android emulator from Android Studio
  ```

**Issue**: Package resolution errors
- [ ] Solution:
  ```bash
  flutter clean
  flutter pub get
  ```

**Issue**: Cannot connect to backend
- [ ] Verify backend is running
- [ ] Check backend URL in `lib/main.dart`
- [ ] For Android emulator, use `10.0.2.2` instead of `localhost`
- [ ] For physical device, use your computer's IP address

**Issue**: Timeout connecting to backend
- [ ] Check firewall settings
- [ ] Verify backend logs show incoming requests
- [ ] Test backend with `curl` first

## ✅ Success Criteria

You've successfully set up the app if:

- ✅ Backend server starts without errors
- ✅ Flutter app launches on device/emulator
- ✅ UI looks modern with dark theme
- ✅ Quick test button works
- ✅ All 4 action options work
- ✅ Results display correctly
- ✅ Custom questions work
- ✅ Manual URL entry works
- ✅ No error messages appear
- ✅ 2-second processing delay is noticeable

## 📊 Final Verification

Run through this complete flow:

1. [ ] Start backend server
2. [ ] Launch Flutter app
3. [ ] Click "Quick Test with Sample"
4. [ ] Wait for action overlay
5. [ ] Click "Hoax Check"
6. [ ] Wait 2 seconds
7. [ ] Read the result
8. [ ] Click refresh
9. [ ] Enter custom URL
10. [ ] Click "Analyze Video"
11. [ ] Choose "Explain This"
12. [ ] Verify result is different from hoax check

If all steps work: **🎉 CONGRATULATIONS! Your setup is complete!**

## 📝 Notes

- Backend must be running before testing Flutter app
- Each analysis takes exactly 2 seconds (as requested)
- All responses are simulated (no real AI yet)
- No data is persisted (all in-memory)

## 🚀 Ready to Code!

Now you can:
- Customize the UI colors and design
- Integrate real AI APIs
- Add database persistence
- Implement user authentication
- Deploy to production

**Happy hacking at Hackathon 2025! 🎊**


