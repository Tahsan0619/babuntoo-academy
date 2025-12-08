# Babuntoo Academy

Babuntoo Academy is an educational mobile application built with Flutter, designed to make learning programming and technology concepts engaging and interactive. It offers a comprehensive curriculum, particularly focused on the C programming language, alongside modules for Python, computer fundamentals, and insights into the world of technology.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Learning Modules](#learning-modules)
    - [C Programming](#c-programming)
    - [Python Programming](#python-programming)
    - [Problem Solving](#problem-solving)
    - [Computer Fundamentals](#computer-fundamentals)
    - [Tech Insights](#tech-insights)
- [Interactive Elements](#interactive-elements)
- [Technology Stack](#technology-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation & Running](#installation--running)
- [Contribution](#contribution)
- [License](#license)

## Overview

Babuntoo Academy aims to provide a structured and user-friendly platform for students and enthusiasts to learn programming from the ground up. The application breaks down complex topics into digestible lessons, interactive exercises, and problem-solving challenges. With a strong emphasis on visual learning and hands-on practice, it strives to build a solid foundation in software development and computer science.

## Features

*   Comprehensive C Language Course: From syntax basics to advanced problem-solving.
*   Introduction to Python: A dedicated module for learning Python fundamentals.
*   Interactive Learning Modules: Engaging pages for understanding operators, control flow, data types, and more.
*   Problem-Solving Arena: A collection of programming problems to test and enhance coding skills.
*   Coding Playground: A space to experiment with code snippets.
*   Challenge Mode: Quizzes or coding challenges to assess understanding.
*   Computer Fundamentals: Learn about computer hardware (extensive image library included) and software.
*   Tech History & Inventions: Explore timelines of scientists (extensive image library included) and recent technological advancements (with illustrative images).
*   User-Friendly Interface: Intuitive navigation, custom-designed widgets (like `circular_menu`), and animated text effects.
*   Responsive Design: Utilizes `flutter_screenutil` for adapting to various screen sizes.
*   Video Splash Screen: Engaging video introduction (`splash.mp4`).
*   Progress Tracking (Assumed): Users can likely track their learning progress.
*   Contact/Support: A dedicated page for users to get in touch.

## Learning Modules

The application is broadly divided into the following learning sections:

### C Programming (`lib/interactive_learning/`)

*   Basics:
    *   Basic of C('syntax_of_c_page.dart')
    *   Variables (`variable_page.dart`)
    *   Integer and Float Data Types (`int_and_float_page.dart`)
    *   Character Data Types and Format Specifiers (`char_and_format_specifiers_page.dart`)
    *   Input/Output: `printf` and `scanf` (`printf_and_scanf_page.dart`)
*   Operators (`lib/interactive_learning/operators/`):
    *   Arithmetic Operators (`arithmetic_operators_page.dart`)
    *   Relational Operators (`relational_operators_page.dart`)
    *   Logical Operators (`logical_operators_page.dart`)
    *   Bitwise Operators (`bitwise_operators_page.dart`)
*   Conditional Statements (`lib/interactive_learning/conditional/`):
    *   If-Else (`if_else_page.dart`)
    *   Switch Case (`switch_page.dart`)
    *   Ternary Operator (`ternary_operator.dart`)
*   Loops (`lib/interactive_learning/loops/`):
    *   For Loop (`for_loop_page.dart`)
    *   While Loop (`while_loop_page.dart`)
    *   Do-While Loop (`do_while_loop_page.dart`)
*   Menus for C Learning:
    *   Main C Learning Menu (`learn_c_page.dart`, `interactive_learning_menu_page.dart`)
    *   Operators Menu (`operators_menu_page.dart`)
    *   Conditional Statements Menu (`conditional_operator_menu_page.dart`)
    *   Loops Menu (`loop_menu_page.dart`)

### Python Programming

*   Dedicated learning module (`learn_python_page.dart`). 

### Problem Solving (`lib/interactive_learning/problem_solving_part1/`)

A series of interactive problems designed to apply learned concepts:
*   Problem 1 to Problem 7 (`problem1_page.dart` ... `problem7_page.dart`)
*   Menu for Problem Solving (`problem1_menu_page.dart`)

### Computer Fundamentals

*   Hardware Concepts (`hardware_page.dart`)
*   Software Concepts (`software_page.dart`)

### Tech Insights

*   Latest Inventions (`latest_inventions_page.dart`)
*   Scientists Timeline (`scientists_timeline_page.dart`)
*   Overview of Programming Languages (`programming_languages_page.dart`)

## Interactive Elements

*   Challenges (`lib/challenge/`):
    *   `challenge_page.dart`: Interface for challenges.
    *   `challenge_controller.dart`: Manages challenge logic.
    *   `challenge_data.dart`, `challenge_model.dart`: Data and models for challenges.
*   Playground (`lib/playground/`):
    *   `playground_page.dart`: UI for the coding playground.
    *   `playground_controller.dart`: Handles playground logic.
    *   `playground_service.dart`, `playground_model.dart`: Services and data models for the playground.
    *   Potentially uses `webview_flutter` for code execution or display.

## Technology Stack

*   Framework: Flutter (`sdk: ">=3.0.0 <4.0.0"`)
*   Language: Dart
*   Key Flutter Packages & Libraries:
    *   `material.dart` (Implicitly via `flutter: sdk: flutter` for Material Design UI components)
    *   `cupertino_icons: ^1.0.2` (For iOS-style icons)
    *   `url_launcher: ^6.2.1` (For launching URLs)
    *   `package_info_plus: ^4.2.0` (For querying app package information)
    *   `provider: ^6.1.0` (For state management)
    *   `webview_flutter: ^4.4.2` (For embedding web content)
    *   `circular_menu: ^2.0.1` (For creating circular menu widgets)
    *   `video_player: ^2.8.2` (For playing videos, likely used in `splash.mp4`)
    *   `font_awesome_flutter: ^10.7.0` (For a wide range of additional icons)
    *   `animated_text_kit: ^4.2.2` (For creating animated text effects)
    *   `flutter_screenutil: ^5.9.0` (For adapting UI to different screen sizes and densities)
*   Development Tools:
    *   Android Studio
*   Dev Dependencies:
    *   `flutter_test: sdk: flutter` (For widget and unit testing)
    *   `flutter_lints: ^2.0.0` (For static analysis and code style enforcement)
    *   `flutter_launcher_icons: ^0.13.1` (For generating app launcher icons)
    *   `mockito: ^5.4.2` (For creating mock objects in tests)
*   Assets:
    *   Extensive image assets for hardware components, scientists, and inventions (see `pubspec.yaml` for full list).
    *   Video asset for splash screen (`assets/splash.mp4`).
    *   Custom fonts: `Roboto` and `SourceCodePro` (defined in `assets/fonts/`).

## Project Structure

project_root/
│
├── lib/
│   ├── challenge/
│   │   ├── challenge_controller.dart
│   │   ├── challenge_data.dart
│   │   ├── challenge_model.dart
│   │   └── challenge_page.dart
│   │
│   ├── interactive_learning/
│   │   ├── conditional/
│   │   │   ├── if_else_page.dart
│   │   │   ├── switch_page.dart
│   │   │   └── ternary_operator.dart
│   │   │
│   │   ├── loops/
│   │   │   ├── do_while_loop_page.dart
│   │   │   ├── for_loop_page.dart
│   │   │   └── while_loop_page.dart
│   │   │
│   │   ├── menu/
│   │   │   ├── conditional_operator_menu_page.dart
│   │   │   ├── loop_menu_page.dart
│   │   │   ├── operators_menu_page.dart
│   │   │   └── problem1_menu_page.dart
│   │   │
│   │   ├── operators/
│   │   │   ├── arithmetic_operators_page.dart
│   │   │   ├── bitwise_operators_page.dart
│   │   │   ├── logical_operators_page.dart
│   │   │   └── relational_operators_page.dart
│   │   │
│   │   ├── problem_solving_part1/
│   │   │   ├── problem1_page.dart
│   │   │   ├── problem2_page.dart
│   │   │   ├── problem3_page.dart
│   │   │   ├── problem4_page.dart
│   │   │   ├── problem5_page.dart
│   │   │   ├── problem6_page.dart
│   │   │   └── problem7_page.dart
│   │   │
│   │   ├── char_and_format_specifiers_page.dart
│   │   ├── int_and_float_page.dart
│   │   ├── interactive_learning_menu_page.dart
│   │   ├── printf_and_scanf_page.dart
│   │   ├── syntax_of_c_page.dart
│   │   └── variable_page.dart
│   │
│   ├── playground/
│   │   ├── playground_controller.dart
│   │   ├── playground_model.dart
│   │   ├── playground_page.dart
│   │   └── playground_service.dart
│   │
│   ├── utils/
│   │   ├── constants.dart
│   │   ├── data_models.dart
│   │   ├── navigation_service.dart
│   │   └── theme_service.dart 
│   │
│   ├── widgets/
│   │   ├── circular_logo_menu.dart
│   │   ├── custom_card.dart
│   │   ├── image_viewer.dart
│   │   ├── menu.dart
│   │   ├── progress_bar.dart
│   │   └── responsive_layout.dart
│   │
│   ├── contact_us_page.dart
│   ├── hardware_page.dart
│   ├── home_page.dart
│   ├── latest_inventions_page.dart
│   ├── learn_c_page.dart
│   ├── learn_programming_menu_page.dart
│   ├── learn_python_page.dart
│   ├── main.dart
│   ├── programming_languages_page.dart
│   ├── scientists_timeline_page.dart
│   ├── software_page.dart
│   └── splash_screen.dart
│
├── README.md
├── pubspec.yaml

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

*   Flutter SDK: Version `3.0.0` or higher, but less than `4.0.0`. You can find installation instructions on the [official Flutter website](https://flutter.dev/docs/get-started/install).
*   IDE:
    *   Android Studio (with the Flutter and Dart plugins installed).
*   An Android Emulator or a physical Android device.

### Installation & Running

1.  Obtain the Source Code via permission:
    Run it in local machine via android studio:
This will build and install the application on your selected virtual device/emulator.

## Developer

This application was solely developed by Md Tahsan Islam.

## Contribution

Currently, Md Tahsan Islam is the sole developer of BabunToo Academy. If you have suggestions, feedback, or encounter any issues, please feel free to reach out or open an issue on the project's repository (if applicable).

## License

Copyright © 2025 Md Tahsan Islam
All Rights Reserved.
This project is proprietary and closed source. Permission is not granted to copy, modify, distribute, or sublicense the software without the express written permission of the copyright holder, Md Tahsan Islam.