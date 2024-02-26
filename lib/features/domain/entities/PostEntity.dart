import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String? createUid;
  final String? id;
  final String? username;
  final String? description;
  final String? postImage;
  final String? profilePic;
  final Timestamp? createAt;
  final List<String?>? likes;
  final num? totalLikes;
  final num? totalComments;

  const PostEntity({
       this.createUid,
       this.likes,
       this.postImage,
       this.username,
       this.profilePic,
       this.description,
       this.id,
       this.createAt,
       this.totalLikes,
       this.totalComments,
      });

  @override
  List<Object?> get props => [
    createUid,
    likes,
    postImage,
    username,
    profilePic,
    description,
    id,
    createAt,
    totalLikes,
    totalComments,
  ];
}
