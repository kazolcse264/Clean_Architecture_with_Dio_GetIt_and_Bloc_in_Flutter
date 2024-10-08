import 'package:clean_architecture_with_dio_getit_and_bloc_in_flutter/presentation/home/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/bloc/auth/auth_state.dart';
import 'common/bloc/auth/auth_state_cubit.dart';
import 'core/configs/theme/app_theme.dart';
import 'presentation/auth/pages/sign_in.dart';
import 'init_dependency.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black));
  await initializeDependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthStateCubit()..appStarted(),
      child: MaterialApp(
          theme: AppTheme.appTheme,
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<AuthStateCubit, AuthState>(
            builder: (context, state) {
              if (state is Authenticated) {
                return const HomePage();
              }
              if (state is UnAuthenticated) {
                /// As my app does not contain registration process that's why I have return sign in page
                //return SignupPage();
                return const SignInPage();
              }
              return Container();
            },
          )),
    );
  }
}
