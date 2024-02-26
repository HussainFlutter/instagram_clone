import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/presentation/bloc/auth/sign_up/pick_image_cubit.dart';
import 'package:instagram_clone/features/presentation/bloc/auth/sign_up/sign_up_bloc.dart';
import '../../../../core/constants.dart';
import '../../widgets/custom_round_button.dart';
import '../../widgets/custom_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final bioController = TextEditingController();
  final usernameController = TextEditingController();
  late String? image;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backGroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sizeVer(mediaHeight(context, 0.15)),
              Center(
                  child: SvgPicture.asset(
                      "assets/image_assets/instagram_logo.svg")),
              sizeVer(15),
              BlocBuilder<PickImageCubit, PickImageState>(
                  builder: (context, state) {
                if (state is PickImageLoading) {
                  return Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Constants.darkGreyColor,
                        radius: mediaHeight(context, 0.04),
                        child: const CircularProgressIndicator(
                          color: Constants.blueColor,
                        ),
                      ),
                    ],
                  );
                }
                if (state is PickImageLoaded) {
                  image = state.image;
                  return Stack(
                    children: [
                      CircleAvatar(
                        radius: mediaHeight(context, 0.04),
                        backgroundImage: FileImage(File(state.image)),
                      ),
                      Positioned(
                          right: -15,
                          bottom: -15,
                          child: IconButton(
                              onPressed: () {
                                context
                                    .read<PickImageCubit>()
                                    .pickAndUploadImage();
                              },
                              icon: Icon(
                                Icons.camera_alt,
                                color: Constants.blueColor,
                                size: mediaHeight(context, 0.028),
                              ))),
                    ],
                  );
                } else {
                  return Stack(
                    children: [
                      CircleAvatar(
                        radius: mediaHeight(context, 0.04),
                        backgroundImage: const AssetImage(
                            "assets/image_assets/default_profile.jpg"),
                      ),
                      Positioned(
                          right: -15,
                          bottom: -15,
                          child: IconButton(
                              onPressed: () {
                                context
                                    .read<PickImageCubit>()
                                    .pickAndUploadImage();
                              },
                              icon: Icon(
                                Icons.camera_alt,
                                color: Constants.blueColor,
                                size: mediaHeight(context, 0.028),
                              ))),
                    ],
                  );
                }
              }),
              sizeVer(15),
              CustomTextFormField(
                controller: emailController,
                hintText: "Email",
                inputType: TextInputType.emailAddress,
              ),
              sizeVer(15),
              CustomTextFormField(
                controller: usernameController,
                hintText: "Username",
                inputType: TextInputType.emailAddress,
              ),
              sizeVer(15),
              CustomTextFormField(
                controller: passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              sizeVer(15),
              CustomTextFormField(
                controller: bioController,
                hintText: "Bio",
                inputType: TextInputType.emailAddress,
              ),
              sizeVer(15),
              BlocConsumer<SignUpBloc, SignUpState>(
                  listener: (context,state){
                    if (state is SignUpLoaded)
                      {
                        toast(toastBackGroundColor:Constants.greenColor ,message: "User Created Successfully");
                        Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
                      }
                  },
                builder: (context, state) {
                  return CustomRoundButton(
                    loading: state.loading,
                    title: "Sign Up",
                    onTap: () {
                      context.read<SignUpBloc>().add(CreateUserEvent(
                              user: UserEntity(
                            email: emailController.text,
                            password: passwordController.text,
                            bio: bioController.text,
                            username: usernameController.text,
                            profileUrl: image ?? "",
                          )));
                    },
                  );
                },
              ),
              const Divider(
                color: Constants.secondaryColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                      style: Theme.of(context).textTheme.displaySmall),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, RouteNames.loginScreen);
                    },
                    child: Text(
                      "Log in!",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: Constants.blueColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
