import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/domain/entities/CommentEntity.dart';

class CommentModel extends CommentEntity {
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

   const CommentModel({
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
   }) : super (
     commentId: commentId,
     createrUid: createrUid,
     postId: postId,
     description: description,
     username: username,
     userProfileUrl: userProfileUrl,
     createAt: createAt,
     likes: likes,
     totalReplys: totalReplys,
     totalLikes: totalLikes,
   );

  factory CommentModel.fromSnapshot(DocumentSnapshot snapshot){
    final snap = snapshot.data() as Map<String,dynamic>;
    return CommentModel(
      commentId: snap["commentId"],
      createrUid: snap["createrUid"],
      postId: snap["postId"],
      description: snap["description"],
      username: snap["username"],
      userProfileUrl: snap["userProfileUrl"],
      createAt: snap["createAt"],
      likes: List.from(snap["likes"]),
      totalReplys: snap["totalReplys"],
      totalLikes: snap["totalLikes"],
    );
  }

  Map<String , dynamic> toMap (){
    return {
      "commentId" : commentId,
      "createrUid" : createrUid,
      "postId" : postId,
      "description" : description,
      "username" : username,
      "userProfileUrl" : userProfileUrl,
      "createAt" : createAt,
      "likes" : likes,
      "totalReplys" : totalReplys,
      "totalLikes" : totalLikes,
    };
  }

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
    totalReplys
  ];
}
