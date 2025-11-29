# Video Analyzer - Flutter App

A modern Flutter application that allows users to share videos from Instagram, TikTok, and YouTube for AI-powered analysis.

## Features

- 🎨 Beautiful dark mode UI with modern design
- 📱 Receive shared videos from other apps
- 🔍 Four analysis options:
  - **Hoax Check**: Verify content authenticity
  - **Explain This**: Get detailed explanations
  - **Expand This Idea**: Explore related concepts
  - **Custom Question**: Ask specific questions
- 🌐 Real-time communication with backend API
- ⚡ Smooth animations and transitions

## Setup

1. Make sure you have Flutter installed:
```bash
flutter --version
```

2. Get dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
# For iOS simulator
flutter run

# For Android emulator
flutter run

# For specific device
flutter devices
flutter run -d <device-id>
```

## Configuration

Update the backend URL in `lib/main.dart` if your backend is not running on localhost:5000:

```dart
final String backendUrl = 'http://YOUR_BACKEND_URL:5000';
```

### iOS Configuration

To enable sharing from other apps, add the following to `ios/Runner/Info.plist`:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>ShareMedia</string>
        </array>
    </dict>
</array>
```

### Android Configuration

The `receive_sharing_intent` package is already configured in the generated Android files.

## Testing

Use the "Test with Sample Video" button on the home screen to test the functionality without actually sharing from another app.

## Project Structure

```
lib/
├── main.dart           # Main application file
│   ├── VideoAnalyzerApp      # App widget with theme
│   ├── HomePage               # Main screen
│   └── ActionOverlay          # Bottom sheet with action buttons
```

## Dependencies

- `http`: HTTP client for API calls
- `receive_sharing_intent`: Handle shared content from other apps
- `url_launcher`: Launch URLs (for future features)

## UI/UX Features

- Gradient backgrounds
- Smooth transitions
- Loading states
- Error handling
- Modern card designs
- Interactive buttons with icons
- Responsive layout
