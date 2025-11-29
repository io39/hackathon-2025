# Video Analyzer Backend

A simple Flask backend for the Video Analyzer Flutter application.

## Features

- Receives video URLs from the Flutter app
- Simulates video processing
- Provides 4 analysis options:
  - Hoax Check
  - Explain This
  - Expand This Idea
  - Custom Question
- Simulates 2-second processing time
- Returns formatted response text

## Setup

1. Create a virtual environment:
```bash
python3 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Run the server:
```bash
python app.py
```

The server will start on `http://localhost:5000`

## API Endpoints

### POST /api/video
Receives a video URL from the Flutter app.

**Request:**
```json
{
  "video_url": "https://www.youtube.com/watch?v=..."
}
```

**Response:**
```json
{
  "status": "success",
  "message": "Video received successfully",
  "video_id": "123456789"
}
```

### POST /api/analyze
Analyzes the video based on the selected action.

**Request:**
```json
{
  "video_url": "https://www.youtube.com/watch?v=...",
  "action": "hoax_check",
  "custom_question": "Optional custom question"
}
```

**Response:**
```json
{
  "status": "success",
  "action": "hoax_check",
  "custom_question": null,
  "response": "Detailed analysis text..."
}
```

### GET /health
Health check endpoint.

**Response:**
```json
{
  "status": "healthy",
  "message": "Backend is running"
}
```

## Development Notes

- This is a mock backend for development/testing
- In production, replace with actual video analysis AI
- Add proper database for storing video data
- Implement authentication and rate limiting
- Add error handling and logging

