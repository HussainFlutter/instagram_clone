import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/presentation/screens/activity/activity_screen.dart';
import 'package:instagram_clone/features/presentation/screens/add_post/add_post_screen.dart';
import 'package:instagram_clone/features/presentation/screens/home/home_screen.dart';
import 'package:instagram_clone/features/presentation/screens/profile/profile_screen.dart';
import 'package:instagram_clone/features/presentation/screens/search/search_screen.dart';

import '../../../core/constants.dart';
class MainScreen extends StatefulWidget {
  final String uid;
  final UserEntity currentUser;
  const MainScreen({super.key,required this.uid,required this.currentUser});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>{

  int _currentIndex = 0;

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped (int index ) {
    pageController.jumpToPage(index);
  }

  void onPageChanged (int index ) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backGroundColor,
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          HomeScreen(uid: widget.uid,currentUser: widget.currentUser,),
          SearchScreen(currentUser: widget.currentUser,),
           AddPostScreen(currentUser: widget.currentUser,),
          const ActivityScreen(),
          ProfileScreen(currentUser: widget.currentUser,),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Constants.backGroundColor,
        items:   [
          BottomNavigationBarItem(icon: _currentIndex == 0 ? const Icon(Icons.home,color: Constants.primaryColor,) : const Icon(Icons.home_outlined,color: Constants.darkGreyColor,) ),
          BottomNavigationBarItem(icon: _currentIndex == 1 ? const Icon(Icons.search,color: Constants.primaryColor,):const Icon(Icons.search,color: Constants.darkGreyColor,) ),
          BottomNavigationBarItem(icon: _currentIndex == 2 ? const Icon(Icons.add_circle,color: Constants.primaryColor,):const Icon(Icons.add_circle,color: Constants.darkGreyColor,)),
          BottomNavigationBarItem(icon: _currentIndex == 3 ? const Icon(Icons.favorite,color: Constants.primaryColor,):const Icon(Icons.favorite_border,color: Constants.darkGreyColor,)),
          BottomNavigationBarItem(icon:_currentIndex == 4 ? const Icon(Icons.person_pin,color: Constants.primaryColor,):const Icon(Icons.person_pin,color: Constants.darkGreyColor,)),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
