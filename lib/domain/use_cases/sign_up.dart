import 'package:dartz/dartz.dart';

import '../../core/use_case/use_case.dart';
import '../../data/models/sign_up_req_params.dart';
import '../../init_dependency.dart';
import '../repository/auth_repository.dart';

class SignUpUseCase implements UseCase<Either, SignUpReqParams> {
  final AuthRepository repository;

  SignUpUseCase({required this.repository});

  @override
  Future<Either> call({SignUpReqParams? param}) async {
    return serviceLocator<AuthRepository>().signUp(param!);
  }
}
