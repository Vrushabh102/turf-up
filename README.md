# 🏈 Turf Up - Flutter Sports Application

A modern Flutter application for sports enthusiasts to discover, book, and manage turf activities with a clean, feature-first architecture.

## 🚀 Quick Start

### Prerequisites

- **Flutter**: Version 3.35.5 or higher
- **Dart**: Version 3.9.2 or higher
- **Git**: For version control

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/Vrushabh102/turf-up.git
   cd turf-up
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

## 🏗️ Project Architecture

### Folder Structure Overview

```
lib/
├── core/                    # Core application components
│   ├── constants/          # App constants, strings, colors
│   ├── router/             # Navigation routing configuration
│   └── utils/              # Utility functions and helpers
├── features/               # Feature-based modules
│   ├── auth/               # Authentication feature
│   │   ├── controllers/    # Auth state management
│   │   ├── models/         # Auth data models
│   │   ├── repositories/   # Auth data layer
│   │   ├── screens/        # Auth UI screens
│   │   └── widgets/        # Reusable auth widgets
│   ├── home/               # Home/Sports feature
│   │   ├── controllers/    # Sports state management
│   │   ├── models/         # Sports data models
│   │   ├── repositories/   # Sports data layer
│   │   ├── screens/        # Sports UI screens
│   │   └── widgets/        # Reusable sports widgets
│   └── [other_features]/   # Additional features
├── services/               # External service integrations
└── main.dart              # Application entry point
```

### Architecture Patterns

- **🏗️ Feature-First Structure**: Organized by features for better scalability
- **📚 Repository Pattern**: Clean data management and abstraction
- **🎯 Riverpod**: Modern state management solution
- **🧹 Clean Architecture**: Separation of concerns with clear boundaries

## 🛠️ Development Setup

### Environment Configuration

1. **Check Flutter installation**
   ```bash
   flutter doctor
   ```

2. **Verify versions**
   ```bash
   flutter --version
   dart --version
   ```

3. **Install required dependencies**
   ```bash
   # Add any additional packages to pubspec.yaml
   flutter pub add riverpod
   flutter pub add go_router
   # ... other dependencies
   ```

### Development Commands

```bash
# Run in development mode
flutter run

# Build for production
flutter build apk
flutter build ios

# Run tests
flutter test

# Generate code coverage
flutter test --coverage

# Analyze code
flutter analyze
```

## 📱 Features

### Current Features
- ✅ User Authentication
- ✅ Sports Activity Management
- ✅ Turf Booking System
- ✅ Responsive UI Design

### Platform-Specific Setup

#### Android
- Update `android/app/src/main/AndroidManifest.xml`
- Configure permissions as needed

#### iOS
- Update `ios/Runner/Info.plist`
- Configure necessary permissions


## 📦 Building for Production

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit changes: `git commit -m 'Add amazing feature'`
4. Push to branch: `git push origin feature/amazing-feature`
5. Open a Pull Request


### Getting Help

- Check existing issues on GitHub
- Review Flutter documentation
- Consult Riverpod documentation

## 📄 License

This project is licensed under the Discord License - see the [LICENSE.md](LICENSE.md) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Riverpod for state management solution
- The open-source community for various packages

---

**Happy Coding!** 🎉 Build amazing sports experiences with Turf Up!
