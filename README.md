# Babuntoo Academy

A Flutter learning app that covers computer science fundamentals, programming (C & Python), hardware, software, scientists, inventions, challenges, games, and an AI-powered code playground.

## 🧭 Overview

- Learning modules for hardware, software, programming, scientists timeline, and latest inventions
- Interactive C learning paths, challenges, and educational games (e.g., Hangman)
- Code Playground with AI explanations (requires your own Groq API key)
- Responsive UI, dark/light themes, and reusable widgets
- Simple email/password demo auth (local `SharedPreferences`) that you can swap for your backend later

## 🚀 Quick Start

Prerequisites: Flutter 3.0+, Dart 3+, Git, and platform SDKs (Android Studio / Xcode as needed).

1) Clone and install
```bash
git clone https://github.com/Tahsan0619/babuntoo-academy.git
cd babuntoo_academy
flutter pub get
```

2) (Optional) Enable Code Playground
- Open `lib/code_playground_screen.dart`
- Set your Groq API key where indicated; keys are stored via `flutter_secure_storage`

3) Run
```bash
flutter run           # Android/iOS/emulator
flutter run -d chrome # Web
flutter run -d windows  # Windows desktop
```

## 🔐 Authentication (Demo)

- Email/password flows live in `login_page_with_api.dart` and `signup_page_with_api.dart`
- Credentials are stored locally in `SharedPreferences` for demo only (plain text)
- Replace with your real backend when ready; update the login/signup pages accordingly

## ✨ Key Features

- Hardware learning: CPUs, GPUs, RAM, storage, peripherals
- Software catalog: OS, productivity, dev tools, multimedia, security
- Programming tutorials: C (basics → memory mgmt), Python fundamentals
- Scientists timeline and latest inventions
- Interactive learning paths, challenges, and educational games
- Code Playground: run/explain/review snippets (Python/C) with AI help

## 🧱 Project Structure (high level)

```
lib/
├── main.dart                     # Entry & routes
├── splash_screen.dart
├── login_page_with_api.dart      # Demo email/password auth
├── signup_page_with_api.dart
├── home_page.dart
├── hardware_page.dart
├── software_page.dart
├── scientists_timeline_page.dart
├── latest_inventions_page.dart
├── programming_languages_page.dart
├── learn_programming_menu_page.dart
├── interactive learning/         # Interactive C/Python content
├── challenge/                    # Challenges
├── games/                        # Educational games (Hangman, etc.)
├── playground/ & code_playground_screen.dart
├── education/                    # Education models & quizzes
├── widgets/                      # Reusable UI components
├── models/                       # Data models
└── utils/                        # Constants, theme, navigation
```

## 🛠️ Build & Platform Targets

```bash
flutter build apk        # Android
flutter build appbundle  # Play Store bundle
flutter build ios        # iOS (on macOS)
flutter build web        # Web
```

## 🔧 Troubleshooting

- `flutter: command not found`: add Flutter `bin` to PATH
- No devices: `flutter devices`, `flutter emulators --launch <name>`
- Version conflicts: `flutter clean && flutter pub get`
- App crash: `flutter run --verbose` for detailed logs
- Code Playground issues: ensure a valid Groq API key is set

## 🤝 Contributing

1. Fork → create a branch → commit → open PR
2. Keep secrets out of source control (use env/secure storage)
3. Follow Dart/Flutter lints from `analysis_options.yaml`

## 📜 License

MIT License (see `LICENSE` if present).

## 📫 Support

- Issues: https://github.com/Tahsan0619/babuntoo-academy/issues
- Email: tahsan@example.com

Made with ❤️ for learners and educators.

### Debug Mode
Run with more information:
```bash
flutter run --verbose
flutter run --debug  # Default
```

### Release Build
Create optimized build:
```bash
flutter build apk          # Android
flutter build ios          # iOS
flutter build web          # Web
flutter build windows      # Windows
```

### View App on Real Device
1. Connect device via USB
2. Enable Developer Mode on device
3. Run: `flutter devices`
4. Run: `flutter run`

---

## 📱 Supported Platforms

| Platform | Status | Command |
|----------|--------|---------|
| Android | ✅ Supported | `flutter run -d android` |
| iOS | ✅ Supported | `flutter run -d ios` |
| Web | ✅ Supported | `flutter run -d chrome` |
| Windows | ✅ Supported | `flutter run -d windows` |
| macOS | ✅ Supported | `flutter run -d macos` |
| Linux | ✅ Supported | `flutter run -d linux` |

---

## 🔐 Important Notes

- **API Keys**: Never commit API keys to version control
- **Secure Storage**: Sensitive data is stored securely using `flutter_secure_storage`
- **Privacy**: The app doesn't collect personal data beyond login
- **Internet Required**: Most features require an active internet connection

---

## 📚 Key Dependencies

```yaml
flutter: ^3.0.0
provider: ^6.1.0                    # State management
http: ^1.2.2                        # API requests
flutter_secure_storage: ^9.2.2      # Secure storage
webview_flutter: ^4.4.2             # Web content
video_player: ^2.8.2                # Video playback
url_launcher: ^6.2.1                # Open links
shared_preferences: ^2.0.15         # Local storage
```

See `pubspec.yaml` for complete list.

---

## 🐛 Reporting Issues

Found a bug? Please report it:
1. Go to: https://github.com/Tahsan0619/babuntoo-academy/issues
2. Click "New Issue"
3. Describe the problem with steps to reproduce
4. Include device info and Flutter version

---

## ✉️ Contact

- **GitHub Repository**: https://github.com/Tahsan0619/babuntoo-academy
- **Issues & Support**: https://github.com/Tahsan0619/babuntoo-academy/issues
- **Developer Email**: tahsan@example.com
- **API Key Support**: Contact the developer if you need guidance on obtaining your own Groq API key

---

## 🎯 Features Overview

✅ Interactive C Programming Tutorial  
✅ Python Learning Path  
✅ Hardware Component Details  
✅ Software Catalog  
✅ Scientists Timeline  
✅ Latest Innovations  
✅ Code Playground with AI  
✅ Educational Games  
✅ Programming Challenges  
✅ Dark/Light Theme  
✅ Responsive Design  

---

## 📊 App Highlights

- **450+ Files** of educational content
- **70,000+ Lines** of code
- **Supports** Android, iOS, Web, Windows, macOS, Linux
- **No Ads** - Fully educational focus
- **Open Source** - Contribute and improve!

---

**Happy Learning! 🎓**

Last Updated: December 12, 2025

---

## 🆕 Version 1.09 Highlights

- Challenge MCQs redesigned with scoring modes (Standard, Timed Bonus)
- Timed Bonus includes a 10s visible countdown per question
- Per-language scoring mode selector + global default toggle
- Dedicated education model pages with rich, responsive content
- Faster header image loading via precaching on navigation
- Additional UI polish: overflow-safe sections, improved grids

### Upgrading from 1.08 → 1.09

No breaking changes. Features added:
- Scoring mode enum and UI toggles
- Quiz page fractional scoring and summary updates
- Model detail pages enhanced with images, tips, and references

To run:
```bash
flutter pub get
flutter run
```