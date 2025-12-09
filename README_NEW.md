# Babuntoo Academy

A comprehensive Flutter educational application designed to teach computer science fundamentals, programming languages, hardware components, software knowledge, and inspiring stories of scientists. The app combines interactive learning, coding challenges, and educational games to make learning engaging and fun.

## 🎯 Overview

Babuntoo Academy is a mobile-first educational platform that covers:

- **PC Hardware**: Deep dive into CPUs, GPUs, RAM, storage, and peripherals
- **Software**: Explore popular applications and their functionalities  
- **Programming Languages**: Learn C and Python through interactive lessons
- **Scientists Timeline**: Discover influential scientists and their contributions
- **Latest Inventions**: Stay updated with cutting-edge technological innovations
- **Interactive Learning**: Hands-on C programming tutorials with examples
- **Code Playground**: Execute code snippets with AI-powered explanations
- **Educational Games**: Hangman game and other learning games
- **Challenges**: Test your knowledge with programming challenges

## ✨ Features

### 📚 Learning Modules

- **Hardware Learning**: Detailed exploration of computer components with diagrams
  - CPU Architecture and Components
  - GPU (Integrated & Discrete)
  - Memory (RAM, ROM, Storage)
  - Peripherals and Devices
  
- **Software Library**: Comprehensive software database
  - OS, Productivity, Development Tools
  - Multimedia, Security, Utilities
  
- **Programming Tutorials**
  - C Programming: Basics, Arrays, Pointers, Functions, Strings, Memory Management
  - Python Programming: Fundamentals and practical examples
  - Interactive code examples with output
  
- **Scientists Database**: Timeline of great scientists and their discoveries

- **Latest Inventions**: Curated list of recent technological breakthroughs

### 🎮 Interactive Features

- **Code Playground**: Write and execute code with AI-powered explanations
  - Support for Python and C
  - Multiple execution styles: run, explain, review
  - Secure API key storage
  
- **Challenges**: Programming challenges to test knowledge
  
- **Educational Games**:
  - Hangman game
  - More games coming soon
  
- **Education Models**: Learning frameworks including Bloom's Taxonomy

### ⚙️ Technical Features

- Dark/Light theme support
- Responsive design for multiple screen sizes
- Secure storage for sensitive data
- State management with Provider
- Smooth animations and transitions
- Web view support for embedded content
- Video player integration

## 🛠️ Tech Stack

### Frontend
- **Framework**: Flutter 3.0+
- **Language**: Dart
- **UI**: Material Design
- **State Management**: Provider 6.1.0

### Key Dependencies
- `flutter_secure_storage`: Secure credential storage
- `http`: API requests
- `webview_flutter`: Web content display
- `video_player`: Video playback
- `url_launcher`: External link handling
- `shared_preferences`: Local data persistence
- `package_info_plus`: App information
- `font_awesome_flutter`: Icon library

### Backend Integration
- RESTful API integration with HTTP
- Groq API integration for code explanation/execution
- Secure API key management

## 📁 Project Structure

```
lib/
├── main.dart                          # App entry point & routing
├── home_page.dart                     # Main home screen
├── login_page.dart                    # Authentication
├── signup_page.dart                   # User registration
├── splash_screen.dart                 # Splash/loading screen
│
├── hardware_page.dart                 # Hardware learning hub
├── hardware_detail/                   # Hardware component details
│   ├── cpu_detail_page.dart
│   ├── gpu_detail_page.dart
│   ├── motherboard_detail_page.dart
│   └── ...
│
├── software_page.dart                 # Software catalog
├── scientists_timeline_page.dart      # Scientists database
├── latest_inventions_page.dart        # Recent innovations
├── programming_languages_page.dart    # Programming hub
├── learn_programming_menu_page.dart   # Learning path selector
│
├── interactive learning/              # Interactive C/Python learning
│   ├── interactive_learning_menu_page.dart
│   └── C/
│       ├── basics/                    # Variable, types, I/O
│       ├── operators/                 # Arithmetic, logical, bitwise
│       ├── conditional/               # If/else, switch
│       ├── loops/                     # For, while, do-while
│       ├── functions/                 # Function definitions
│       ├── pointers/                  # Pointer concepts
│       ├── arrays/                    # 1D, 2D, 3D arrays
│       ├── strings/                   # String operations
│       ├── structures/                # Structs, enums, unions
│       ├── file io/                   # File operations
│       ├── memory management/         # malloc, free, calloc
│       ├── recursion/                 # Recursive functions
│       └── problem_solving_part1/     # Practice problems
│
├── code_playground_screen.dart        # Code execution with AI
├── playground/                        # Playground module
│   ├── playground_page.dart
│   ├── playground_controller.dart
│   ├── playground_model.dart
│   └── playground_service.dart
│
├── challenge/                         # Challenge system
│   ├── challenge_page.dart
│   ├── challenge_controller.dart
│   ├── challenge_data.dart
│   └── challenge_model.dart
│
├── games/                             # Educational games
│   ├── games_menu_page.dart
│   └── hangman/
│       ├── hangman_page.dart
│       ├── hangman_controller.dart
│       ├── hangman_model.dart
│       └── hangman_utils.dart
│
├── education/                         # Education models & quiz
│   ├── core/
│   │   ├── app_images.dart
│   │   ├── app_routes.dart
│   │   └── app_theme.dart
│   ├── features/
│   │   ├── models/
│   │   │   ├── models_list_page.dart
│   │   │   ├── model_detail_page.dart
│   │   │   ├── models_data.dart
│   │   │   └── detail/
│   │   │       └── blooms_detail_page.dart
│   │   └── quiz/
│   │       ├── quiz_page.dart
│   │       └── quiz_data.dart
│   └── common/
│       └── widgets/
│           └── app_scaffold.dart
│
├── models/                            # Data models
│   ├── education_model.dart
│   ├── education_models_data.dart
│   ├── hardware_model.dart
│   ├── hardware_component_model.dart
│   └── data_models.dart
│
├── widgets/                           # Reusable UI components
│   ├── menu.dart
│   ├── custom_card.dart
│   ├── circular_logo_menu.dart
│   ├── hardware_basic_info_section.dart
│   ├── hardware_components_section.dart
│   ├── hardware_working_section.dart
│   ├── image_viewer.dart
│   ├── education_model_card.dart
│   ├── progress_bar.dart
│   └── responsive_layout.dart
│
├── utils/                             # Utilities & constants
│   ├── constants.dart
│   ├── theme_provider.dart
│   ├── navigation_service.dart
│   └── data_models.dart
│
├── contact_us_page.dart               # Contact information
├── code_playground_screen.dart        # AI-powered code execution
├── education_model_page.dart
├── education_models_list_page.dart
├── learn_c_page.dart
├── learn_python_page.dart
└── ...

assets/
├── images/
│   ├── hardware/                      # Hardware component images
│   ├── scientists/                    # Scientist portraits
│   ├── inventions/                    # Innovation images
│   ├── software/                      # Software icons
│   └── placeholder.png
├── fonts/                             # Custom fonts
│   ├── Roboto-Regular.ttf
│   ├── Roboto-Bold.ttf
│   └── SourceCodePro-Regular.ttf
├── icons/                             # App icons
└── splash.mp4                         # Splash animation
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.0 or higher
- Dart 3.0 or higher
- Android Studio / Xcode (for building native apps)
- An active GitHub account for repository access

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Tahsan0619/babuntoo-academy.git
   cd babuntoo_academy
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API Keys** (if using code playground)
   - Replace `YOUR_GROQ_API_KEY_HERE` in `lib/code_playground_screen.dart`
   - API keys are stored securely using `flutter_secure_storage`

4. **Run the app**
   ```bash
   flutter run
   ```

### Building for Different Platforms

**Android:**
```bash
flutter build apk
# or for app bundle
flutter build appbundle
```

**iOS:**
```bash
flutter build ios
```

**Web:**
```bash
flutter build web
```

## 📱 App Routes

| Route | Page | Description |
|-------|------|-------------|
| `/splash` | SplashScreen | Initial loading screen |
| `/login` | LoginPage | User authentication |
| `/signup` | SignupPage | User registration |
| `/home` | HomePage | Main menu |
| `/hardware` | HardwarePage | Hardware learning hub |
| `/software` | SoftwarePage | Software catalog |
| `/scientistsTimeline` | ScientistsTimelinePage | Scientists database |
| `/latestInventions` | LatestInventionsPage | Recent innovations |
| `/programmingLanguages` | ProgrammingLanguagesPage | Programming hub |
| `/learnProgrammingMenu` | LearnProgrammingMenuPage | Learning paths |
| `/interactiveLearningMenu` | InteractiveLearningMenuPage | Interactive tutorials |
| `/playground` | CodePlaygroundScreen | Code execution |
| `/challenge` | ChallengePage | Programming challenges |
| `/educationModels` | ModelsListPage | Education frameworks |
| `/models/blooms` | BloomsDetailPage | Bloom's Taxonomy details |
| `/contactUs` | ContactUsPage | Contact information |

## 🎓 Learning Content

### Hardware Components Covered
- **CPU**: Registers, Cache, Control Unit, ALU, Bus Interface
- **GPU**: Architecture, VRAM, Cores, Applications
- **Memory**: RAM types, ROM, Storage (SSD/HDD)
- **Peripherals**: Mouse, Keyboard, Monitor, Printer, Scanner
- **Power & Cooling**: PSU, Fans, Heatsinks

### Programming Concepts (C)
- Variables and Data Types
- Operators (Arithmetic, Logical, Bitwise, Relational)
- Control Flow (if/else, switch, ternary)
- Loops (for, while, do-while)
- Functions and Recursion
- Pointers and Pointer Arithmetic
- Arrays (1D, 2D, 3D)
- Strings and String Operations
- Structures, Enums, and Unions
- File I/O Operations
- Memory Management (malloc, calloc, realloc, free)

### Educational Models
- **Bloom's Taxonomy**: Learning objectives and cognitive levels

## 🔐 Security

- API keys stored securely using `flutter_secure_storage`
- No hardcoded credentials in source code
- HTTPS for all API communications
- Secure token management for user sessions

## 🎨 UI/UX Features

- **Responsive Design**: Works on phones, tablets, and web
- **Dark/Light Theme**: Toggle between themes
- **Smooth Animations**: Polished transitions and effects
- **Accessible Navigation**: Intuitive menu system
- **Rich Media**: Images, videos, and diagrams
- **Interactive Elements**: Buttons, cards, and custom widgets

## 📦 Dependencies Overview

| Package | Purpose |
|---------|---------|
| `flutter_secure_storage` | Secure credential storage |
| `http` | HTTP requests for APIs |
| `provider` | State management |
| `webview_flutter` | Web content display |
| `video_player` | Video playback |
| `url_launcher` | External link handling |
| `shared_preferences` | Local data persistence |
| `package_info_plus` | App metadata |
| `font_awesome_flutter` | Icons library |
| `animated_text_kit` | Text animations |
| `flutter_screenutil` | Responsive sizing |
| `circular_menu` | Circular menu widget |

## 🤝 Contributing

To contribute to Babuntoo Academy:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 🗺️ Roadmap

- [ ] Advanced Python tutorials
- [ ] More programming languages (Java, JavaScript)
- [ ] Interactive quizzes with scoring
- [ ] User progress tracking
- [ ] Certificate generation
- [ ] Multiplayer challenges
- [ ] Mobile app optimization
- [ ] Offline mode support

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## ✉️ Contact & Support

For questions, suggestions, or bug reports:
- **GitHub Issues**: [Report issues here](https://github.com/Tahsan0619/babuntoo-academy/issues)
- **Email**: tahsan@example.com
- **Repository**: https://github.com/Tahsan0619/babuntoo-academy

## 📊 Project Statistics

- **Total Files**: 450+
- **Lines of Code**: 70,000+
- **Supported Platforms**: Android, iOS, Web
- **Programming Language**: Dart/Flutter
- **Latest Update**: December 2025

## 🙏 Acknowledgments

- Flutter & Dart team for the amazing framework
- All contributors and maintainers
- Educational institutions and learning resources that inspired this project
- The open-source community

---

**Made with ❤️ for educators and learners everywhere**

**Last Updated**: December 8, 2025
