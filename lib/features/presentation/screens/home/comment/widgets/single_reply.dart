import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/ReplyEntity.dart';
import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/presentation/bloc/reply/reply_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/constants.dart';

class SingleReply extends StatefulWidget {
  final ReplyEntity reply;
  final UserEntity currentUser;
  const SingleReply(
      {super.key, required this.reply, required this.currentUser});

  @override
  State<SingleReply> createState() => _SingleReplyState();
}

class _SingleReplyState extends State<SingleReply> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 0.04.mediaH(context), vertical: 0.015.mediaH(context)),
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
                        backgroundImage: NetworkImage(widget.reply.userProfilePic!),
                      ),
                      0.02.horSize(context),
                      //sizeHor(mediaWidth(context, 0.02)),
                      Text(
                        widget.reply.username!,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            // Like Event
                            context.read<ReplyBloc>().add(LikeReplyEvent(reply: ReplyEntity(
                              postId: widget.reply.postId,
                              commentId: widget.reply.commentId,
                              replyId: widget.reply.replyId,
                            )));
                          },
                          icon: widget.reply.likes!.contains(widget.currentUser.uid)
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
                        widget.reply.totalLikes!.toString(),
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  )
                ],
              ),
              Text(
                widget.reply.description!,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              sizeVer(mediaHeight(context, 0.01)),
              Row(children: [
                Text(
                  DateFormat("dd/M/y").format(widget.reply.createAt!.toDate()),
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Constants.darkGreyColor),
                ),
                sizeHor(mediaWidth(context, 0.05)),
                InkWell(
                    onTap: () {},
                    child: Text(
                      "Reply",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(color: Constants.darkGreyColor),
                    ))
              ])
            ]));
  }
}
