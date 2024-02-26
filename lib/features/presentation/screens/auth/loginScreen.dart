import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/features/presentation/bloc/auth/login/login_bloc.dart';
import 'package:instagram_clone/features/presentation/screens/auth/signUpScreen.dart';
import '../../../../core/constants.dart';
import '../../widgets/custom_round_button.dart';
import '../../widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backGroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: SvgPicture.asset(
                        "assets/image_assets/instagram_logo.svg")),
                sizeVer(15),
                CustomTextFormField(
                  controller: emailController,
                  hintText: "Email",
                  inputType: TextInputType.emailAddress,
                ),
                sizeVer(15),
                CustomTextFormField(
                  controller: passwordController,
                  hintText: "Password",
                  isPasswordField: true,
                ),
                sizeVer(15),
                BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginLoaded) {
                      Navigator.pushReplacementNamed(
                          context, RouteNames.mainScreen,
                          arguments: [state.uid, state.user]);
                    }
                  },
                  child: CustomRoundButton(
                    title: "Login",
                    onTap: () {
                      context.read<LoginBloc>().add(LoginUser(
                          email: emailController.text,
                          password: passwordController.text));
                    },
                  ),
                ),
                const Divider(
                  color: Constants.primaryColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Don't have an Account?",
                      style: TextStyle(color: Constants.primaryColor),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, RouteNames.signUpScreen);
                        },
                        child: const Text(
                          "Sign Up!",
                          style: TextStyle(color: Constants.blueColor),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
