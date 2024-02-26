import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/presentation/bloc/auth/login/login_bloc.dart';
import 'package:instagram_clone/features/presentation/bloc/auth/sign_up/pick_image_cubit.dart';
import 'package:instagram_clone/features/presentation/bloc/auth/sign_up/sign_up_bloc.dart';
import 'package:instagram_clone/features/presentation/bloc/comment/comment_bloc.dart';
import 'package:instagram_clone/features/presentation/bloc/get_single_user/get_single_user_bloc.dart';
import 'package:instagram_clone/features/presentation/bloc/get_single_user_for_profile/get_single_use_for_profile_bloc.dart';
import 'package:instagram_clone/features/presentation/bloc/home/home_bloc.dart';
import 'package:instagram_clone/features/presentation/bloc/posts/posts_bloc.dart';
import 'package:instagram_clone/features/presentation/bloc/profile/pick_image_for_edit_profile_cubit.dart';
import 'package:instagram_clone/features/presentation/bloc/profile/profile_bloc.dart';
import 'package:instagram_clone/features/presentation/bloc/reply/reply_bloc.dart';
import 'package:instagram_clone/features/presentation/bloc/user_actions/follow_someone/user_actions_bloc.dart';
import 'package:instagram_clone/features/presentation/screens/auth/loginScreen.dart';
import 'package:instagram_clone/features/presentation/screens/main_screen.dart';
import 'package:uuid/uuid.dart';
import 'core/constants.dart';
import 'core/dependency_injection.dart';
import 'core/no_internet.dart';
import 'core/onGenerateRoutes.dart';
import 'features/presentation/bloc/get_single_post/get_single_post_cubit.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Uuid randomId = const Uuid();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDi();
  onNoInternet();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<LoginBloc>()..add(IsLoginEvent()),
        ),
        BlocProvider(
          create: (context) => sl<SignUpBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<HomeBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<ProfileBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<PickImageCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<PickImageForEditProfileCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<PostsBloc>()..add(GetPostsEvent()),
        ),
        BlocProvider(
          create: (context) => sl<CommentBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<ReplyBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<GetSinglePostCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<UserActionsBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<GetSingleUserBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<GetSingleUseForProfileBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: customTextTheme(),
        initialRoute: RouteNames.mainScreen,
        routes: {
          "/": (context) {
            return BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginLoaded) {
                  return MainScreen(
                    uid: state.uid,
                    currentUser: state.user,
                  );
                } else {
                  return const LoginScreen();
                }
              },
            );
          }
        },
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }

  ThemeData customTextTheme() {
    return ThemeData(
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontSize: 0.02.mediaH(context),
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            fontSize: 0.017.mediaH(context),
            fontWeight: FontWeight.bold,
          ),
          displaySmall: TextStyle(
            fontSize: 0.017.mediaH(context),
          ),
        ).apply(
          bodyColor: Constants.primaryColor,
          displayColor: Constants.primaryColor,
        ),
        iconTheme: const IconThemeData(color: Colors.white));
  }
}
