import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/PostEntity.dart';
import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/presentation/bloc/profile/profile_bloc.dart';
import 'package:instagram_clone/features/presentation/widgets/custom_appbar.dart';

import '../../../../core/constants.dart';
import '../../bloc/posts/posts_bloc.dart';
import '../../widgets/LOADING.dart';

class ProfileScreen extends StatefulWidget {
  final UserEntity currentUser;
  const ProfileScreen({super.key, required this.currentUser});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PostsBloc>().add(GetPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backGroundColor,
      appBar: CustomAppBar(
        goBack: true,
        title: widget.currentUser.username,
        actions: [
          IconButton(
              onPressed: () {
                _showBottomSheet();
              },
              icon: const Icon(
                Icons.more_vert,
                color: Constants.primaryColor,
              ))
        ],
      ),
      body: Padding(
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
                          widget.currentUser.profileUrl?.isEmpty ?? true
                              ? const AssetImage(
                                  "assets/image_assets/default_profile.jpg")
                              : NetworkImage(widget.currentUser.profileUrl!)
                                  as ImageProvider<Object>,
                    ),
                    sizeHor(mediaWidth(context, 0.02)),
                    Column(
                      children: [
                        Text(
                          "${widget.currentUser.name == null || widget.currentUser.name == "" ? widget.currentUser.username : widget.currentUser.name}",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text(
                          "${widget.currentUser.bio}",
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
                          "${widget.currentUser.totalPosts}",
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
                          "targetUser":widget.currentUser,
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
                            "${widget.currentUser.totalFollowers}",
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
                          "targetUser":widget.currentUser,
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
                            "${widget.currentUser.totalFollowing}",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            sizeVer(mediaHeight(context, 0.04)),
            BlocBuilder<PostsBloc, PostsState>(
              builder: (context, state) {
                if(state is PostsLoaded)
                  {
                    final List<PostEntity> filteredPosts =
                    state.posts
                        .where((element) =>
                    widget.currentUser.uid == element.createUid).toList();
                    if(filteredPosts.isEmpty)
                    {
                      return Center(child: Text("Post Something to show here",style: Theme.of(context).textTheme.displayMedium,),);
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

  _showBottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: mediaHeight(context, 0.3),
            color: Constants.backGroundColor,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: mediaWidth(context, 0.1),
                  vertical: mediaHeight(context, 0.05)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    color: Constants.primaryColor,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.edit),
                      sizeHor(mediaWidth(context, 0.01)),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteNames.editProfileScreen,
                                arguments: widget.currentUser);
                          },
                          child: Text(
                            "Edit Profile",
                            style: Theme.of(context).textTheme.displayLarge,
                          )),
                    ],
                  ),
                  sizeVer(mediaHeight(context, 0.02)),
                  const Divider(
                    color: Constants.primaryColor,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.logout, color: Constants.redColor),
                      sizeHor(mediaWidth(context, 0.01)),
                      InkWell(
                          onTap: () {
                            context.read<ProfileBloc>().add(LogOutEvent(context: context));
                          },
                          child: Text(
                            "Log Out",
                            style: Theme.of(context).textTheme.displayLarge,
                          )),
                    ],
                  ),
                  sizeVer(mediaHeight(context, 0.02)),
                  const Divider(
                    color: Constants.primaryColor,
                  ),
                ],
              ),
            ),
          );
        });
  }
}