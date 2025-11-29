# Video Analyzer - Full Stack Application

A complete Flutter + Python backend application for analyzing shared videos from social media platforms.

## Project Structure

```
hackaton 2025 telcom/
├── flutter_app/          # Flutter mobile application
│   ├── lib/
│   │   └── main.dart    # Main app code
│   ├── pubspec.yaml     # Flutter dependencies
│   └── README.md        # Flutter-specific docs
│
├── backend/             # Python Flask backend
│   ├── app.py          # Main backend server
│   ├── requirements.txt # Python dependencies
│   └── README.md       # Backend-specific docs
│
├── .gitignore          # Git ignore file
└── README.md           # This file
```

## Quick Start

### 1. Start the Backend

```bash
cd backend

# Create virtual environment
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Run the server
python app.py
```

The backend will start on `http://localhost:5000`

### 2. Start the Flutter App

In a new terminal:

```bash
cd flutter_app

# Get dependencies
flutter pub get

# Run the app
flutter run
```

## How It Works

1. **Share Video**: Share a video link from Instagram, TikTok, or YouTube to the Video Analyzer app
2. **Receive Confirmation**: The app sends the video URL to the backend and waits for confirmation
3. **Choose Analysis**: A beautiful overlay appears with 4 options:
   - 🛡️ **Hoax Check**: Verify authenticity
   - 💡 **Explain This**: Get detailed explanation
   - 🌟 **Expand This Idea**: Explore related concepts
   - ❓ **Custom Question**: Ask your own question
4. **Get Results**: The backend processes your request (simulates 2-second processing) and returns analysis
5. **View Response**: Results are displayed in the app with formatted text

## Features

### Flutter App
- Modern dark mode UI with gradients
- Share intent handling
- Real-time API communication
- Beautiful animations
- Error handling
- Loading states

### Backend
- RESTful API with Flask
- CORS enabled for cross-origin requests
- Simulated video processing
- Multiple analysis endpoints
- Health check endpoint
- Detailed console logging

## API Endpoints

- `POST /api/video` - Receive video URL
- `POST /api/analyze` - Analyze video with selected action
- `GET /health` - Health check

## Testing

Use the "Test with Sample Video" button in the Flutter app to test the complete flow without needing to share from another app.

## Development Notes

This is currently a **mock implementation** for development and testing. For production:

1. Replace backend simulation with actual AI video analysis
2. Add database for storing videos and results
3. Implement authentication
4. Add rate limiting
5. Deploy backend to cloud service
6. Update Flutter app with production backend URL
7. Add video thumbnail fetching
8. Implement result caching
9. Add user accounts and history

## Tech Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Python Flask
- **Communication**: REST API with JSON
- **Dependencies**: See respective requirements files

## Design Philosophy

- Clean, modern interface
- Intuitive user experience
- Fast response times
- Clear visual feedback
- Professional dark mode theme

## Next Steps

1. ✅ Basic Flutter app structure
2. ✅ Share intent handling
3. ✅ Backend API implementation
4. ✅ UI/UX design
5. 🔄 Real AI integration (future)
6. 🔄 Database implementation (future)
7. 🔄 User authentication (future)
8. 🔄 Cloud deployment (future)

## License

Developed for Hackathon 2025 Telcom

