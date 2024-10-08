import 'package:dartz/dartz.dart';
import 'package:spotify_app/data/models/auth/create_user_request.dart';
import 'package:spotify_app/data/models/auth/signin_user_request.dart';

abstract class AuthRepository {
  Future<Either> signUp(CreateUserRequest createUserReq);
  Future<Either> signIn(SignInUserRequest signInUserReq);
  Future<Either> getUser();
}