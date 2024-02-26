import 'package:flutter/material.dart';
import 'package:instagram_clone/core/constants.dart';
import 'package:instagram_clone/features/domain/entities/PostEntity.dart';
import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/presentation/screens/activity/activity_screen.dart';
import 'package:instagram_clone/features/presentation/screens/add_post/add_post_screen.dart';
import 'package:instagram_clone/features/presentation/screens/auth/loginScreen.dart';
import 'package:instagram_clone/features/presentation/screens/auth/signUpScreen.dart';
import 'package:instagram_clone/features/presentation/screens/home/comment/comment_screen.dart';
import 'package:instagram_clone/features/presentation/screens/home/edit_post/edit_post_screen.dart';
import 'package:instagram_clone/features/presentation/screens/home/home_screen.dart';
import 'package:instagram_clone/features/presentation/screens/main_screen.dart';
import 'package:instagram_clone/features/presentation/screens/profile/edit_profile_screen.dart';
import 'package:instagram_clone/features/presentation/screens/profile/followers_screen.dart';
import 'package:instagram_clone/features/presentation/screens/profile/followings_screen.dart';
import 'package:instagram_clone/features/presentation/screens/profile/other_users_profile.dart';
import 'package:instagram_clone/features/presentation/screens/profile/profile_screen.dart';
import 'package:instagram_clone/features/presentation/screens/search/search_screen.dart';
import 'package:instagram_clone/features/presentation/screens/search/single_detailed_post_screen.dart';
import 'package:instagram_clone/features/presentation/widgets/custom_appbar.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  var arguments = settings.arguments;
  switch (settings.name) {
    case RouteNames.profileScreen:
      return MaterialPageRoute(builder: (context) => ProfileScreen(currentUser: arguments as UserEntity));
    case RouteNames.detailedPostScreen:
    // Ensure that arguments is a Map<String, dynamic>
      final Map<String, dynamic> args = arguments as Map<String, dynamic>;
      // Extract UserEntity and PostEntity separately
      final UserEntity currentUser = args['currentUser'] as UserEntity;
      final PostEntity postEntity = args['postEntity'] as PostEntity;
      return MaterialPageRoute(
          builder: (context) => SingleDetailedPostScreen(
            currentUser: currentUser,
            post: postEntity,
          ));
    case RouteNames.otherUsersProfileScreen:
    // Ensure that arguments is a Map<String, dynamic>
      final Map<String, dynamic> args = arguments as Map<String, dynamic>;

      // Extract UserEntity and PostEntity separately
      final UserEntity currentUser = args['currentUser'] as UserEntity;
      final UserEntity targetUser = args['targetUser'] as UserEntity;
      return MaterialPageRoute(
          builder: (context) => OthersProfileScreen(
            currentUser: currentUser,
            targetUser: targetUser,
          ));
    case RouteNames.followingsScreen:
    // Ensure that arguments is a Map<String, dynamic>
      final Map<String, dynamic> args = arguments as Map<String, dynamic>;

      // Extract UserEntity and PostEntity separately
      final UserEntity currentUser = args['currentUser'] as UserEntity;
      final UserEntity targetUser = args['targetUser'] as UserEntity;
      return MaterialPageRoute(
          builder: (context) => FollowingsScreen(
            currentUser: currentUser,
            targetUser: targetUser,
          ));
    case RouteNames.followersScreen:
    // Ensure that arguments is a Map<String, dynamic>
      final Map<String, dynamic> args = arguments as Map<String, dynamic>;

      // Extract UserEntity and PostEntity separately
      final UserEntity currentUser = args['currentUser'] as UserEntity;
      final UserEntity targetUser = args['targetUser'] as UserEntity;
      return MaterialPageRoute(
          builder: (context) => FollowersScreen(
            currentUser: currentUser,
            targetUser: targetUser,
          ));
    case RouteNames.activityScreen:
      return MaterialPageRoute(builder: (context) => const ActivityScreen());
    case RouteNames.addPostScreen:
      return MaterialPageRoute(
          builder: (context) => AddPostScreen(
                currentUser: arguments as UserEntity,
              ));
    case RouteNames.commentScreen:
      // Ensure that arguments is a Map<String, dynamic>
      final Map<String, dynamic> args = arguments as Map<String, dynamic>;

      // Extract UserEntity and PostEntity separately
      final UserEntity currentUser = args['currentUser'] as UserEntity;
      final PostEntity postEntity = args['postEntity'] as PostEntity;
      return MaterialPageRoute(
          builder: (context) => CommentScreen(
                currentUser: currentUser,
                postEntity: postEntity,
              ));
    case RouteNames.editPostScreen:
      return MaterialPageRoute(
          builder: (context) => EditPostScreen(
                post: arguments as PostEntity,
              ));
    case RouteNames.editProfileScreen:
      return MaterialPageRoute(
          builder: (context) => EditProfileScreen(
                currentUser: arguments as UserEntity,
              ));
    case RouteNames.homeScreen:
      return MaterialPageRoute(
          builder: (context) => HomeScreen(
                uid: arguments as String,
                currentUser: arguments as UserEntity,
              ));
    case RouteNames.loginScreen:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case RouteNames.signUpScreen:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());
    case RouteNames.searchScreen:
      return MaterialPageRoute(builder: (context) => SearchScreen(currentUser: arguments as UserEntity,));
    case RouteNames.mainScreen:
      return MaterialPageRoute(
          builder: (context) => MainScreen(
              uid: arguments as String, currentUser: arguments as UserEntity));
    default:
      return MaterialPageRoute(builder: (context) => const NoScreenFound());
  }
}

class NoScreenFound extends StatelessWidget {
  const NoScreenFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: "No Screen Found",
      ),
      body: Center(
        child: Text("No Page Found"),
      ),
    );
  }
}
