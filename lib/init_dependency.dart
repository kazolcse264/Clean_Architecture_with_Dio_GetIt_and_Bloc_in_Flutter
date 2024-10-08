import 'package:get_it/get_it.dart';

import 'core/network/dio_client.dart';
import 'data/data_sources/local_data_source.dart';
import 'data/data_sources/remote_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repository/auth_repository.dart';
import 'domain/use_cases/get_user.dart';
import 'domain/use_cases/is_logged_in.dart';
import 'domain/use_cases/logout.dart';
import 'domain/use_cases/sign_in.dart';
import 'domain/use_cases/sign_up.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeDependencyInjection() async {
  serviceLocator.registerSingleton<DioClient>(DioClient());

  serviceLocator
    ..registerFactory<RemoteDataSource>(() => RemoteDataSourceImpl(
          dioClient: serviceLocator<DioClient>(),
        ))
    ..registerFactory<LocalDataSource>(
      () => LocalDataSourceImpl(),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: serviceLocator(),
        localDataSource: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => SignInUseCase(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => SignUpUseCase(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetUserUseCase(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => IsLoggedInUseCase(
        repository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => LogOutUseCase(
        repository: serviceLocator(),
      ),
    );
}
