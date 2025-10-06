import 'package:flutter_riverpod/legacy.dart';

class UserModel {
  String id;
  String email;
  List<String> selectedSports = [];
  Map<String, SportDetails> sportDetails = {};
  String username;
  String? profileImage;
  bool? isOAuthSignUp;

  UserModel({
    required this.id,
    required this.email,
    required this.selectedSports,
    required this.username,
    this.profileImage,
    required this.isOAuthSignUp,
  });

  UserModel copyWith({
    String? id,
    String? email,
    String? password,
    List<String>? selectedSports,
    String? username,
    String? profileImage,
    bool? isOAuthSignUp,
    String? oauthProvider,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      selectedSports: selectedSports ?? this.selectedSports,
      username: username ?? this.username,
      profileImage: profileImage ?? this.profileImage,
      isOAuthSignUp: isOAuthSignUp ?? this.isOAuthSignUp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'selectedSports': selectedSports,
      'username': username,
      'profileImage': profileImage,
      'isOAuthSignUp': isOAuthSignUp,
    };
  }

}

class SportDetails {
  int age;
  String skillLevel;

  SportDetails({required this.age, required this.skillLevel});
}

class UserNotifier extends StateNotifier<UserModel> {
  UserNotifier()
    : super(
        UserModel(
          id: '',
          email: '',
          profileImage: null,
          selectedSports: [],
          username: 'username',
          isOAuthSignUp: false,
        ),
      );

  void setUserDetails(UserModel user) {
    state = user;
  }

  void updateProfileImage(String imagePath) {
    state = state.copyWith(profileImage: imagePath);
  }

  void updateSelectedSports(List<String> sports) {
    state = state.copyWith(selectedSports: sports);
  }

  void updateUsername(String username) {
    state = state.copyWith(username: username);
  }
}
