import 'package:dartz/dartz.dart';

import '../../core/use_case/use_case.dart';
import '../repository/auth_repository.dart';

class LogOutUseCase implements UseCase<Either, dynamic> {
  final AuthRepository repository;

  LogOutUseCase({required this.repository});

  @override
  Future<Either> call({param}) async {
    return await repository.logout();
  }
}
