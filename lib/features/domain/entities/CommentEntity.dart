import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String? commentId;
  final String? createrUid;
  final String? postId;
  final String? description;
  final String? username;
  final String? userProfileUrl;
  final Timestamp? createAt;
  final List<String>? likes;
  final num? totalLikes;
  final num? totalReplys;

  const CommentEntity({
    this.commentId,
      this.createrUid,
      this.postId,
      this.description,
      this.username,
      this.userProfileUrl,
      this.createAt,
      this.likes,
      this.totalReplys,
    this.totalLikes,
  });

  @override
  List<Object?> get props => [
        commentId,
        createrUid,
        postId,
        description,
        username,
        userProfileUrl,
        createAt,
        likes,
        totalReplys,
        totalLikes
      ];
}
