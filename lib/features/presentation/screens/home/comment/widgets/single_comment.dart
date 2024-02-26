import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/CommentEntity.dart';
import 'package:instagram_clone/features/domain/entities/PostEntity.dart';
import 'package:instagram_clone/features/domain/entities/ReplyEntity.dart';
import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/presentation/bloc/reply/reply_bloc.dart';
import 'package:instagram_clone/features/presentation/screens/home/comment/widgets/single_reply.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/constants.dart';
import '../../../../bloc/comment/comment_bloc.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../functions/post_reply.dart';

class SingleComment extends StatefulWidget {
  final PostEntity post;
  final UserEntity currentUser;
  final CommentEntity comment;
  const SingleComment(
      {super.key,
      required this.comment,
      required this.currentUser,
      required this.post});

  @override
  State<SingleComment> createState() => _SingleCommentState();
}

class _SingleCommentState extends State<SingleComment> {
  TextEditingController _replyController = TextEditingController();
  bool isUserReplying = false;
  @override
  void initState() {
    super.initState();
    //context.read<ReplyBloc>().add(GetReplyEvent(reply: ReplyEntity(postId: widget.post.id,commentId: widget.comment.commentId)));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 5, vertical: mediaHeight(context, 0.013)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Comment
          InkWell(
            onLongPress: () {
              widget.currentUser.uid == widget.comment.createrUid
                  ? _showModalSheet()
                  : const SizedBox();
            },
            child: Column(
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
                          backgroundImage:
                              NetworkImage(widget.comment.userProfileUrl!),
                        ),
                        0.02.horSize(context),
                        //sizeHor(mediaWidth(context, 0.02)),
                        Text(
                          widget.comment.username!,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ),
                    Column(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      context
                                          .read<CommentBloc>()
                                          .add(LikeCommentEvent(
                                          comment: CommentEntity(
                                            postId: widget.post.id,
                                            commentId: widget.comment.commentId,
                                            createrUid: widget.currentUser.uid,
                                          )));
                                    },
                                    icon: widget.comment.likes!
                                        .contains(widget.currentUser.uid)
                                        ? const Icon(
                                      Icons.favorite,
                                      color: Constants.redColor,
                                      size: 22,
                                    )
                                        : const Icon(
                                      Icons.favorite_border,
                                      color: Constants.darkGreyColor,
                                      size: 22,
                                    )),
                                Text(
                                  widget.comment.totalLikes!.toString(),
                                  style: Theme.of(context).textTheme.displaySmall,
                                ),
                              ],
                            ),
                  ],
                ),
                Text(
                  widget.comment.description!,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                sizeVer(mediaHeight(context, 0.01)),
                Row(
                  children: [
                    Text(
                      DateFormat("dd/M/y")
                          .format(widget.comment.createAt!.toDate()),
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: Constants.darkGreyColor),
                    ),
                    sizeHor(mediaWidth(context, 0.05)),
                    InkWell(
                        onTap: () {
                          setState(() {
                            isUserReplying = !isUserReplying;
                          });
                        },
                        child: Text(
                          "Reply",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(color: Constants.darkGreyColor),
                        )),
                    sizeHor(mediaWidth(context, 0.05)),

                    // View Replys

                    InkWell(
                      onTap: () {
                        widget.comment.totalReplys == 0
                            ? null
                            : context.read<ReplyBloc>().add(GetReplyEvent(
                                reply: ReplyEntity(
                                    postId: widget.post.id,
                                    commentId: widget.comment.commentId)));
                      },
                      child: Text(
                        "View ${widget.comment.totalReplys} Reply",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: Constants.darkGreyColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //Comment
          //Show Replys Here
          BlocBuilder<ReplyBloc, ReplyState>(builder: (context, state) {
            if (state is ReplyLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ReplyLoaded) {
              List<ReplyEntity> reply = state.replyList
                  .where((element) =>
                      element.commentId == widget.comment.commentId)
                  .toList();
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: reply.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onLongPress: () {
                          //Implement
                        },
                        child: SingleReply(
                          reply: reply[index],
                          currentUser: widget.currentUser,
                        ));
                  });
            }
            if (state is ReplyError) {
              return const Center(child: Text("Some Error Occurred"));
            } else {
              return const SizedBox();
            }
          }),
          //Show Replys Here
          isUserReplying == true
              ? sizeVer(mediaHeight(context, 0.003))
              : sizeVer(0),
          isUserReplying == true
              // Reply
              ? SizedBox(
                  height: mediaHeight(context, 0.15),
                  width: mediaWidth(context, 0.79),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomTextFormField(
                        controller: _replyController,
                        hintText: "Post your reply...",
                      ),
                      TextButton(
                          onPressed: () {
                            // Creating Reply
                            if (_replyController.text.isNotEmpty &&
                                _replyController.text != "") {
                              CommentFunctions.postReplyFunc(
                                  context,
                                  ReplyEntity(
                                    description: _replyController.text,
                                    username: widget.currentUser.username,
                                    userProfilePic:
                                        widget.currentUser.profileUrl,
                                    createrUid: widget.currentUser.uid,
                                    commentId: widget.comment.commentId,
                                    postId: widget.post.id,
                                  ));
                              _replyController.clear();
                              isUserReplying = false;
                              context.read<ReplyBloc>().add(GetReplyEvent(
                                  reply: ReplyEntity(
                                      postId: widget.post.id,
                                      commentId: widget.comment.commentId)));
                            }
                          },
                          child: Text(
                            "Post",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: Constants.blueColor),
                          ))
                    ],
                  ),
                )
              : const SizedBox(),
          //Reply
        ],
      ),
    );
  }

  //Dialogs

  // Delete Dialog
  _showDeleteDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Constants.backGroundColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                0.01.verSize(context),
                Text(
                  "Do you want to delete your comment?",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                0.01.verSize(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          context.read<CommentBloc>().add(DeleteCommentEvent(
                                  comment: CommentEntity(
                                commentId: widget.comment.commentId,
                                postId: widget.post.id,
                              )));
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Yes",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(color: Constants.redColor),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "No",
                          style: Theme.of(context).textTheme.displaySmall,
                        )),
                  ],
                )
              ],
            ),
          );
        });
  }

  // Update Dialog
  _showUpdateDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          TextEditingController descriptionController = TextEditingController();
          descriptionController.text = widget.comment.description!;
          return AlertDialog(
            backgroundColor: Constants.backGroundColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Edit Comment",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                0.01.verSize(context),
                CustomTextFormField(
                  controller: descriptionController,
                  hintText: "Edit description",
                ),
                0.01.verSize(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          context.read<CommentBloc>().add(UpdateCommentEvent(
                                  comment: CommentEntity(
                                commentId: widget.comment.commentId,
                                postId: widget.post.id,
                                description: descriptionController.text == "" &&
                                        descriptionController.text.isEmpty
                                    ? widget.comment.description
                                    : descriptionController.text,
                              )));
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Edit",
                          style: Theme.of(context).textTheme.displaySmall,
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "back",
                          style: Theme.of(context).textTheme.displaySmall,
                        )),
                  ],
                )
              ],
            ),
          );
        });
  }

  //Modal Sheet
  _showModalSheet() {
    return showModalBottomSheet(
        backgroundColor: Constants.backGroundColor,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.05.mediaW(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                0.02.verSize(context),
                Text(
                  "More Options",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                0.02.verSize(context),
                const Divider(),
                InkWell(
                    onTap: () {
                      _showDeleteDialog();
                    },
                    child: Text(
                      "Delete Comment",
                      style: Theme.of(context).textTheme.displayMedium,
                    )),
                0.01.verSize(context),
                const Divider(),
                0.01.verSize(context),
                InkWell(
                    onTap: () {
                      _showUpdateDialog();
                    },
                    child: Text(
                      "Update Comment",
                      style: Theme.of(context).textTheme.displayMedium,
                    )),
                0.02.verSize(context),
              ],
            ),
          );
        });
  }
}
