

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/domain/entities/PostEntity.dart';

class PostModel extends PostEntity {
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

  const PostModel({
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
  }) : super (
    createUid: createUid,
    id: id,
    username: username,
    description: description,
    postImage: postImage,
    profilePic: profilePic,
    createAt: createAt,
    likes: likes,
    totalLikes: totalLikes,
    totalComments: totalComments,
  );

 factory PostModel.fromSnapshot (DocumentSnapshot snapshot) {
    Map<String ,dynamic>  snap = snapshot.data() as Map<String , dynamic>;
   return PostModel(
      createUid: snap["createUid"],
      id: snap["id"],
      username: snap["username"],
      description: snap["description"],
      postImage: snap["postImage"],
      profilePic: snap["profilePic"],
      createAt: snap["createAt"],
      likes: List.from(snap["likes"]),
      totalLikes: snap["totalLikes"],
      totalComments: snap["totalComments"],
    );
  }

  Map<String , dynamic> toMap () {
   return {
     "createUid":createUid,
     "id":id,
     "username":username,
     "description":description,
     "postImage":postImage,
     "profilePic":profilePic,
     "createAt":createAt,
     "likes":likes,
     "totalLikes":totalLikes,
     "totalComments":totalComments,
   };
  }

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