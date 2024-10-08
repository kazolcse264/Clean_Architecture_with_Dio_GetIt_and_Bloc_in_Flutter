import 'package:dartz/dartz.dart';

import '../../core/use_case/use_case.dart';
import '../../data/models/sign_in_req_params.dart';
import '../repository/auth_repository.dart';

class SignInUseCase implements UseCase<Either, SignInReqParams> {
  final AuthRepository repository;

  SignInUseCase({required this.repository});

  @override
  Future<Either> call({SignInReqParams? param}) async {
    return await repository.signIn(param!);
  }
}
