import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_app/data/models/auth/create_user_request.dart';

abstract class AuthFirebaseService {
  Future<Either> signUp(CreateUserRequest createUserRequest);
  Future<void> signIn();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signUp(CreateUserRequest createUserRequest) async {
    try {
     await FirebaseAuth.instance.createUserWithEmailAndPassword(email: createUserRequest.email, password: createUserRequest.password);

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
  Future<void> signIn() async {

  }

}