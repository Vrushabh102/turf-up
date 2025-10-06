import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:turf_together/common/snackbar/snackbar.dart';
import 'package:turf_together/feature/auth/repo/auth_repo.dart';
import 'package:turf_together/feature/auth/model/user_model.dart';

final authControllerProvider = Provider<AuthController>((ref) {
  return AuthController(
    authRepository: ref.read(authRepositoryProvider),
    ref: ref,
  );
});

final userNotifierProvider = StateNotifierProvider<UserNotifier, UserModel>((
  ref,
) {
  return UserNotifier();
});

class AuthController {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({required AuthRepository authRepository, required Ref ref})
    : _authRepository = authRepository,
      _ref = ref;

  Future<UserCredential?> signInWithEmail(String email, String password, BuildContext context) async {
    final userCredential = await _authRepository.signInWithEmail(
      email,
      password,
      context,
    );

    return userCredential.fold(
      (failure) {
        // show snackbar and proper error
        context.showErrorMessage(failure.toString());
        return;
      },
      (userCredential) {
        
        return userCredential;
      },
    );
  }

  Future<UserCredential?> signUpWithEmail(String email, String password, BuildContext context) async {
    final userCredential = await _authRepository.createUserWithEmail(
      email,
      password,
    );

    return userCredential.fold(
      (failure) {
        // show snackbar and proper error
        context.showErrorMessage(failure.toString());
        return null;
      },
      (userCredential) {
        // returning userCredential to save the partial user data in provider
        log(userCredential.user?.emailVerified.toString() ?? 'No email');
        context.showSuccessMessage('Signed up as $email');
        return userCredential;
      },
    );
  }
}
