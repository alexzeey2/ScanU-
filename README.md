# 💳 Balance Scanner

AI-Powered Bank Account Balance Detection System

## Features

- 📷 **Live Camera Mode** - Real-time balance detection
- 🎥 **Video Recording** - Record and analyze videos
- 📁 **File Upload** - Analyze pre-recorded videos
- 🔄 **Camera Switching** - Toggle between front/back cameras
- 📸 **Photo Capture** - Save screenshots with overlays
- 💾 **History Tracking** - All analyses saved locally

## How It Works

The app uses TensorFlow.js BlazeFace for face detection and analyzes:
- Visual appearance
- Lighting and colors
- Positioning
- Environmental cues

All processing happens locally in your browser - nothing is uploaded!

## Tech Stack

- HTML5 Canvas
- TensorFlow.js (BlazeFace)
- localStorage for data persistence
- MediaDevices API for camera access

## Privacy

- 100% client-side processing
- No data sent to servers
- All analyses stored locally
- Camera access only when you allow it

## Usage

1. Click "Live Camera" to start real-time detection
2. Point at people to see their estimated balance
3. Capture photos or record videos
4. View history of all analyses

Perfect for social media content and entertainment!

## Browser Support

Works best on modern browsers with camera access:
- Chrome/Edge 90+
- Firefox 85+
- Safari 14+
- Mobile browsers (iOS Safari, Chrome Mobile)

## Local Development

```bash
python3 -m http.server 3000
```

Then open http://localhost:3000

## Deployment

Deploy to Vercel with one click!

## License

MIT
