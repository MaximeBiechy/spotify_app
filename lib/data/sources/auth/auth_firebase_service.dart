import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_app/core/configs/constants/app_urls.dart';
import 'package:spotify_app/data/models/auth/create_user_request.dart';
import 'package:spotify_app/data/models/auth/signin_user_request.dart';
import 'package:spotify_app/data/models/auth/user.dart';
import 'package:spotify_app/domain/entities/auth/user.dart';

abstract class AuthFirebaseService {
  Future<Either> signUp(CreateUserRequest createUserReq);

  Future<Either> signIn(SignInUserRequest signInUserReq);

  Future<Either> getUser();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signUp(CreateUserRequest createUserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserReq.email, password: createUserReq.password);

      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid).set({
        'name': createUserReq.fullName,
        'email': data.user?.email,
      });

      return const Right('User created successfully');
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists for that email.';
      }

      return Left(message);
    }
  }

  @override
  Future<Either> signIn(SignInUserRequest signInUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signInUserReq.email, password: signInUserReq.password);

      return const Right('User signed in successfully');
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'invalid-email') {
        message = 'No user found for that email.';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user.';
      }

      return Left(message);
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = await firebaseFirestore
          .collection('Users')
          .doc(firebaseAuth.currentUser?.uid)
          .get();

      UserModel userModel = UserModel.fromJson(user.data()!);
      userModel.imageUrl =
          firebaseAuth.currentUser?.photoURL ?? AppUrls.defaultImage;
      UserEntity userEntity = userModel.toEntity();
      return Right(userEntity);
    } catch (e) {
      return const Left('An error occurred');
    }
  }
}
