import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/constants.dart';
import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/domain/use%20case/User/get_followings_use_case.dart';
import 'package:instagram_clone/features/presentation/widgets/custom_appbar.dart';
import '../../../../core/dependency_injection.dart';
import '../../bloc/get_single_user_for_profile/get_single_use_for_profile_bloc.dart';
import '../../bloc/user_actions/follow_someone/user_actions_bloc.dart';

class FollowingsScreen extends StatefulWidget {
    UserEntity targetUser;
  final UserEntity currentUser;
    FollowingsScreen(
      {super.key, required this.targetUser, required this.currentUser});

  @override
  State<FollowingsScreen> createState() => _FollowingsScreenState();
}

class _FollowingsScreenState extends State<FollowingsScreen> {
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
    // print("current");
    // print(widget.currentUser.uid);
    // print("other");
    // print(widget.targetUser.uid);
    return Scaffold(
      backgroundColor: Constants.backGroundColor,
      appBar: CustomAppBar(
        title: widget.targetUser.username,
        leading: IconButton(
            onPressed: () {
               uid = widget.targetUser.uid!;
               context.read<GetSingleUseForProfileBloc>().add(GetSingleUserForProfileEvent(uid:uid));
              //  print("uid");
              // print(uid);
               Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: widget.targetUser.following!.isEmpty
            ? Center(
                child: Text(
                "No Followings yet",
                style: Theme.of(context).textTheme.displayMedium,
              ))
            : ListView.builder(
                itemCount: widget.targetUser.following!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: StreamBuilder(
                        stream: sl<GetFollowingsUseCase>()
                            .call(widget.targetUser.following![index]),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final snap = snapshot.data!.first;
                            return InkWell(
                              onTap: () {
                                widget.currentUser.uid == snap.uid ?
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.profileScreen,
                                  arguments: widget.currentUser,
                                )
                                    : Navigator.pushNamed(
                                  context,
                                  RouteNames.otherUsersProfileScreen,
                                  arguments: {
                                    "currentUser": widget.currentUser,
                                    "targetUser": snap,
                                  },
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
                                            snap.profileUrl!),
                                      ),
                                      sizeHor(mediaWidth(context, 0.02)),
                                      Text(snap.username!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium)
                                    ],
                                  ),
                                    snap.uid != widget.currentUser.uid ?  InkWell(
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
