import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/is_logged_in.dart';
import '../../../init_dependency.dart';
import 'auth_state.dart';

class AuthStateCubit extends Cubit<AuthState> {
  AuthStateCubit() : super(AppInitialState());

  void appStarted() async {
    var isLoggedIn = await serviceLocator<IsLoggedInUseCase>().call();
    if (isLoggedIn) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }
}
