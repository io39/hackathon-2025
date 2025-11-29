# Quick Start Guide

Follow these steps to get your Video Analyzer app running in minutes!

## Prerequisites

- **Flutter**: Make sure Flutter is installed ([flutter.dev](https://flutter.dev))
- **Python 3.8+**: Required for the backend
- **iOS Simulator or Android Emulator**: For testing the Flutter app

## Step 1: Start the Backend (Terminal 1)

```bash
cd backend

# Setup (first time only)
chmod +x setup.sh start.sh
./setup.sh

# Or manually:
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt

# Start the server
python app.py
```

The backend will start on `http://localhost:5000`

**Keep this terminal running!**

## Step 2: Start the Flutter App (Terminal 2)

Open a **NEW** terminal window:

```bash
cd flutter_app

# Get dependencies (first time only)
flutter pub get

# Run the app
flutter run
```

Select your device (iOS simulator, Android emulator, or physical device) when prompted.

## Step 3: Test the App

Once the app is running:

1. **Easy Test**: Click the "Quick Test with Sample" button at the bottom
2. **Manual Test**: Paste a YouTube, TikTok, or Instagram URL and click "Analyze Video"
3. **Choose an Option**: 
   - 🛡️ Hoax Check
   - 💡 Explain This
   - 🌟 Expand This Idea
   - ❓ Ask Custom Question
4. **See Results**: Wait 2 seconds (simulated processing) and view the analysis

## Troubleshooting

### Backend Issues

**Problem**: Cannot connect to backend
- Make sure the backend is running on `http://localhost:5000`
- Check terminal for error messages

**Problem**: Module not found
- Run `pip install -r requirements.txt` in the backend directory

### Flutter Issues

**Problem**: No devices found
- Start an iOS simulator: `open -a Simulator`
- Or start an Android emulator from Android Studio

**Problem**: Dependencies error
- Run `flutter pub get` in the flutter_app directory
- Try `flutter clean` and then `flutter pub get`

**Problem**: Cannot connect to localhost (Android)
- Change the backend URL in `lib/main.dart` from `localhost` to `10.0.2.2` for Android emulator

**Problem**: Cannot connect to localhost (Physical Device)
- Find your computer's IP address:
  - Mac/Linux: `ifconfig | grep "inet "`
  - Windows: `ipconfig`
- Change the backend URL in `lib/main.dart` to `http://YOUR_IP:5000`

## Device-Specific Backend URLs

Update this line in `flutter_app/lib/main.dart`:

```dart
final String backendUrl = 'http://localhost:5000';  // iOS Simulator
// final String backendUrl = 'http://10.0.2.2:5000';  // Android Emulator
// final String backendUrl = 'http://192.168.1.XXX:5000';  // Physical Device
```

## Testing Without Sharing

The app has a built-in test mode. You can:

1. Use the "Quick Test with Sample" button
2. Manually paste URLs in the input field
3. See all four analysis options in action

## Next Steps

- Integrate real AI video analysis
- Add database for history
- Implement sharing from other apps (requires native configuration)
- Deploy backend to cloud
- Add user authentication

## Getting Help

Check the README files:
- `/README.md` - Project overview
- `/backend/README.md` - Backend API documentation
- `/flutter_app/README.md` - Flutter app details

Enjoy building your Video Analyzer! 🚀

