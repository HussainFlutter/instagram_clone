
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
export 'package:instagram_clone/core/constants.dart';
class Constants {

  static const backGroundColor = Color.fromRGBO(0,0,0,1.0);
  static const blueColor = Color.fromRGBO(0, 149, 246, 1);
  static const primaryColor = Colors.white;
  static const secondaryColor = Colors.grey;
  static const redColor = Colors.red;
  static const greenColor = Colors.green;
  static const darkGreyColor = Color.fromRGBO(97, 97, 97, 1);

}

class RouteNames {
  static const activityScreen = "ActivityScreen";
  static const addPostScreen = "AddPostScreen";
  static const loginScreen = "LoginScreen";
  static const signUpScreen = "SignUpScreen";
  static const homeScreen = "HomeScreen";
  static const commentScreen = "CommentScreen";
  static const editPostScreen = "EditPostScreen";
  static const profileScreen = "ProfileScreen";
  static const  editProfileScreen = "EditProfileScreen";
  static const  mainScreen = "/";
  static const  searchScreen = "SearchScreen";
  static const  detailedPostScreen = "DetailedPostScreen";
  static const  otherUsersProfileScreen = "OtherUsersProfileScreen";
  static const  followingsScreen = "followingsScreen";
  static const  followersScreen = "followersScreenScreen";
}

class FirebaseConsts {
  static const user = "user";
  static const post = "posts";
  static const storagePosts = "posts";
  static const storageUser = "users";
  static const comments = "comments";
  static const replys = "replys";
}

 Widget sizeVer (double height) {
  return SizedBox(height: height,);
}

Widget sizeHor (double width) {
  return SizedBox(width: width,);
}

double mediaHeight (BuildContext context , double height) {
  return MediaQuery.of(context).size.height * height;
}

double mediaWidth (BuildContext context,double width) {
  return MediaQuery.of(context).size.width * width;
}

void toast ({
  required String message,
  Color toastTextColor = Constants.primaryColor,
  Color toastBackGroundColor = Constants.redColor,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: toastBackGroundColor,
      textColor: toastTextColor,
      fontSize: 15.0
  );
}

extension SizeBox on num {
  verSize (BuildContext context) {
    return SizedBox(height: mediaH(context) );
  }
  horSize(BuildContext context) {
    return SizedBox(width: mediaW(context) );
  }
}

extension Media on num {
  mediaH(BuildContext context) {
    return MediaQuery.of(context).size.height * this;
  }
  mediaW (BuildContext context) {
    return MediaQuery.of(context).size.width * this;
  }
}
