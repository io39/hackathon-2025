# Video Analyzer - User Flow

## 🎯 Complete User Journey

### Flow Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                     START: App Launch                        │
└─────────────────────┬───────────────────────────────────────┘
                      │
                      ▼
        ┌─────────────────────────────┐
        │   HOME SCREEN               │
        │   • App logo with gradient  │
        │   • "Video Analyzer" title  │
        │   • URL input field         │
        │   • "Analyze Video" button  │
        │   • "Quick Test" button     │
        └─────────────┬───────────────┘
                      │
                      │ User enters URL or clicks test
                      ▼
        ┌─────────────────────────────┐
        │   LOADING STATE             │
        │   • Spinner animation       │
        │   • "Processing video..."   │
        └─────────────┬───────────────┘
                      │
                      │ Backend confirms receipt
                      ▼
        ┌─────────────────────────────────────────────────┐
        │   ACTION OVERLAY (Bottom Sheet)                 │
        │   ┌─────────────────────────────────────────┐  │
        │   │ 🛡️  Hoax Check                         │  │
        │   │    "Verify the authenticity..."         │  │
        │   ├─────────────────────────────────────────┤  │
        │   │ 💡  Explain This                        │  │
        │   │    "Get a detailed explanation..."      │  │
        │   ├─────────────────────────────────────────┤  │
        │   │ 🌟  Expand This Idea                    │  │
        │   │    "Explore related concepts..."        │  │
        │   ├─────────────────────────────────────────┤  │
        │   │ ❓  Custom Question                     │  │
        │   │    [Text input field]                   │  │
        │   └─────────────────────────────────────────┘  │
        └─────────────┬───────────────────────────────────┘
                      │
                      │ User selects an option
                      ▼
        ┌─────────────────────────────┐
        │   ANALYZING STATE           │
        │   • Spinner animation       │
        │   • "Analyzing video..."    │
        │   • 2-second delay          │
        └─────────────┬───────────────┘
                      │
                      │ Backend returns results
                      ▼
        ┌─────────────────────────────────────────────┐
        │   RESULTS DISPLAY                           │
        │   ┌─────────────────────────────────────┐  │
        │   │ Video Received ✓                    │  │
        │   │ [Video URL]                         │  │
        │   │                                     │  │
        │   │ ─────────────────────────────       │  │
        │   │                                     │  │
        │   │ Result:                             │  │
        │   │ [Analysis text with formatted       │  │
        │   │  response based on selected         │  │
        │   │  action - detailed explanation]     │  │
        │   │                                     │  │
        │   └─────────────────────────────────────┘  │
        └─────────────┬───────────────────────────────┘
                      │
                      │ User can reset or analyze new video
                      ▼
                  [RETURN TO HOME]
```

## 📱 Screen-by-Screen Breakdown

### 1. Home Screen (Initial State)

**Visual Elements:**
- Gradient background (dark blue)
- App icon with gradient and glow effect
- Title: "Video Analyzer"
- Subtitle: "Analyze videos with AI"
- Card with URL input
- "Analyze Video" button
- "Quick Test with Sample" link at bottom

**User Actions:**
- Paste video URL
- Press Enter or click "Analyze Video"
- Click "Quick Test" for demo

### 2. Processing State

**Visual Elements:**
- Loading spinner (purple)
- Text: "Processing video..."
- Gray text color

**Backend Action:**
- POST request to `/api/video`
- Sends video URL
- Waits for confirmation

### 3. Action Selection Overlay

**Visual Elements:**
- Bottom sheet slides up from bottom
- Dark background with rounded top corners
- Handle bar at top
- Title: "Analyze Video"
- 4 option cards with icons and colors:
  - Red: Hoax Check
  - Yellow: Explain This
  - Teal: Expand This Idea
  - Custom: Question input field
- Each card shows icon, title, and subtitle

**User Actions:**
- Tap any of the 3 preset options
- Type custom question and press send icon

### 4. Analyzing State

**Visual Elements:**
- Loading spinner in overlay
- Text: "Analyzing video..."
- Buttons disabled

**Backend Action:**
- POST request to `/api/analyze`
- Sends: video URL, action type, optional question
- Waits 2 seconds (simulated processing)
- Receives formatted response

### 5. Results Display

**Visual Elements:**
- Overlay closes
- Results card appears on home screen
- Green checkmark: "Video Received"
- Video URL displayed
- Divider line
- "Result:" header
- Analysis text in formatted box
- Refresh button to reset

**User Actions:**
- Read results
- Click refresh to analyze new video
- Scroll through long responses

## 🎨 Visual Design Elements

### Color Coding by Action

| Action | Color | Icon | Purpose |
|--------|-------|------|---------|
| Hoax Check | `#FF6B6B` (Red) | 🛡️ | Security/verification |
| Explain This | `#FFD93D` (Yellow) | 💡 | Information/learning |
| Expand Idea | `#4ECDC4` (Teal) | 🌟 | Exploration/discovery |
| Custom Question | `#6C63FF` (Purple) | ❓ | Personalization |

### Animation States

1. **Idle**: Gradient animation on app icon
2. **Loading**: Circular progress indicator
3. **Transition**: Bottom sheet slide up/down
4. **Success**: Checkmark icon pulse
5. **Error**: Red error box with icon

## 💬 Sample Interactions

### Scenario 1: Hoax Check
```
User: Enters YouTube URL
App:  "Processing video..."
App:  Shows action overlay
User: Taps "Hoax Check"
App:  "Analyzing video..." (2 seconds)
App:  Shows detailed hoax analysis with:
      - Authenticity rating
      - Source credibility
      - Verification results
      - Recommendations
```

### Scenario 2: Custom Question
```
User: Enters TikTok URL
App:  "Processing video..."
App:  Shows action overlay
User: Types "What is the main message?"
User: Clicks send icon
App:  "Analyzing video..." (2 seconds)
App:  Shows custom response addressing the question
```

## 🔄 Error Handling

### Connection Error
```
┌─────────────────────────────┐
│ ❌ Error Dialog              │
│                             │
│ Failed to connect to        │
│ backend: [error details]    │
│                             │
│           [OK]              │
└─────────────────────────────┘
```

### Invalid URL
- App accepts any URL format
- Backend validates and processes

## 📊 State Management

The app maintains these states:
- `_sharedVideoUrl`: Current video URL (null | string)
- `_isProcessing`: Loading state (bool)
- `_result`: Analysis result (null | string)
- `_errorMessage`: Error message (null | string)

## 🎯 User Experience Goals

✅ **Simplicity**: One-tap to start analysis
✅ **Clarity**: Clear visual feedback at each step
✅ **Speed**: Fast transitions, 2-second processing
✅ **Beauty**: Modern, professional design
✅ **Feedback**: Always show what's happening
✅ **Flexibility**: 4 different analysis options

## 🚀 Performance

- Initial load: < 1 second
- URL submission: Instant
- Backend response: < 100ms
- Analysis simulation: 2 seconds (as requested)
- Total flow: ~3-4 seconds from start to result

---

**The entire user experience is designed to be intuitive, fast, and visually appealing!** 🎉


