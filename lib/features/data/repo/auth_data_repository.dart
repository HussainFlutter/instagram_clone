

import 'dart:io';

import 'package:instagram_clone/features/data/data%20source/remote_data_source/auth_remote_data_source.dart';
import 'package:instagram_clone/features/domain/entities/CommentEntity.dart';
import 'package:instagram_clone/features/domain/entities/PostEntity.dart';
import 'package:instagram_clone/features/domain/entities/ReplyEntity.dart';
import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/domain/repo/UserRepo.dart';

class AuthRepository implements UserRepo {

  final AuthRemoteDataSource dataSource;
  const AuthRepository({required this.dataSource});

  // User Functions
  @override
  Future<void> createUser(UserEntity user) async => dataSource.createUser(user);

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) => dataSource.getSingleUser(uid);

  @override
  Future<String> getUserUid() => dataSource.getUserUid();

  @override
  Stream<List<UserEntity>> getUsers() => dataSource.getUsers();

  @override
  Future<bool> isLogin() => dataSource.isLogin();

  @override
  Future<void> logOut() => dataSource.logOut();

  @override
  Future<void> loginUser(UserEntity user) => dataSource.loginUser(user);

  @override
  Future<void> signUpUser(UserEntity user) => dataSource.signUpUser(user);

  @override
  Future<void> updateUser(UserEntity user) => dataSource.updateUser(user);

  @override
  Future<void> followUser(UserEntity targetUser, UserEntity currentUser) => dataSource.followUser(targetUser, currentUser);
  // Picture Functions
  @override
  Future<File?> pickImage() => dataSource.pickImage();

  @override
  Future<String> postImageToStorage(File image, bool isPost, String uid) => dataSource.postImageToStorage(image, isPost, uid);
  // Post Functions
  @override
  Future<void> createPost(PostEntity postEntity) => dataSource.createPost(postEntity);

  @override
  Future<void> deletePost(PostEntity postEntity) => dataSource.deletePost(postEntity);

  @override
  Stream<List<PostEntity>> getPosts(PostEntity postEntity) => dataSource.getPosts(postEntity);

  @override
  Future<void> likePost(PostEntity postEntity) => dataSource.likePost(postEntity);

  @override
  Future<void> updatePost(PostEntity postEntity) => dataSource.updatePost(postEntity);

  @override
  Stream<List<PostEntity>> getSinglePost(PostEntity postEntity) => dataSource.getSinglePost(postEntity);

  // Comment Functions
  @override
  Future<void> createComment(CommentEntity comment) => dataSource.createComment(comment);

  @override
  Future<void> deleteComment(CommentEntity comment) => dataSource.deleteComment(comment);

  @override
  Stream<List<CommentEntity>> getComment(CommentEntity comment) => dataSource.getComment(comment);

  @override
  Future<void> likeComment(CommentEntity comment) => dataSource.likeComment(comment);

  @override
  Future<void> updateComment(CommentEntity comment) => dataSource.updateComment(comment);
//Reply Features
  @override
  Future<void> createReply(ReplyEntity reply) => dataSource.createReply(reply);

  @override
  Future<void> deleteReply(ReplyEntity reply) => dataSource.deleteReply(reply);

  @override
  Stream<List<ReplyEntity>> getReply(ReplyEntity reply) => dataSource.getReply(reply);

  @override
  Future<void> likeReply(ReplyEntity reply) => dataSource.likeReply(reply);

  @override
  Future<void> updateReply(ReplyEntity reply) => dataSource.updateReply(reply);

  @override
  Stream<List<UserEntity>> getSingleOtherUser(String uid) => dataSource.getSingleOtherUser(uid);

  @override
  Stream<List<UserEntity>> getUserFollowers(String uid) =>dataSource.getUserFollowers(uid);

  @override
  Stream<List<UserEntity>> getUserFollowings(String uid) =>dataSource.getUserFollowings(uid);

}