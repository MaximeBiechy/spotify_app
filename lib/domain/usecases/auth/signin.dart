import 'package:dartz/dartz.dart';
import 'package:spotify_app/core/usecase/usecase.dart';
import 'package:spotify_app/data/models/auth/signin_user_request.dart';

import '../../../service_locator.dart';
import '../../repository/auth/auth.dart';

class SignInUseCase implements UseCase<Either, SignInUserRequest> {
  @override
  Future<Either> call({SignInUserRequest ? params}) {
    return sl<AuthRepository>().signIn(params!);
  }



}