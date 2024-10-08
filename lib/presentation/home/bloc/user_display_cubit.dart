import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../init_dependency.dart';
import '../../../domain/use_cases/get_user.dart';
import 'user_display_state.dart';

class UserDisplayCubit extends Cubit<UserDisplayState> {
  UserDisplayCubit() : super(UserLoading());

  void displayUser() async {
    var result = await serviceLocator<GetUserUseCase>().call();
    result.fold((error) {
      emit(LoadUserFailure(errorMessage: error));
    }, (data) {
      emit(UserLoaded(userEntity: data));
    });
  }
}
