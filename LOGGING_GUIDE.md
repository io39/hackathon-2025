# Logging Guide

## 📊 Overview

Both the Flutter app and backend now have comprehensive logging to help you understand what's happening at each step.

## 🐍 Backend Logging

### What's Logged

The backend logs every step with timestamps and status indicators:

```
============================================================
[2025-11-29 10:30:15] [INFO] Server starting...
[2025-11-29 10:30:15] [INFO] Loading configuration from .env and .secrets files
[2025-11-29 10:30:15] [INFO] Server Host: 0.0.0.0
[2025-11-29 10:30:15] [INFO] Server Port: 8000
[2025-11-29 10:30:15] [INFO] Debug Mode: True
[2025-11-29 10:30:15] [INFO] Processing Delay: 2s
============================================================

============================================================
[2025-11-29 10:30:20] [REQUEST] POST /api/video
[2025-11-29 10:30:20] [DATA] {'video_url': 'https://youtube.com/...'}
============================================================
[2025-11-29 10:30:20] [INFO] Received video URL: https://youtube.com/...
[2025-11-29 10:30:20] [INFO] Generated video ID: 123456789
[2025-11-29 10:30:20] [✓ SUCCESS] Video stored successfully (Total videos: 1)
[2025-11-29 10:30:20] [RESPONSE ✓] Status: 200
[2025-11-29 10:30:20] [RESPONSE DATA] {'status': 'success', ...}
------------------------------------------------------------

============================================================
[2025-11-29 10:30:25] [REQUEST] POST /api/analyze
[2025-11-29 10:30:25] [DATA] {'video_url': '...', 'action': 'hoax_check'}
============================================================
[2025-11-29 10:30:25] [INFO] Starting analysis...
[2025-11-29 10:30:25] [INFO]   - Video URL: https://youtube.com/...
[2025-11-29 10:30:25] [INFO]   - Action: hoax_check
[2025-11-29 10:30:25] [INFO] Processing... (simulating 2 second delay)
[2025-11-29 10:30:27] [INFO] Generating response based on action type...
[2025-11-29 10:30:27] [INFO] Generating response for action: hoax_check
[2025-11-29 10:30:27] [✓ SUCCESS] Response generated successfully (450 chars)
[2025-11-29 10:30:27] [✓ SUCCESS] Analysis complete for action: hoax_check
[2025-11-29 10:30:27] [INFO] Response length: 450 characters
[2025-11-29 10:30:27] [RESPONSE ✓] Status: 200
------------------------------------------------------------
```

### Log Format

```
[TIMESTAMP] [LEVEL] Message
```

**Levels:**
- `[INFO]` - General information
- `[✓ SUCCESS]` - Successful operations
- `[✗ ERROR]` - Errors and failures
- `[REQUEST]` - Incoming API requests
- `[RESPONSE ✓]` - Successful responses
- `[RESPONSE ✗]` - Error responses
- `[DATA]` - Request/response data

### Configuration

Edit `backend/.env` to change logging:

```bash
LOG_LEVEL=DEBUG    # More detailed logs
LOG_LEVEL=INFO     # Standard logs (default)
LOG_LEVEL=WARNING  # Only warnings and errors
LOG_LEVEL=ERROR    # Only errors
```

## 📱 Flutter Logging

### What's Logged

The Flutter app logs every network request and response:

```
============================================================
[FLUTTER] Sending video to backend
[FLUTTER] Video URL: https://www.youtube.com/watch?v=dQw4w9WgXcQ...
[FLUTTER] Backend URL: http://localhost:8000/api/video
============================================================
[FLUTTER] Request body: {video_url: https://www.youtube.com/...}
[FLUTTER] Response received in 245ms
[FLUTTER] Status code: 200
[FLUTTER] Response body: {"status":"success","message":"Video received successfully","video_id":"123456789"}
[FLUTTER] ✓ Video received successfully
[FLUTTER] Video ID: 123456789
[FLUTTER] Showing action overlay...
------------------------------------------------------------

============================================================
[FLUTTER] Sending analysis request
[FLUTTER] Action: hoax_check
============================================================
[FLUTTER] Request body: {video_url: https://..., action: hoax_check, custom_question: null}
[FLUTTER] Waiting for backend response...
[FLUTTER] Response received in 2245ms
[FLUTTER] Status code: 200
[FLUTTER] ✓ Analysis successful
[FLUTTER] Response length: 450 characters
[FLUTTER] Closing overlay and showing results
------------------------------------------------------------
```

### Log Format

```
[FLUTTER] Message
```

**Indicators:**
- `✓` - Success
- `✗` - Error
- `Request body:` - Outgoing data
- `Response received in Xms` - Timing information

### Where to See Logs

**VS Code / Cursor:**
- Terminal where you ran `flutter run`
- Debug Console tab

**Android Studio:**
- Run tab at bottom
- Logcat tab (filter for "flutter")

**Xcode (iOS):**
- Console output at bottom

## 🔍 Debugging Scenarios

### Scenario 1: Connection Failed

**Flutter logs:**
```
[FLUTTER] ✗ Exception occurred: Failed host lookup: 'localhost'
```

**Solution:** Backend not running or wrong URL

**Check:**
1. Is backend running? Look for backend logs
2. Using correct URL? (localhost for iOS, 10.0.2.2 for Android)

---

### Scenario 2: Timeout

**Flutter logs:**
```
[FLUTTER] Waiting for backend response...
[FLUTTER] Response received in 30245ms
[FLUTTER] ✗ Exception occurred: TimeoutException
```

**Backend logs:**
```
[INFO] Processing... (simulating 2 second delay)
[✗ ERROR] Exception in analyze_video: ...
```

**Solution:** Check backend error logs for the actual issue

---

### Scenario 3: Wrong Port

**Flutter logs:**
```
[FLUTTER] Backend URL: http://localhost:5000/api/video
[FLUTTER] ✗ Exception occurred: Connection refused
```

**Solution:** Port mismatch

**Fix:**
1. Check backend `.env` for `PORT=8000`
2. Update Flutter `main.dart` to use port 8000

---

### Scenario 4: Success Flow

**Backend logs:**
```
[✓ SUCCESS] Video stored successfully
[✓ SUCCESS] Analysis complete for action: hoax_check
```

**Flutter logs:**
```
[FLUTTER] ✓ Video received successfully
[FLUTTER] ✓ Analysis successful
```

**Result:** Everything working correctly! 🎉

## 📈 Performance Monitoring

### Response Times

**Flutter logs show timing:**
```
[FLUTTER] Response received in 245ms    # Fast!
[FLUTTER] Response received in 2245ms   # Expected (2s delay)
[FLUTTER] Response received in 5000ms   # Slow - investigate
```

### Backend Processing

**Backend logs show steps:**
```
[INFO] Processing... (simulating 2 second delay)
# 2 seconds pass
[✓ SUCCESS] Response generated successfully
```

## 🛠️ Customizing Logs

### Backend

Edit `backend/app.py` log functions:

```python
def log_info(message):
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    print(f"[{timestamp}] [INFO] {message}")
```

**Add custom logs:**
```python
log_info("Custom message here")
log_success("Operation completed")
log_error("Something went wrong")
```

### Flutter

Add logs in `lib/main.dart`:

```dart
print('[FLUTTER] Your custom message');
print('[FLUTTER] Variable value: $variable');
```

## 📝 Log Analysis

### Finding Issues

1. **Search for errors:**
```bash
# In backend terminal
grep "ERROR" backend.log

# Or just look for ✗ symbol
```

2. **Check timing:**
```bash
# Look for "Response received in" in Flutter logs
grep "Response received" flutter.log
```

3. **Verify data flow:**
- Request logged? ✓
- Backend received it? ✓
- Response sent? ✓
- Flutter received it? ✓

## 🎯 Best Practices

✅ **DO:**
- Keep terminal visible while developing
- Read logs when something fails
- Check both Flutter AND backend logs
- Use logs to understand flow

❌ **DON'T:**
- Ignore error logs
- Remove logging code
- Only check one side (frontend/backend)
- Assume everything works without checking

## 📊 Log Examples by Action

### Hoax Check
```
[FLUTTER] Action: hoax_check
[BACKEND] [INFO] Starting analysis...
[BACKEND] [INFO]   - Action: hoax_check
[BACKEND] [INFO] Generating response for action: hoax_check
[BACKEND] [✓ SUCCESS] Analysis complete for action: hoax_check
```

### Custom Question
```
[FLUTTER] Custom Question: What is the main point?
[BACKEND] [INFO] Starting analysis...
[BACKEND] [INFO]   - Action: custom_question
[BACKEND] [INFO]   - Custom Question: What is the main point?
[BACKEND] [✓ SUCCESS] Analysis complete for action: custom_question
```

## 🔧 Troubleshooting Commands

**View backend logs:**
```bash
cd backend
python app.py 2>&1 | tee backend.log
```

**View Flutter logs:**
```bash
cd flutter_app
flutter run 2>&1 | tee flutter.log
```

**Search logs:**
```bash
# Find errors
grep "ERROR\|Exception" backend.log

# Find successful requests
grep "SUCCESS" backend.log

# Check response times
grep "Response received" flutter.log
```

---

**With comprehensive logging, debugging is now much easier!** 🎉

**Tip:** Keep both terminal windows visible side-by-side to see the full request/response flow in real-time!


