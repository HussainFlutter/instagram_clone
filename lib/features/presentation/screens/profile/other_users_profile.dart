import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/PostEntity.dart';
import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/presentation/bloc/get_single_user_for_profile/get_single_use_for_profile_bloc.dart';
import 'package:instagram_clone/features/presentation/bloc/user_actions/follow_someone/user_actions_bloc.dart';
import 'package:instagram_clone/features/presentation/widgets/custom_appbar.dart';

import '../../../../core/constants.dart';
import '../../../../core/dependency_injection.dart';
import '../../bloc/posts/posts_bloc.dart';
import '../../widgets/LOADING.dart';

class OthersProfileScreen extends StatefulWidget {
   UserEntity targetUser;
  final UserEntity currentUser;
   OthersProfileScreen({super.key, required this.targetUser, required this.currentUser});

  @override
  State<OthersProfileScreen> createState() => _OthersProfileState();
}

class _OthersProfileState extends State<OthersProfileScreen> {
  @override
  void initState() {
    super.initState();
    //print(widget.targetUser.uid);
    context.read<PostsBloc>().add(GetPostsEvent());
    context.read<GetSingleUseForProfileBloc>().add(GetSingleUserForProfileEvent(uid: widget.targetUser.uid!));
  }

  @override
  void dispose() {
    widget.targetUser = const UserEntity();
    super.dispose();
    print("current dispose ");
    print(widget.currentUser.uid);
    print("other dispose ");
    print(widget.targetUser.uid);
    sl<GetSingleUseForProfileBloc>().close();
  }

  @override
  Widget build(BuildContext context) {
    print("current");
   print(widget.currentUser.uid);
   print("other");
    print(widget.targetUser.uid);
    return BlocBuilder<GetSingleUseForProfileBloc, GetSingleUseForProfileState>(
  builder: (context, state) {
    if(state is GetSingleUseForProfileLoaded)
    {
    return Scaffold(
      backgroundColor: Constants.backGroundColor,
      appBar: CustomAppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Constants.primaryColor,),
          onPressed: (){
            String uid = state.targetUser.uid!;
            print("uid");
            print(uid);
            Navigator.pop(context);
          },
        ),
        title: state.targetUser.username,
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         //_showBottomSheet();
        //       },
        //       icon: const Icon(
        //         Icons.more_vert,
        //         color: Constants.primaryColor,
        //       ))
        // ],
      ),
      body:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: mediaHeight(context, 0.03),
                        backgroundColor: Constants.darkGreyColor,
                        backgroundImage:
                        state.targetUser.profileUrl?.isEmpty ?? true
                            ? const AssetImage(
                            "assets/image_assets/default_profile.jpg")
                            : NetworkImage(state.targetUser.profileUrl!)
                        as ImageProvider<Object>,
                      ),
                      sizeHor(mediaWidth(context, 0.02)),
                      Column(
                        children: [
                          Text(
                            "${state.targetUser.name == null || state.targetUser.name == "" ? state.targetUser.username : state.targetUser.name}",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          0.01.verSize(context),
                          Text(
                            "${state.targetUser.bio}",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "Posts",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          Text(
                            "${state.targetUser.totalPosts}",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                      sizeHor(mediaWidth(context, 0.03)),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, RouteNames.followersScreen,
                              arguments: {
                                "currentUser":widget.currentUser,
                                "targetUser":state.targetUser,
                              }
                          );
                        },
                        child: Column(
                          children: [
                            Text(
                              "Followers",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            Text(
                              "${state.targetUser.totalFollowers}",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ],
                        ),
                      ),
                      sizeHor(mediaWidth(context, 0.03)),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, RouteNames.followingsScreen,
                              arguments: {
                                "currentUser":widget.currentUser,
                                "targetUser":state.targetUser,
                              }
                          );
                        },
                        child: Column(
                          children: [
                            Text(
                              "Following",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            Text(
                              "${state.targetUser.totalFollowing}",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              0.03.verSize(context),
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      context.read<UserActionsBloc>().add(FollowSomeoneEvent(targetUser: state.targetUser, currentUser: widget.currentUser));
                    },
                    child: Container(
                      width: 0.22.mediaW(context),
                      height: 0.03.mediaH(context),
                      decoration: BoxDecoration(
                        color: state.targetUser.followers!.contains(widget.currentUser.uid) ? Constants.darkGreyColor : Constants.blueColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child:  Center(child: state.targetUser.followers!.contains(widget.currentUser.uid) ?
                      Text(  "Following",style: Theme.of(context).textTheme.displaySmall,)
                          : Text(  "Follow",style: Theme.of(context).textTheme.displaySmall,)
                      ),
                    ),
                  ),
                  0.03.horSize(context),
                  Container(
                    width: 0.22.mediaW(context),
                    height: 0.03.mediaH(context),
                    decoration: BoxDecoration(
                      color: Constants.darkGreyColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child:  Center(child: Text("Message",style: Theme.of(context).textTheme.displaySmall,)),
                  ),
                ],
              ),
              sizeVer(mediaHeight(context, 0.04)),
              BlocBuilder<PostsBloc, PostsState>(
                builder: (context, state) {
                  if(state is PostsLoaded)
                  {
                    final List<PostEntity> filteredPosts =  state.posts.where((element) => widget.targetUser.uid == element.createUid).toList();
                    if(filteredPosts.isEmpty)
                    {
                      return Center(child: Text("This user has no posts yet",style: Theme.of(context).textTheme.displayMedium,),);
                    }
                    else
                    {
                      return Expanded(
                        child: GridView.builder(
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 4,
                          ),
                          itemCount: filteredPosts.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (){
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.detailedPostScreen,
                                  arguments: {
                                    "currentUser" :widget.currentUser,
                                    "postEntity":filteredPosts[index],
                                  },
                                );
                              },
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: Image.network(filteredPosts[index].postImage!,fit: BoxFit.cover,),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
                  return const LOADING();
                },
              )
            ],
          ),
        ),
    );
      }
    return const LOADING();
  },
    );
}
}
