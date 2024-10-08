import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/bloc/button/button_state.dart';
import '../../../common/bloc/button/button_state_cubit.dart';
import '../../../common/widgets/button/basic_app_button.dart';
import '../../../data/models/sign_in_req_params.dart';
import '../../../init_dependency.dart';
import '../../../domain/use_cases/sign_in.dart';
import '../../home/pages/home.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setEmailPassword();
    });
    super.initState();
  }

  void setEmailPassword() {
    _emailController.text = 'mor_2314';
    _passwordController.text = '83r5^_';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => ButtonStateCubit(),
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonSuccessState) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
            }
            if (state is ButtonFailureState) {
              var snackBar = SnackBar(content: Text(state.errorMessage));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: SafeArea(
            minimum: const EdgeInsets.only(top: 100, right: 16, left: 16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _signIn(),
                  const SizedBox(
                    height: 50,
                  ),
                  _emailField(),
                  const SizedBox(
                    height: 20,
                  ),
                  _password(),
                  const SizedBox(
                    height: 60,
                  ),
                  _createAccountButton(context),
                  const SizedBox(
                    height: 20,
                  ),
                  _signUpText(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signIn() {
    return const Text(
      'Sign In',
      style: TextStyle(
          color: Color(0xff2A4ECA), fontWeight: FontWeight.bold, fontSize: 32),
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(hintText: 'Email'),
    );
  }

  Widget _password() {
    return TextField(
      controller: _passwordController,
      decoration: const InputDecoration(hintText: 'Password'),
    );
  }

  Widget _createAccountButton(BuildContext context) {
    return Builder(builder: (context) {
      return BasicAppButton(
          title: 'Login',
          onPressed: () {
            context.read<ButtonStateCubit>().execute(
                useCase: serviceLocator<SignInUseCase>(),
                params: SignInReqParams(
                    username: _emailController.text,
                    password: _passwordController.text));
          });
    });
  }

  Widget _signUpText(BuildContext context) {
    return const Text.rich(
      TextSpan(children: [
        TextSpan(
            text: "Don't you have account?",
            style: TextStyle(
                color: Color(0xff3B4054), fontWeight: FontWeight.w500)),
        TextSpan(
          text: ' Sign Up',
          style:
              TextStyle(color: Color(0xff3461FD), fontWeight: FontWeight.w500),

          /// As my app does not contain registration process that's why I have return sign in page
          /*    recognizer: TapGestureRecognizer()
                ..onTap = () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => SignUpPage(), )
                   );
              }*/
        )
      ]),
    );
  }
}
