# Babuntoo Academy

A comprehensive Flutter educational application designed to teach computer science fundamentals, programming languages, hardware components, software knowledge, and inspiring stories of scientists.

## 🚀 Quick Start - Setup & Run on Your Local Device

### Prerequisites

Before you begin, ensure you have the following installed:

1. **Flutter SDK** (3.0 or higher)
   - Download from: https://flutter.dev/docs/get-started/install
   - Verify installation: `flutter --version`

2. **Dart** (included with Flutter)
   - Verify: `dart --version`

3. **Git**
   - Download from: https://git-scm.com/

4. **IDE/Editor** (choose one)
   - Android Studio (recommended)
   - VS Code with Flutter extension
   - IntelliJ IDEA

5. **Android/iOS Setup**
   - For Android: Android Studio with SDK 21+
   - For iOS: Xcode 12+ (Mac only)



### Step 1: Clone the Repository

```bash
git clone https://github.com/Tahsan0619/babuntoo-academy.git
cd babuntoo_academy
```

### Step 2: Install Dependencies

```bash
flutter pub get
```

This command downloads all required packages listed in `pubspec.yaml`.

### Step 3: Configure API Keys (Required for Code Playground)

The Code Playground feature requires a Groq API key to execute and explain code snippets. 

**⚠️ IMPORTANT - API Key Policy:**

For security and ethical reasons, **API keys should never be shared or hardcoded in public repositories**. If you want to use the Code Playground feature:

**Option A: Get Your Own API Key**
1. Sign up for Groq API at: https://console.groq.com
2. Generate your own API key
3. Open `lib/code_playground_screen.dart`
4. Find line 9:
   ```dart
   const _groqKeyStorageKey = 'YOUR_GROQ_API_KEY_HERE';
   ```
5. Replace `YOUR_GROQ_API_KEY_HERE` with your own Groq API key
6. The app will securely store it on first launch

**Option B: Request API Key from Developer**
If you're unable to obtain your own API key or prefer to request one:
- **Contact**: tahsan@example.com
- **GitHub Issues**: https://github.com/Tahsan0619/babuntoo-academy/issues
- Explain your use case and I can provide guidance

**Security Note**: 
- Never commit API keys to version control
- API keys are stored securely using `flutter_secure_storage`
- Each user should use their own API key for production use

### Step 4: Run the App

#### On Android Device/Emulator:
```bash
flutter run
```

#### On iOS Device/Simulator (Mac only):
```bash
flutter run -d ios
```

#### On Web Browser:
```bash
flutter run -d chrome
```

#### On Windows/Linux (Desktop):
```bash
flutter run -d windows
# or
flutter run -d linux
```

### Step 5: View the App

The app will launch with:
- **Splash Screen**: Loading animation
- **Login/Signup**: Create or access your account
- **Home Menu**: Access all features

---

## 📚 How to Use the App

### Main Features

#### 1. **Hardware Learning**
- Navigate: Home → Hardware
- Learn about CPUs, GPUs, RAM, Storage, and Peripherals
- View detailed diagrams and specifications

#### 2. **Software Catalog**
- Navigate: Home → Software
- Browse popular applications by category
- Learn software functionalities

#### 3. **Learn Programming**
- Navigate: Home → Learn Programming
- Choose between C or Python
- Access interactive tutorials with examples

#### 4. **Code Playground**
- Navigate: Home → Code Playground
- Write and execute code snippets
- Get AI-powered explanations
- Supports Python and C

#### 5. **Scientists Timeline**
- Navigate: Home → Scientists
- Discover famous scientists and their contributions
- Browse historical timeline

#### 6. **Latest Inventions**
- Navigate: Home → Latest Inventions
- Stay updated with cutting-edge technology

#### 7. **Interactive Learning**
- Navigate: Home → Interactive Learning
- Deep dive into C programming topics
- Topics include:
  - Basics (Variables, Data Types, I/O)
  - Operators (Arithmetic, Logical, Bitwise)
  - Control Flow (if/else, switch)
  - Loops (for, while, do-while)
  - Functions & Recursion
  - Pointers & Arrays
  - Strings & Memory Management
  - And more...

#### 8. **Games**
- Navigate: Home → Games
- Play educational games (Hangman, etc.)
- Test your knowledge

#### 9. **Challenges**
- Navigate: Home → Challenges
- Solve programming challenges
- Track your progress

---

## 🛠️ Troubleshooting

### Issue: "flutter: command not found"
**Solution**: Add Flutter to your PATH
- Windows: Add Flutter\bin to system Environment Variables
- Mac/Linux: Add to ~/.bashrc or ~/.zshrc
  ```bash
  export PATH="$PATH:~/path/to/flutter/bin"
  ```

### Issue: "No devices found"
**Solution**:
```bash
flutter devices  # List connected devices
flutter emulators  # List available emulators
flutter emulators --launch <emulator_name>  # Launch emulator
```

### Issue: "Package version conflict"
**Solution**:
```bash
flutter clean
flutter pub get
flutter pub upgrade
```

### Issue: "API Key not working"
**Solution**:
- Verify your Groq API key is valid
- Check internet connection
- Make sure key is set in `lib/code_playground_screen.dart`

### Issue: App crashes on launch
**Solution**:
```bash
flutter clean
flutter pub get
flutter run --verbose  # Shows detailed error messages
```

---

## 📦 Project Structure

```
lib/
├── main.dart                    # App entry point
├── home_page.dart              # Main menu
├── hardware_page.dart          # Hardware learning
├── software_page.dart          # Software catalog
├── scientists_timeline_page.dart
├── latest_inventions_page.dart
├── code_playground_screen.dart # AI Code execution
├── interactive learning/       # Interactive tutorials
│   └── C/
│       ├── basics/
│       ├── operators/
│       ├── loops/
│       ├── functions/
│       ├── pointers/
│       ├── arrays/
│       └── ...
├── challenge/                  # Programming challenges
├── games/                      # Educational games
├── education/                  # Learning models
├── widgets/                    # Reusable components
├── models/                     # Data models
└── utils/                      # Utilities & constants
```

---

## 💡 Tips for Development

### Hot Reload
Press `r` in terminal to hot reload (fast UI changes)
```bash
flutter run
# Then press 'r' to reload
# Press 'R' to restart the app
```

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

Last Updated: December 8, 2025