

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants.dart';
import '../../../domain/entities/PostEntity.dart';
import '../../bloc/get_single_post/get_single_post_cubit.dart';
import '../../bloc/posts/posts_bloc.dart';
import '../home/widgets/favourite_animation.dart';
import '../home/widgets/like_animation.dart';

class SingleDetailedPostScreen extends StatefulWidget {
  final PostEntity post;
  final UserEntity currentUser;
  const SingleDetailedPostScreen({super.key, required this.post, required this.currentUser});

  @override
  State<SingleDetailedPostScreen> createState() => _SingleDetailedPostScreenState();
}

class _SingleDetailedPostScreenState extends State<SingleDetailedPostScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetSinglePostCubit>().getSinglePost(PostEntity(id: widget.post.id!));
  }
  bool _isLike = false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.backGroundColor,
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
      ),
      backgroundColor: Constants.backGroundColor,
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.02.mediaW(context),vertical: 0.02.mediaH(context)),
            child: BlocBuilder<GetSinglePostCubit,GetSinglePostState>(
              builder: (context,state){
                if(state is GetSinglePostLoaded)
                  {
                    return  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: mediaHeight(context, 0.03),
                                  backgroundImage: NetworkImage(state.singlePost.profilePic!),
                                ),
                                sizeHor(mediaWidth(context, 0.02)),
                                Text(state.singlePost.username!,
                                    style: Theme.of(context).textTheme.displayMedium)
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  _openBottom(context);
                                },
                                icon: const Icon(Icons.more_vert)),
                          ],
                        ),
                        sizeVer(mediaHeight(context, 0.015)),
                        GestureDetector(
                          onDoubleTap: () {
                            context.read<PostsBloc>().add(
                                LikePostEvent(postEntity: PostEntity(id: state.singlePost.id)));
                            setState(() {
                              _isLike = true;
                            });
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: mediaHeight(context, 0.4),
                                child: Image.network(
                                  state.singlePost.postImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 200),
                                opacity: _isLike ? 1 : 0,
                                child: LikeAnimation(
                                    onLikeFinish: () {
                                      setState(() {
                                        _isLike = false;
                                      });
                                    },
                                    isLikeAnimating: _isLike,
                                    duration: const Duration(milliseconds: 200),
                                    child: const Icon(
                                      Icons.favorite,
                                      size: 100,
                                      color: Constants.primaryColor,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        sizeVer(mediaHeight(context, 0.013)),
                        Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    FavIconAnimation(post: state.singlePost,currentUser: widget.currentUser,),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, RouteNames.commentScreen,arguments: {
                                          "currentUser": widget.currentUser,
                                          "postEntity": state.singlePost,
                                        });
                                      },
                                      icon: Icon(
                                        Icons.comment,
                                        size: mediaHeight(context, 0.04),
                                      ),
                                    ),
                                    sizeHor(mediaWidth(context, 0.01)),
                                    Icon(
                                      Icons.share,
                                      size: mediaHeight(context, 0.04),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.bookmark_border,
                                  size: mediaHeight(context, 0.04),
                                ),
                              ],
                            ),
                          ],
                        ),
                        sizeVer(mediaHeight(context, 0.013)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  state.singlePost.username!,
                                  style: Theme.of(context).textTheme.displayMedium,
                                ),
                                sizeHor(mediaWidth(context, 0.013)),
                                Text(
                                  state.singlePost.description!,
                                  style: Theme.of(context).textTheme.displaySmall,
                                ),
                              ],
                            ),
                            Text(
                              "${state.singlePost.totalLikes} likes",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(color: Constants.darkGreyColor),
                            ),
                            sizeVer(mediaHeight(context, 0.005)),
                            Text(
                              "view all ${state.singlePost.totalComments} comments....",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(color: Constants.darkGreyColor),
                            ),
                            sizeVer(mediaHeight(context, 0.005)),
                            Text(
                              DateFormat("dd-M-y").format(state.singlePost.createAt!.toDate()),
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(color: Constants.darkGreyColor),
                            ),
                          ],
                        )
                      ],
                    );
                  }
                return const Center(child: CircularProgressIndicator(),);
              },
            ),
          ),
      ),
    );
  }
  _openBottom(BuildContext context) {
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
              child: widget.currentUser.uid == widget.post.createUid
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    color: Constants.primaryColor,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.update),
                      sizeHor(mediaWidth(context, 0.01)),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteNames.editPostScreen,
                                arguments: widget.post);
                          },
                          child: Text(
                            "Update Post",
                            style:
                            Theme.of(context).textTheme.displayLarge,
                          )),
                    ],
                  ),
                  sizeVer(mediaHeight(context, 0.02)),
                  const Divider(
                    color: Constants.primaryColor,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.delete),
                      sizeHor(mediaWidth(context, 0.01)),
                      InkWell(
                        onTap: () {
                          context.read<PostsBloc>().add(DeletePostEvent(
                              postEntity:
                              PostEntity(id: widget.post.id,createUid: widget.post.createUid)));
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Delete Post",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                    ],
                  ),
                  sizeVer(mediaHeight(context, 0.02)),
                  const Divider(
                    color: Constants.primaryColor,
                  ),
                ],
              )
                  : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    color: Constants.primaryColor,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.flag),
                      sizeHor(mediaWidth(context, 0.01)),
                      InkWell(
                          onTap: () {},
                          child: Text(
                            "Report",
                            style:
                            Theme.of(context).textTheme.displayLarge,
                          )),
                    ],
                  ),
                  sizeVer(mediaHeight(context, 0.02)),
                  const Divider(
                    color: Constants.primaryColor,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.info_outline),
                      sizeHor(mediaWidth(context, 0.01)),
                      Text(
                        "Why this post?",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
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
