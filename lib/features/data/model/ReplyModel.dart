

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/domain/entities/ReplyEntity.dart';

class ReplyModel extends ReplyEntity {
  final String? replyId;
  final String? commentId;
  final String? postId;
  final String? username;
  final String? userProfilePic;
  final String? createrUid;
  final String? description;
  final Timestamp? createAt;
  final List<String>? likes;
  final num? totalLikes;

  const ReplyModel({
    this.replyId,
    this.commentId,
    this.postId,
    this.username,
    this.userProfilePic,
    this.createrUid,
    this.description,
    this.createAt,
    this.likes,
    this.totalLikes,
  }) : super (
    replyId: replyId,
    commentId: commentId,
    postId: postId,
    username: username,
    userProfilePic: userProfilePic,
    createrUid: createrUid,
    description: description,
    createAt: createAt,
    likes: likes,
    totalLikes: totalLikes,
  );
  factory ReplyModel.fromSnapshot(DocumentSnapshot snapshot){
    final snap = snapshot.data() as Map<String,dynamic>;
    return ReplyModel(
      replyId: snap["replyId"],
      commentId: snap["commentId"],
      postId: snap["postId"],
      username: snap["username"],
      userProfilePic: snap["userProfilePic"],
      createrUid: snap["createrUid"],
      description: snap["description"],
      likes: List.from(snap["likes"]),
      createAt: snap["createAt"],
      totalLikes: snap["totalLikes"],
    );
  }

  Map<String , dynamic> toMap (){
    return {
      "replyId" : replyId,
      "commentId" : commentId,
      "postId" : postId,
      "username" : username,
      "userProfilePic" : userProfilePic,
      "createrUid" : createrUid,
      "description" : description,
      "likes" : likes,
      "createAt" : createAt,
      "totalLikes" : totalLikes,
    };
  }
}