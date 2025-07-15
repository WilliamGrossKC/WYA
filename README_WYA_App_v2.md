# 🎉 WYA (Where You At?) — Group Pin Drop App for Concerts

**WYA** is a Swift-based iOS app that lets you and your friends plan concert meetups by creating groups and pinning **who will be where, and when** — all on a shared map. Whether it’s a massive music festival or a local club night, WYA helps you coordinate effortlessly.

---

## 📱 Features

- 📍 Upload a map (venue, festival layout, etc.)
- 👥 Create a group and invite members
- 📌 Tap to drop pins for your planned locations
- ⏰ Assign times to each pin
- 🔄 View a map of all your friends' planned movements
- 🧭 Navigate in real-time with pin overlays

---

## 🛠️ Tech Stack

- **Language**: Swift
- **Framework**: SwiftUI
- **State Management**: `@EnvironmentObject`, `@StateObject`
- **Persistence**: CoreData
- **Image Uploads**: UIKit-backed `UIImagePickerController`

---

## ⚙️ Architecture

**Note:** This app is currently **frontend-only** and runs entirely in SwiftUI. It has no backend yet, so pin drops and group data are stored in-memory only and **do not persist across sessions**. You may extend it by integrating Firebase, CoreData, or a custom backend for persistence.

## 🚀 Getting Started

### Clone the project

```bash
git clone https://github.com/yourusername/wya-app.git
cd wya-app
```

### Open in Xcode

1. Launch `WYA.xcodeproj` or `WYAApp.swift` in Xcode
2. Build & run on simulator or device (iOS 16+)

---

## 📂 Core File Structure

| File                         | Description                                      |
|-----------------------------|--------------------------------------------------|
| `WYAApp.swift`              | App entry point with shared environment data     |
| `ContentView.swift`         | Initial app shell                                |
| `UploadGroupInfoPage.swift` | Create groups and upload venue images            |
| `ResultPage.swift`          | View map with group members and pins             |
| `Classes.swift`             | Models for Group, Person, Pin, and AppData       |
| `Utils.swift`               | Navigation bar styling utilities                 |

---

## 📸 Screenshots

*Insert screenshots here of Upload page, Pin drop interface, group map view, etc.*

---

## 🧠 Future Features

- Real-time updates via Firebase or WebSockets
- Push notifications for pin changes
- Authentication and sharing links
- RSVP functionality and location check-ins

---

## 👨‍💻 Author

William Gross  
[LinkedIn](https://www.linkedin.com/in/yourprofile) • [GitHub](https://github.com/yourusername)

---

## 📄 License

MIT License
