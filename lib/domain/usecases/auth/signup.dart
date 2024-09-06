import 'package:dartz/dartz.dart';
import 'package:spotify_app/core/usecase/usecase.dart';
import 'package:spotify_app/data/models/auth/create_user_request.dart';

import '../../../service_locator.dart';
import '../../repository/auth/auth.dart';

class SignUpUseCase implements UseCase<Either, CreateUserRequest> {
  @override
  Future<Either> call({CreateUserRequest ? params}) {
    return sl<AuthRepository>().signUp(params!);
  }



}