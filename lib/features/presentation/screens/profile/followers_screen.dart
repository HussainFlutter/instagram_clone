import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/use%20case/User/get_followers_use_case.dart';
import '../../../../core/constants.dart';
import '../../../../core/dependency_injection.dart';
import '../../../domain/entities/UserEntity.dart';
import '../../bloc/get_single_user_for_profile/get_single_use_for_profile_bloc.dart';
import '../../bloc/user_actions/follow_someone/user_actions_bloc.dart';
import '../../widgets/custom_appbar.dart';

class FollowersScreen extends StatefulWidget {
   UserEntity targetUser;
  final UserEntity currentUser;
   FollowersScreen(
      {super.key, required this.targetUser, required this.currentUser});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  String uid = "";

  @override
  void dispose() {
    widget.targetUser = const UserEntity();
    super.dispose();
    // print("current");
    // print(widget.currentUser.uid);
    // print("other");
    // print(widget.targetUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backGroundColor,
      appBar: CustomAppBar(
        title: "Followers",
        leading: IconButton(
            onPressed: () {
              uid = widget.targetUser.uid!;
              context.read<GetSingleUseForProfileBloc>().add(GetSingleUserForProfileEvent(uid:uid));
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: widget.targetUser.followers!.isEmpty
            ? Center(
            child: Text(
              "No Followers yet",
              style: Theme.of(context).textTheme.displayMedium,
            ))
            : ListView.builder(
            itemCount: widget.targetUser.followers!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: StreamBuilder(
                    stream: sl<GetFollowersUseCase>()
                        .call(widget.targetUser.followers![index]),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final snap = snapshot.data!.first;
                        return InkWell(
                          onTap: () {
                            // Navigate to other users screen
                             widget.currentUser.uid != snap.uid ? Navigator.pushNamed(
                              context,
                              RouteNames.otherUsersProfileScreen,
                              arguments: {
                                "currentUser": widget.currentUser,
                                "targetUser": snap,
                              },
                            ) : Navigator.pushNamed(context, RouteNames.profileScreen,
                               arguments: widget.currentUser,
                             );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: mediaHeight(context, 0.03),
                                    backgroundImage: NetworkImage(
                                        snap!.profileUrl!),
                                  ),
                                  sizeHor(mediaWidth(context, 0.02)),
                                  Text(snap.username!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium)
                                ],
                              ),
                               widget.currentUser.uid != snap.uid  ? InkWell(
                                onTap: () {
                                  context.read<UserActionsBloc>().add(
                                      FollowSomeoneEvent(
                                          targetUser: snap,
                                          currentUser: widget.currentUser));
                                },
                                child: Container(
                                  width: 0.22.mediaW(context),
                                  height: 0.03.mediaH(context),
                                  decoration: BoxDecoration(
                                    color: snap
                                        .followers!
                                        .contains(widget.currentUser.uid)
                                        ? Constants.darkGreyColor
                                        : Constants.blueColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                      child: snap.followers!.contains(
                                          widget.currentUser.uid)
                                          ? Text(
                                        "Following",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      )
                                          : Text(
                                        "Follow",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      )),
                                ),
                              ) : const SizedBox(),
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text(
                              "Some Error While Loading Data \n Please Check Your Internet Connection",
                              style: Theme.of(context).textTheme.displayMedium,
                            ));
                      } else {
                        return Center(
                            child: Text(
                              "Some Unknown Error Occurred",
                              style: Theme.of(context).textTheme.displayMedium,
                            ));
                      }
                    }),
              );
            }),
      ),
    );
  }
}