# Environment Configuration Guide

## 📋 Overview

This project uses environment files to manage configuration and secrets:
- **`.env`** - Non-sensitive configuration (port, debug mode, etc.)
- **`.secrets`** - Sensitive data (API keys, passwords, etc.)

## 🔧 Backend Configuration

### Files Created

```
backend/
├── env.example      # Template for .env
├── secrets.example  # Template for .secrets
├── .env            # Actual config (auto-generated, gitignored)
└── .secrets        # Actual secrets (auto-generated, gitignored)
```

### .env (Backend Configuration)

**Location**: `backend/.env`

```bash
# Server Configuration
HOST=0.0.0.0           # Server host (0.0.0.0 for all interfaces)
PORT=8000              # Server port (changed from 5000 to 8000)
DEBUG=True             # Enable debug mode

# API Configuration
API_VERSION=v1         # API version
MAX_VIDEO_URL_LENGTH=2048  # Max URL length

# Processing Configuration
PROCESSING_DELAY_SECONDS=2  # Simulated processing delay

# CORS Configuration
CORS_ORIGINS=*         # Allow all origins (use specific domains in production)

# Logging Configuration
LOG_LEVEL=INFO         # Log level (DEBUG, INFO, WARNING, ERROR)
LOG_FORMAT=detailed    # Log format
```

### .secrets (Backend Secrets)

**Location**: `backend/.secrets`

```bash
# API Keys (replace with real keys when integrating AI)
OPENAI_API_KEY=your_openai_api_key_here
ANTHROPIC_API_KEY=your_anthropic_api_key_here

# Database (for future use)
DATABASE_URL=postgresql://user:password@localhost:5432/video_analyzer
DATABASE_PASSWORD=your_secure_password_here

# JWT Secret (for future authentication)
JWT_SECRET_KEY=your_super_secret_jwt_key_here

# External Services
VIDEO_API_KEY=your_video_api_key_here
ANALYTICS_KEY=your_analytics_key_here
```

## 📱 Flutter Configuration

### Files Created

```
flutter_app/
├── env.example  # Template for .env
└── .env        # Actual config (auto-generated, gitignored)
```

### .env (Flutter Configuration)

**Location**: `flutter_app/.env`

```bash
# Backend URLs for different platforms
BACKEND_URL_IOS_SIMULATOR=http://localhost:8000
BACKEND_URL_ANDROID_EMULATOR=http://10.0.2.2:8000
BACKEND_URL_PRODUCTION=https://your-production-url.com

# App Configuration
APP_NAME=Video Analyzer
APP_VERSION=1.0.0

# Feature Flags
ENABLE_QUICK_TEST=true
ENABLE_CUSTOM_QUESTIONS=true

# UI Configuration
ENABLE_DEBUG_LOGGING=true
SHOW_RESPONSE_TIME=true
```

## 🔒 Security

### What's Protected

✅ `.env` files are in `.gitignore` - won't be committed
✅ `.secrets` files are in `.gitignore` - won't be committed
✅ Example files (`env.example`, `secrets.example`) ARE committed for reference

### What to Never Commit

❌ Real API keys
❌ Database passwords
❌ JWT secrets
❌ Production URLs with authentication
❌ Any sensitive credentials

## 🚀 Quick Setup

### If Starting Fresh

1. **Backend**:
```bash
cd backend
cp env.example .env
cp secrets.example .secrets
# Edit .env and .secrets with your values
```

2. **Flutter**:
```bash
cd flutter_app
cp env.example .env
# Edit .env with your values
```

### Already Set Up

The files are already created! Just edit them:

```bash
# Backend
nano backend/.env        # Edit configuration
nano backend/.secrets    # Edit secrets

# Flutter
nano flutter_app/.env    # Edit configuration
```

## 📊 How It Works

### Backend (Python)

The backend uses `python-dotenv` to load environment variables:

```python
from dotenv import load_dotenv
import os

# Load .env file
load_dotenv()

# Load .secrets file
load_dotenv('.secrets')

# Access variables
PORT = int(os.getenv('PORT', 8000))
DEBUG = os.getenv('DEBUG', 'True').lower() == 'true'
API_KEY = os.getenv('OPENAI_API_KEY')
```

### Flutter (Dart)

Currently hardcoded in `lib/main.dart`. To use environment variables in Flutter, you'd need to:
1. Add `flutter_dotenv` package
2. Load the `.env` file
3. Access variables

For now, just edit the hardcoded value in `main.dart`:
```dart
final String backendUrl = 'http://localhost:8000';
```

## 🔍 Logging

### Backend Logs

The backend now includes detailed logging:

```
[2025-11-29 10:30:15] [INFO] Server starting...
[2025-11-29 10:30:20] [REQUEST] POST /api/video
[2025-11-29 10:30:20] [DATA] {'video_url': 'https://...'}
[2025-11-29 10:30:20] [INFO] Received video URL: https://...
[2025-11-29 10:30:20] [✓ SUCCESS] Video stored successfully
[2025-11-29 10:30:20] [RESPONSE ✓] Status: 200
```

### Flutter Logs

The Flutter app now includes console logging:

```
[FLUTTER] Sending video to backend
[FLUTTER] Video URL: https://...
[FLUTTER] Backend URL: http://localhost:8000/api/video
[FLUTTER] Response received in 245ms
[FLUTTER] Status code: 200
[FLUTTER] ✓ Video received successfully
```

## 🛠️ Common Tasks

### Change Backend Port

1. Edit `backend/.env`:
```bash
PORT=9000  # Change to your desired port
```

2. Update Flutter app in `lib/main.dart`:
```dart
final String backendUrl = 'http://localhost:9000';
```

3. Restart both backend and Flutter app

### Add New API Key

1. Edit `backend/.secrets`:
```bash
NEW_API_KEY=your_key_here
```

2. Access in `backend/app.py`:
```python
api_key = os.getenv('NEW_API_KEY')
```

### Enable/Disable Debug Mode

Edit `backend/.env`:
```bash
DEBUG=False  # Disable debug mode
```

## 📝 Environment Variables Reference

### Backend .env Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `HOST` | `0.0.0.0` | Server host address |
| `PORT` | `8000` | Server port number |
| `DEBUG` | `True` | Enable Flask debug mode |
| `API_VERSION` | `v1` | API version identifier |
| `PROCESSING_DELAY_SECONDS` | `2` | Simulated processing delay |
| `CORS_ORIGINS` | `*` | Allowed CORS origins |
| `LOG_LEVEL` | `INFO` | Logging level |

### Backend .secrets Variables

| Variable | Description |
|----------|-------------|
| `OPENAI_API_KEY` | OpenAI API key for AI features |
| `ANTHROPIC_API_KEY` | Anthropic API key |
| `DATABASE_URL` | Database connection string |
| `JWT_SECRET_KEY` | Secret for JWT tokens |

## 🔄 Updating Configuration

### Development
Just edit the `.env` or `.secrets` files and restart the server.

### Production
1. Never commit real secrets
2. Use environment variables from hosting platform
3. Set secrets in platform's dashboard (Heroku, AWS, etc.)

## ✅ Verification

Check if files exist:
```bash
# Backend
ls -la backend/.env backend/.secrets

# Flutter
ls -la flutter_app/.env
```

Check if they're ignored by git:
```bash
git status
# Should NOT show .env or .secrets files
```

## 🎯 Best Practices

✅ **DO**:
- Keep example files updated
- Use different values for dev/prod
- Rotate secrets regularly
- Document all variables

❌ **DON'T**:
- Commit real secrets
- Share .secrets files
- Hardcode sensitive data
- Use same secrets in dev/prod

---

**Your environment is now properly configured with logging enabled!** 🎉


