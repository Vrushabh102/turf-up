// auth repository provider
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:turf_together/common/failure.dart';
import 'package:turf_together/common/providers/firebase_providers.dart';
import 'package:turf_together/common/type_defs.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: ref.read(firebaseAuthProvider),
    firestore: ref.read(firebaseFirestoreProvider),
  ),
);

// class to handle all the firebase related stuff
class AuthRepository {
  // firebase authentication instance
  // private variable not initialized, initialized in constructor
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepository({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) : _auth = auth,
       _firestore = firestore;

  Stream<User?> get authStateChange {
    return _auth.authStateChanges();
  }

  // FIRESTORE METHODS

  // FIREBASE AUTHENTICATION METHODS

  FutureEither<UserCredential> signInWithEmail(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return right(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return left(Failure('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        return left(Failure('Wrong password provided for that user.'));
      } else if (e.code == 'invalid-email') {
        return left(Failure('The email address is not valid.'));
      } else if (e.code == 'user-disabled') {
        return left(Failure('The user account has been disabled.'));
      } else if (e.code == 'too-many-requests') {
        return left(Failure('Too many requests. Try again later.'));
      } else if (e.code == 'operation-not-allowed') {
        return left(Failure('Email/password accounts are not enabled.'));
      } else if (e.code == 'user-token-expired') {
        return left(Failure('The user\'s credential is no longer valid. The user must sign in again.'));
      } else if (e.code == 'invalid-credential') {
        return left(Failure('Incorrect email or password'));
      } else if (e.code == 'network-request-failed') {
        return left(Failure('Network error. Please try again.'));
      }
      return left(Failure(e.code));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<UserCredential> createUserWithEmail(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return right(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(
          Failure('The email address is already in use by another account.'),
        );
      } else if (e.code == 'invalid-email') {
        return left(Failure('The email address is not valid.'));
      } else if (e.code == 'operation-not-allowed') {
        return left(Failure('Email/password accounts are not enabled.'));
      } else if (e.code == 'weak-password') {
        return left(Failure('The password provided is too weak.'));
      } else if (e.code == 'network-request-failed') {
        return left(Failure('Network error. Please try again.'));
      }
      return left(Failure(e.message.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //Google sign in method

  // FutureEither<UserModel?> signInWithGoogle() async {

  // }

  // Future<void> saveUserDataToFirebase(
  //   String userUid,
  //   UserModel userModel,
  // ) async {
  //   await _users.doc(userUid).set(userModel.toMap());
  // }

  // if the user is old, user will have data on data base, so
  // fun to get userdata to store in userModel provider

  // Stream<UserModel> getUserData(String uid) {
  //   return _users
  //       .doc(uid)
  //       .snapshots()
  //       .map(
  //         (event) => UserModel.fromSnapshot(
  //           event as DocumentSnapshot<Map<String, dynamic>>,
  //         ),
  //       );
  // }

  // firebase function to create new user
  // FutureEither<UserModel> createUserAuth({required UserModel userModel}) async {
  //   try {
  //     // storing returned user from firebase.createuser function
  //     UserCredential userCredential = await _auth
  //         .createUserWithEmailAndPassword(
  //           email: userModel.email,
  //           password: password,
  //         );

  //     // save user data to the user provider
  //     UserModel userModel = UserModel();

  //     // adding users data to the firebase
  //     await _users.doc(userCredential.user!.uid).set(userModel.toMap());

  //     return right(userModel);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'email-already-in-use') {
  //       return left(
  //         Failure('The email address is already in use by another account.'),
  //       );
  //     }
  //     return left(Failure(e.code));
  //   } catch (e) {
  //     return left(Failure(e.toString()));
  //   }
  // }

  // firebase function to login user with email and password
  // FutureEither<UserModel> loginUser(String email, String password) async {
  //   try {
  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);

  //     final userDoc = await _users.doc(userCredential.user!.uid).get()
  //         as DocumentSnapshot<Map<String, dynamic>>;
  //     UserModel model = UserModel.fromSnapshot(userDoc);

  //     // save user data to the user provider
  //     return right(model);
  //   } on FirebaseAuthException catch (e) {
  //     return left(Failure(e.message.toString()));
  //   } catch (e) {
  //     return left(Failure(e.toString()));
  //   }
  // }

  // FutureVoid forgotPass(String email) async {
  //   try {
  //     final forgotPass = await _auth.sendPasswordResetEmail(email: email);

  //     return right(forgotPass);
  //   } on FirebaseAuthException catch (e) {
  //     // show snackbar
  //     return left(Failure(e.toString()));
  //   } catch (e) {
  //     return left(Failure(e.toString()));
  //   }
  // }

  // function to logout user
  // FutureVoid logOutUser() async {
  //   try {
  //     GoogleSignIn googleSignIn = GoogleSignIn(
  //       scopes: [
  //         'email',
  //       ],
  //     );
  //     await googleSignIn.signOut();

  //     final signOut = await _auth.signOut();

  //     return right(signOut);
  //   } on FirebaseAuthException catch (e) {
  //     return left(Failure(e.code.toString()));
  //   } catch (e) {
  //     return left(Failure(e.toString()));
  //   }
  // }
}
