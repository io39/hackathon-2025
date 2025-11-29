# Quick Reference Guide

## 🚀 Start Everything

### Terminal 1 - Backend
```bash
cd backend
source venv/bin/activate
python app.py
```

### Terminal 2 - Flutter
```bash
cd flutter_app
flutter run
```

## 📁 Important Files

### Configuration
| File | Purpose | Edit? |
|------|---------|-------|
| `backend/.env` | Backend settings | ✅ Yes |
| `backend/.secrets` | API keys, passwords | ✅ Yes |
| `flutter_app/.env` | Flutter settings | ✅ Yes |
| `backend/env.example` | Template | ❌ No (reference only) |
| `backend/secrets.example` | Template | ❌ No (reference only) |

### Code Files
| File | Purpose | Lines |
|------|---------|-------|
| `flutter_app/lib/main.dart` | Flutter app | ~700 |
| `backend/app.py` | Backend server | ~250 |

## ⚙️ Configuration Quick Edit

### Change Port
```bash
# Edit backend/.env
nano backend/.env
# Change: PORT=8000 to PORT=9000

# Edit flutter_app/lib/main.dart (line ~70)
nano flutter_app/lib/main.dart
# Change: 'http://localhost:8000' to 'http://localhost:9000'
```

### Change Processing Delay
```bash
# Edit backend/.env
nano backend/.env
# Change: PROCESSING_DELAY_SECONDS=2 to desired value
```

### Add API Key
```bash
# Edit backend/.secrets
nano backend/.secrets
# Change: OPENAI_API_KEY=your_key_here
```

## 📊 Log Locations

### Backend Logs
- **Where:** Terminal where you ran `python app.py`
- **Format:** `[TIMESTAMP] [LEVEL] Message`
- **Levels:** INFO, SUCCESS, ERROR

### Flutter Logs
- **Where:** Terminal where you ran `flutter run`
- **Format:** `[FLUTTER] Message`
- **Indicators:** ✓ (success), ✗ (error)

## 🔍 Common Issues

### "Connection Refused"
```bash
# Check backend is running
ps aux | grep python

# Check port in backend/.env
cat backend/.env | grep PORT

# Check Flutter URL (should match backend port)
grep "backendUrl =" flutter_app/lib/main.dart
```

### "Module not found: dotenv"
```bash
cd backend
source venv/bin/activate
pip install python-dotenv
```

### Flutter can't connect (Android)
```dart
// Edit flutter_app/lib/main.dart
final String backendUrl = 'http://10.0.2.2:8000';  // Use 10.0.2.2 for Android
```

## 📝 Quick Commands

### Backend
```bash
# Start backend
cd backend && source venv/bin/activate && python app.py

# Check health
curl http://localhost:8000/health

# View environment
cat backend/.env

# Edit secrets
nano backend/.secrets
```

### Flutter
```bash
# Start Flutter
cd flutter_app && flutter run

# Clean build
cd flutter_app && flutter clean && flutter pub get

# Check devices
flutter devices

# Hot reload (in running app)
# Press 'r' in terminal
```

## 🎯 Test Commands

### Test Backend Health
```bash
curl http://localhost:8000/health
```

**Expected:**
```json
{
  "status": "healthy",
  "message": "Backend is running",
  "port": 8000,
  "debug_mode": true
}
```

### Test Video Endpoint
```bash
curl -X POST http://localhost:8000/api/video \
  -H "Content-Type: application/json" \
  -d '{"video_url":"https://youtube.com/test"}'
```

### Test Analyze Endpoint
```bash
curl -X POST http://localhost:8000/api/analyze \
  -H "Content-Type: application/json" \
  -d '{"video_url":"https://youtube.com/test","action":"hoax_check"}'
```

## 📚 Documentation

| Document | When to Read |
|----------|--------------|
| `START_HERE.md` | First time setup |
| `QUICKSTART.md` | Quick setup guide |
| `ENV_SETUP.md` | Configure environment |
| `LOGGING_GUIDE.md` | Understand logs |
| `CHANGES_SUMMARY.md` | What changed recently |
| `QUICK_REFERENCE.md` | This file! |

## 🛠️ Environment Variables

### Backend .env
```bash
PORT=8000                      # Server port
DEBUG=True                     # Debug mode
PROCESSING_DELAY_SECONDS=2     # Delay simulation
LOG_LEVEL=INFO                 # Log level
```

### Backend .secrets
```bash
OPENAI_API_KEY=sk-...          # OpenAI key
ANTHROPIC_API_KEY=sk-ant-...   # Anthropic key
DATABASE_URL=postgresql://...  # Database
```

### Flutter .env
```bash
BACKEND_URL_IOS_SIMULATOR=http://localhost:8000
BACKEND_URL_ANDROID_EMULATOR=http://10.0.2.2:8000
ENABLE_DEBUG_LOGGING=true
```

## 🔄 Common Workflows

### Change Backend Port
1. Edit `backend/.env`: `PORT=9000`
2. Edit `flutter_app/lib/main.dart`: `http://localhost:9000`
3. Restart both backend and Flutter

### Add Logging
```python
# In backend/app.py
log_info("Your message")
log_success("Operation succeeded")
log_error("Something failed")
```

```dart
// In flutter_app/lib/main.dart
print('[FLUTTER] Your message');
```

### Reset Everything
```bash
# Stop backend (Ctrl+C)
# Stop Flutter (Ctrl+C)

# Backend
cd backend
source venv/bin/activate
python app.py

# Flutter (new terminal)
cd flutter_app
flutter clean
flutter pub get
flutter run
```

## 📊 Project Structure

```
├── backend/
│   ├── .env              ← Configure here
│   ├── .secrets          ← Add API keys here
│   ├── app.py            ← Backend code
│   └── requirements.txt
│
├── flutter_app/
│   ├── .env              ← Configure here
│   ├── lib/
│   │   └── main.dart     ← Flutter code
│   └── pubspec.yaml
│
└── [Documentation files]
```

## ⚡ Shortcuts

### Restart Backend
```bash
# In backend terminal: Ctrl+C, then ↑ (up arrow), Enter
```

### Hot Reload Flutter
```bash
# In Flutter terminal: Press 'r'
```

### View Logs
```bash
# Backend: Just look at terminal
# Flutter: Just look at terminal
```

## 🎨 Customization

### Colors (Flutter)
Edit `flutter_app/lib/main.dart` lines 20-50:
```dart
Color(0xFF6C63FF)  // Primary (purple)
Color(0xFF4ECDC4)  // Secondary (teal)
Color(0xFF0A0E27)  // Background (dark blue)
```

### Responses (Backend)
Edit `backend/app.py` function `generate_response()` around line 170

### Port (Both)
1. `backend/.env`: `PORT=8000`
2. `flutter_app/lib/main.dart`: `backendUrl = 'http://localhost:8000'`

## 📱 Device-Specific URLs

| Device | Backend URL |
|--------|-------------|
| iOS Simulator | `http://localhost:8000` |
| Android Emulator | `http://10.0.2.2:8000` |
| Physical Device | `http://YOUR_IP:8000` |

Find your IP:
```bash
# Mac/Linux
ifconfig | grep "inet "

# Windows
ipconfig
```

---

**Keep this file handy for quick reference!** 🚀


