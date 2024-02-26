

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/ReplyEntity.dart';
import 'package:instagram_clone/features/presentation/bloc/reply/reply_bloc.dart';

import '../../../../../../main.dart';

class CommentFunctions {
 static postReplyFunc (BuildContext context,ReplyEntity reply){
    context.read<ReplyBloc>().add(CreateReplyEvent(
        reply: ReplyEntity(
      createAt: Timestamp.now(),
      postId: reply.postId,
      createrUid: reply.createrUid,
      commentId: reply.commentId,
      userProfilePic: reply.userProfilePic,
      username: reply.username,
      description: reply.description,
      likes: [],
      replyId: randomId.v1(),
      totalLikes: 0,
    )));
  }
}