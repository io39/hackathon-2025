# ✅ Instagram Share Extension - Testing Checklist

## Pre-Flight Checklist

### Backend Setup
- [ ] Backend is running: `cd backend && ./start.sh`
- [ ] Backend is accessible: Open `http://localhost:8000` in browser
- [ ] Found Mac IP address: `ipconfig getifaddr en0`
- [ ] Updated IP in ShareViewController.swift (line 10)

### iOS App Setup
- [ ] iPhone connected via USB OR on same Wi-Fi as Mac
- [ ] Xcode opened: `open flutter_app/ios/Runner.xcworkspace`
- [ ] Code signing configured for both targets:
  - [ ] Runner
  - [ ] MyAppShareExtension
- [ ] Build succeeded without errors

## Build & Install

Choose one method:

### Option A: Xcode
- [ ] Opened Xcode workspace
- [ ] Selected iPhone from device list
- [ ] Clicked Play button (▶️)
- [ ] App installed successfully
- [ ] App icon visible on iPhone home screen

### Option B: Flutter
- [ ] Ran: `cd flutter_app && flutter run --release`
- [ ] Build completed without errors
- [ ] App launched on iPhone

## Instagram Testing

### First Test - Does it appear?
- [ ] Opened Instagram app
- [ ] Navigated to any post/reel
- [ ] Tapped Share button (📤 or ✈️)
- [ ] Looked for "Video Analyzer" in app list
- [ ] If not visible, checked "More" section
- [ ] Found "Video Analyzer"! ✅

### Second Test - Does it open?
- [ ] Tapped "Video Analyzer" icon
- [ ] Extension opened (bottom sheet appeared)
- [ ] Saw dark blue/purple background
- [ ] Saw "Analyze Video" title
- [ ] Saw three action buttons with emojis:
  - [ ] 🛡️ Hoax Check (red border)
  - [ ] 💡 Explain This (yellow border)
  - [ ] 🌟 Expand This Idea (cyan border)

### Third Test - Does it work?
- [ ] Tapped one of the action buttons
- [ ] Buttons disappeared
- [ ] Title changed to "Analyzing..."
- [ ] Loading spinner appeared
- [ ] Waited for response (5-30 seconds)
- [ ] Results appeared in text view
- [ ] Results are readable (white text on dark background)
- [ ] Results are scrollable (if long)
- [ ] Tapped "Done" button
- [ ] Returned to Instagram
- [ ] Instagram still showing same post

### Fourth Test - Verify backend communication
- [ ] Checked backend terminal logs
- [ ] Saw POST request to `/api/video`
- [ ] Saw POST request to `/api/analyze`
- [ ] No error messages in backend
- [ ] Response returned successfully

### Fifth Test - Check extension logs
- [ ] Opened new terminal
- [ ] Ran: `flutter logs | grep "SHARE EXTENSION"`
- [ ] Saw: "Processing 1 attachments"
- [ ] Saw: "✓ Received URL"
- [ ] Saw: "Sending to backend"
- [ ] Saw: "✓ Video received by backend"
- [ ] Saw: "Analyzing with action: [action_name]"
- [ ] Saw: "✓ Analysis complete"

## Full Feature Testing

### Test All Actions
- [ ] Hoax Check works
- [ ] Explain This works
- [ ] Expand This Idea works

### Test Different Instagram Content
- [ ] Regular post with video
- [ ] Instagram Reel
- [ ] Instagram Story (with video)
- [ ] IGTV video
- [ ] Carousel post (multiple images/videos)

### Test Other Apps (Bonus)
- [ ] TikTok video
- [ ] YouTube video (from app)
- [ ] YouTube video (from Safari)
- [ ] Twitter/X video
- [ ] Safari - any video website

## Edge Cases & Error Handling

### Network Issues
- [ ] Tested with backend stopped → Shows error message
- [ ] Tested with wrong IP → Shows timeout error
- [ ] Tested with iPhone on different network → Shows connection error

### Content Issues
- [ ] Tested with private Instagram post
- [ ] Tested with deleted/unavailable post
- [ ] Tested with very short video
- [ ] Tested with very long video

### UI/UX Issues
- [ ] Tapped outside extension → Closes properly
- [ ] Rotated device → UI adjusts correctly
- [ ] Opened multiple times in a row → Works each time
- [ ] Switched between apps while analyzing → Continues correctly

## Performance Check

- [ ] Extension loads in <2 seconds
- [ ] UI is smooth (no lag or stuttering)
- [ ] Results appear within 30 seconds
- [ ] Memory usage reasonable (<50MB)
- [ ] App doesn't crash
- [ ] Extension doesn't freeze
- [ ] No warning messages in logs

## Final Verification

### Visual Quality
- [ ] Colors match design (dark theme)
- [ ] Text is readable
- [ ] Buttons are properly sized
- [ ] Spacing looks good
- [ ] No UI elements overlap
- [ ] Emojis display correctly

### User Experience
- [ ] Flow is intuitive
- [ ] Loading states are clear
- [ ] Error messages are helpful
- [ ] Navigation works smoothly
- [ ] Returns to Instagram cleanly

### Technical
- [ ] No crashes
- [ ] No memory leaks
- [ ] Logs are clean (no errors)
- [ ] Backend responds correctly
- [ ] Extension completes properly

## Known Limitations

Documented:
- [ ] Extension has 30-second timeout
- [ ] Extension memory limit ~30MB
- [ ] Backend must be on same network
- [ ] Private posts may not work
- [ ] Very long videos may timeout

## Troubleshooting Done

If issues occurred, tried:
- [ ] Clean build: `flutter clean && flutter pub get`
- [ ] Reinstall app on iPhone
- [ ] Restart iPhone
- [ ] Restart Mac
- [ ] Check firewall settings
- [ ] Verify bundle identifiers
- [ ] Verify code signing
- [ ] Check Xcode logs
- [ ] Check backend logs
- [ ] Update backend IP address

## Documentation Review

- [ ] Read `INSTAGRAM_SHARE_SUMMARY.md`
- [ ] Read `QUICK_TEST_INSTAGRAM.md`
- [ ] Understand flow from `WHAT_TO_EXPECT.md`
- [ ] Know where to find detailed setup: `INSTAGRAM_SHARE_SETUP.md`

## Demo Preparation

- [ ] Backend running and stable
- [ ] App installed on demo iPhone
- [ ] Tested end-to-end flow
- [ ] Have backup video URLs ready
- [ ] Know how to show logs if needed
- [ ] Can explain the flow clearly
- [ ] Prepared for common questions

## Success Confirmation

If you can check all these, you're ready to demo! ✅

- [ ] Extension appears in Instagram share sheet
- [ ] Extension opens with correct UI
- [ ] All three actions work
- [ ] Results display correctly
- [ ] Can return to Instagram
- [ ] Works reliably (tested 5+ times)
- [ ] Performance is acceptable
- [ ] No major bugs or crashes

---

## Status

Date: _____________
Time: _____________
Result: ☐ PASS  ☐ FAIL  ☐ PARTIAL

Notes:
_____________________________________________
_____________________________________________
_____________________________________________

## Next Steps

After passing all checks:
- [ ] Demo to team
- [ ] Gather feedback
- [ ] Plan improvements
- [ ] Consider adding custom branding
- [ ] Test on multiple devices
- [ ] Prepare for production deployment

---

**Congratulations!** 🎉 Your Instagram Share Extension is working!

