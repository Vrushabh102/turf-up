# Turf Together

A Flutter app for hosting and joining local sports activities.

**Flutter version:** 3.32.1  
**Dart version:** 3.8.1

---

## 📂 Folder Structure  

### 🏗️ Architecture Pattern
- **Feature-first** folder structure
- **Repository pattern** for data management
- **Riverpod** for state management
- **Clean separation** of concerns

```plaintext
lib/
├── core/
│   ├── constants/
│   ├── router/
│   └── utils/
├── features/
│   ├── auth/
│   │   ├── controllers/
│   │   │   └── auth_controller.dart
│   │   ├── models/
│   │   │   └── user_model.dart
│   │   ├── repositories/
│   │   │   └── auth_repository.dart
│   │   ├── screens/
│   │   │   └── login_screen.dart
│   │   └── widgets/
│   │       └── auth_button.dart
│   ├── home/
│   │   ├── controllers/
│   │   │   └── sports_controller.dart
│   │   ├── models/
│   │   │   └── sports_activity.dart
│   │   ├── repositories/
│   │   │   └── sports_repository.dart
│   │   ├── screens/
│   │   │   └── sports_home_screen.dart
│   │   └── widgets/
│   │       └── sports_activity_card.dart
│   └── chat/
│       ├── controllers/
│       ├── models/
│       ├── repositories/
│       ├── screens/
│       └── widgets/
├── services/
└── main.dart
```

