# Turf up

Flutter version: 3.35.5
Dart versio: 3.9.2

---

## 📂 Folder Structure  

### 🏗️ Architecture Pattern
- **Feature-first** folder structure
- **Repository pattern** for data management
- **Riverpod** for state management
- **Clean separation** of concerns

```plaintext

# Folder strcuture

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
│   └── auth/
│       ├── controllers/
│       ├── models/
│       ├── repositories/
│       ├── screens/
│       └── widgets/
├── services/
└── main.dart
