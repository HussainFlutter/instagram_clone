import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ReplyEntity extends Equatable {
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

  const ReplyEntity({
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
  });
  @override
  List<Object?> get props => [
        replyId,
        commentId,
        postId,
        username,
        userProfilePic,
        createrUid,
        description,
        createAt,
        likes,
        totalLikes,
      ];
}
