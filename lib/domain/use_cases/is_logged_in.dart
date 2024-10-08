import '../../core/use_case/use_case.dart';
import '../repository/auth_repository.dart';

class IsLoggedInUseCase implements UseCase<bool, dynamic> {
  final AuthRepository repository;

  IsLoggedInUseCase({required this.repository});

  @override
  Future<bool> call({dynamic param}) async {
    return await repository.isLoggedIn();
  }
}
