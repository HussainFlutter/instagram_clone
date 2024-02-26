import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  // in entity
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

  //not in the entity
  final String? password;
  final String? otherUid;

  const UserEntity(
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
      this.password,
      this.otherUid,
      this.totalPosts});

  @override
  List<Object?> get props => [
        uid,
        username,
        name,
        bio,
        website,
        email,
        profileUrl,
        followers,
        following,
        totalFollowers,
        totalFollowing,
        password,
        otherUid,
        totalPosts
      ];
}
