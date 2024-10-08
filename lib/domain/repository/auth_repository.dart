import 'package:dartz/dartz.dart';

import '../../data/models/sign_in_req_params.dart';
import '../../data/models/sign_up_req_params.dart';

abstract class AuthRepository {
  Future<Either> signUp(SignUpReqParams signUpReq);

  Future<Either> signIn(SignInReqParams signInReq);

  Future<bool> isLoggedIn();

  Future<Either> getUser();

  Future<Either> logout();
}
