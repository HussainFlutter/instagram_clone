import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/UserEntity.dart';

class UserModel extends UserEntity {
  final String? uid;
  final String? username;
  final String? name;
  final String? bio;
  final String? website;
  final String? email;
  final String? profileUrl;
  final List? followers;
  final List? following;
  final num? totalFollowers;
  final num? totalFollowing;
  final num? totalPosts;

  const UserModel(
      {this.uid,
      this.username,
      this.name,
      this.bio,
      this.website,
      this.email,
      this.profileUrl,
      this.followers,
      this.following,
      this.totalFollowers,
      this.totalFollowing,
      this.totalPosts})
      : super(
          uid: uid,
          username: username,
          name: name,
          bio: bio,
          website: website,
          email: email,
          profileUrl: profileUrl,
          followers: followers,
          following: following,
          totalFollowers: totalFollowers,
          totalFollowing: totalFollowing,
          totalPosts: totalPosts,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> snapData = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      uid: snapData["uid"],
      username: snapData["username"],
      name: snapData["name"],
      bio: snapData["bio"],
      website: snapData["website"],
      email: snapData["email"],
      profileUrl: snapData["profileUrl"],
      followers: List.from(snapData["followers"]).toList(),
      following: List.from(snapData["following"]).toList(),
      totalFollowers: snapData["totalFollowers"],
      totalFollowing: snapData["totalFollowing"],
      totalPosts: snapData["totalPosts"],
    );
  }

  Map<String , dynamic> toMap () =>
      {
      "uid":uid,
      "username":username,
      "name":name,
      "bio":bio,
      "website":website,
      "email":email,
      "profileUrl":profileUrl,
      "followers":followers,
      "following":following,
      "totalFollowers":totalFollowers,
      "totalFollowing":totalFollowing,
      "totalPosts":totalPosts,
    };

}
