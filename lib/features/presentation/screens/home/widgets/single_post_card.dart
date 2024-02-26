import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/PostEntity.dart';
import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/presentation/screens/home/widgets/favourite_animation.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import '../../../../../core/constants.dart';
import '../../../bloc/posts/posts_bloc.dart';
import 'like_animation.dart';

class SinglePostCard extends StatefulWidget {
  final PostEntity post;
  final UserEntity currentUser;
  const SinglePostCard(
      {super.key, required this.post, required this.currentUser});

  @override
  State<SinglePostCard> createState() => _SinglePostCardState();
}

class _SinglePostCardState extends State<SinglePostCard> {
  bool _isLike = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mediaWidth(context, 0.04)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () async {
                  if(widget.post.createUid != widget.currentUser.uid)
                    {
                      final UserEntity targetUser = UserEntity(uid: widget.post.createUid,username: widget.post.username,profileUrl: widget.post.profilePic);
                      if(context.mounted)
                        {
                          Navigator.pushNamed(
                            context,
                            RouteNames.otherUsersProfileScreen,
                            arguments: {
                              "currentUser":widget.currentUser,
                              "targetUser":targetUser,
                            },
                          );
                        }
                    }
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: mediaHeight(context, 0.03),
                      backgroundImage: NetworkImage(widget.post.profilePic!),
                    ),
                    sizeHor(mediaWidth(context, 0.02)),
                    Text(widget.post.username!,
                        style: Theme.of(context).textTheme.displayMedium)
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    _showBottomSheet(context);
                  },
                  icon: const Icon(Icons.more_vert)),
            ],
          ),
          sizeVer(mediaHeight(context, 0.015)),
          GestureDetector(
            onDoubleTap: () {
              context.read<PostsBloc>().add(
                  LikePostEvent(postEntity: PostEntity(id: widget.post.id)));
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
                    widget.post.postImage!,
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
                       FavIconAnimation(post: widget.post,currentUser: widget.currentUser,),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.commentScreen,arguments: {
                            "currentUser": widget.currentUser,
                            "postEntity": widget.post,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.post.username!,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          sizeHor(mediaWidth(context, 0.013)),
                          ReadMoreText(
                          widget.post.description!,
                            trimLines: 2,
                            preDataTextStyle: TextStyle(fontWeight: FontWeight.w500),
                            style: Theme.of(context).textTheme.displaySmall,
                            colorClickableText: Constants.darkGreyColor,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: '...show more',
                            trimExpandedText: ' show less',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  "${widget.post.totalLikes} likes",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Constants.darkGreyColor),
                ),
                sizeVer(mediaHeight(context, 0.005)),
                Text(
                  "view all ${widget.post.totalComments} comments....",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Constants.darkGreyColor),
                ),
                sizeVer(mediaHeight(context, 0.005)),
                Text(
                  DateFormat("dd-M-y").format(widget.post.createAt!.toDate()),
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Constants.darkGreyColor),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _showBottomSheet(BuildContext context) {
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
  // Future<UserEntity> _getUser (String uid) async {
  //   final getUser = sl<GetSingleUserUseCase>();
  //   try{
  //     UserEntity user2 = const UserEntity();
  //     final Completer<void> completer = Completer<void>();
  //    final sub = getUser(uid).listen(
  //           (userData)  {
  //         user2 = userData[0];
  //         completer.complete();
  //       },
  //       onDone: ()=>completer.complete(), // Resolve the Completer when the stream is done
  //       onError: (error) {
  //         //   toast(message: error.toString());
  //         completer.complete(); // Resolve the Completer in case of an error
  //         throw "no user found";
  //       },
  //     );
  //     // Wait for the Completer to complete before moving on
  //     await completer.future;
  //     sub.cancel();
  //     return user2;
  //
  //   }catch(e)
  //   {
  //     throw e;
  //   }
  //
  // }
}
