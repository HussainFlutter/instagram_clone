

import 'dart:io';

import '../../../domain/entities/CommentEntity.dart';
import '../../../domain/entities/PostEntity.dart';
import '../../../domain/entities/ReplyEntity.dart';
import '../../../domain/entities/UserEntity.dart';

abstract class AuthRemoteDataSource {
  Future<void> signUpUser (UserEntity user);
  Future<void> loginUser (UserEntity user);
  Future<bool> isLogin();
  Future<void> logOut();

  Stream<List<UserEntity>> getUsers();
  Stream<List<UserEntity>> getSingleUser(String uid);
  Stream<List<UserEntity>> getSingleOtherUser(String uid);
  Stream<List<UserEntity>> getUserFollowings(String uid);
  Stream<List<UserEntity>> getUserFollowers(String uid);
  Future<String> getUserUid();
  Future<void> createUser (UserEntity user);
  Future<void> updateUser(UserEntity user);
  Future<void> followUser(UserEntity targetUser,UserEntity currentUser);
  //Firebase Storage
  Future<File?> pickImage ();
  Future<String> postImageToStorage (File image, bool isPost, String uid);
  //Post Features
  Future<void> createPost(PostEntity postEntity);
  Future<void> updatePost(PostEntity postEntity);
  Future<void> deletePost(PostEntity postEntity);
  Future<void> likePost(PostEntity postEntity);
  Stream<List<PostEntity>> getPosts (PostEntity postEntity);
  Stream<List<PostEntity>> getSinglePost (PostEntity postEntity);
  //Comment Features
  Future<void> createComment(CommentEntity comment);
  Future<void> updateComment(CommentEntity comment);
  Future<void> deleteComment(CommentEntity comment);
  Future<void> likeComment(CommentEntity comment);
  Stream<List<CommentEntity>> getComment (CommentEntity comment);
  //Reply Features
  Future<void> createReply(ReplyEntity reply);
  Future<void> updateReply(ReplyEntity reply);
  Future<void> deleteReply(ReplyEntity reply);
  Future<void> likeReply(ReplyEntity reply);
  Stream<List<ReplyEntity>> getReply (ReplyEntity reply);
}