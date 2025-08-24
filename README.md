# Turf up

Flutter version: 3.32.1
Dart versio: 3.8.1

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
│   └── chat/
│       ├── controllers/
│       ├── models/
│       ├── repositories/
│       ├── screens/
│       └── widgets/
├── services/
└── main.dart
