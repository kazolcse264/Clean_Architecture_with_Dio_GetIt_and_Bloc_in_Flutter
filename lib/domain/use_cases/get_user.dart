import 'package:dartz/dartz.dart';

import '../../core/use_case/use_case.dart';
import '../repository/auth_repository.dart';

class GetUserUseCase implements UseCase<Either, dynamic> {
  final AuthRepository repository;

  GetUserUseCase({required this.repository});

  @override
  Future<Either> call({dynamic param}) async {
    return await repository.getUser();
  }
}
