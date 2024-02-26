import 'dart:io';
import 'package:instagram_clone/features/data/model/CommentModel.dart';
import 'package:instagram_clone/features/data/model/PostModel.dart';
import 'package:instagram_clone/features/data/model/ReplyModel.dart';
import 'package:instagram_clone/features/domain/entities/CommentEntity.dart';
import 'package:instagram_clone/features/domain/entities/PostEntity.dart';
import 'package:instagram_clone/features/domain/entities/ReplyEntity.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/core/constants.dart';
import 'package:instagram_clone/features/data/data%20source/remote_data_source/auth_remote_data_source.dart';
import 'package:instagram_clone/features/data/model/UserModel.dart';
import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;
  AuthRemoteDataSourceImpl(
      {required this.firebaseStorage,
      required this.firestore,
      required this.firebaseAuth});

  @override
  Future<void> createUser(UserEntity user) async {
    try {
      String uid = await getUserUid();
      final String profileUrl;
      if (user.profileUrl == null || user.profileUrl == "") {
        profileUrl = "";
      } else {
        profileUrl =
            await postImageToStorage(File(user.profileUrl!), false, uid);
      }
      UserModel model = UserModel(
        uid: uid,
        username: user.username,
        email: user.email,
        bio: user.bio,
        website: user.website,
        profileUrl: profileUrl,
        followers: const [],
        following: const [],
        totalFollowers: 0,
        totalFollowing: 0,
        totalPosts: 0,
      );
      await firestore
          .collection(FirebaseConsts.user)
          .doc(uid)
          .set(model.toMap());
    } on FirebaseAuthException catch (e) {
      toast(message: e.message!);
    }
  }

  @override
  Stream<List<UserEntity>> getSingleUser(String uid) {
    try {
      final user = firestore
          .collection(FirebaseConsts.user)
          .where("uid", isEqualTo: uid)
          .limit(1)
          .snapshots();
      return user.map(
          (event) => event.docs.map((e) => UserModel.fromSnapshot(e)).toList());
    } on FirebaseAuthException catch (e) {
      toast(message: e.message!);
      rethrow;
    }
  }

  @override
  Stream<List<UserEntity>> getSingleOtherUser(String uid) {
    try {
      final user = firestore
          .collection(FirebaseConsts.user)
          .where("uid", isEqualTo: uid)
          .limit(1)
          .snapshots();
      return user.map(
              (event) => event.docs.map((e) => UserModel.fromSnapshot(e)).toList());
    } on FirebaseAuthException catch (e) {
      toast(message: e.message!);
      rethrow;
    }
  }

  @override
  Stream<List<UserEntity>> getUserFollowers(String uid) {
    try {
      final user = firestore
          .collection(FirebaseConsts.user)
          .where("uid", isEqualTo: uid)
          .limit(1)
          .snapshots();
      return user.map(
              (event) => event.docs.map((e) => UserModel.fromSnapshot(e)).toList());
    } on FirebaseAuthException catch (e) {
      toast(message: e.message!);
      rethrow;
    }
  }

  @override
  Stream<List<UserEntity>> getUserFollowings(String uid) {
    try {
      final user = firestore
          .collection(FirebaseConsts.user)
          .where("uid", isEqualTo: uid)
          .limit(1)
          .snapshots();
      return user.map(
              (event) => event.docs.map((e) => UserModel.fromSnapshot(e)).toList());
    } on FirebaseAuthException catch (e) {
      toast(message: e.message!);
      rethrow;
    }
  }

  @override
  Stream<List<UserEntity>> getUsers() {
    try {
      final user = firestore.collection(FirebaseConsts.user).snapshots();
      return user.map(
          (event) => event.docs.map((e) => UserModel.fromSnapshot(e)).toList());
    } on FirebaseAuthException catch (e) {
      toast(message: e.message!);
      rethrow;
    }
  }

  @override
  Future<String> getUserUid() async => firebaseAuth.currentUser!.uid;

  @override
  Future<bool> isLogin() async => firebaseAuth.currentUser?.uid != null;

  @override
  Future<void> logOut() => firebaseAuth.signOut();

  @override
  Future<void> loginUser(UserEntity user) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: user.email!, password: user.password!);
    } on FirebaseAuthException catch (e) {
      toast(message: e.message!);
    }
  }

  @override
  Future<void> signUpUser(UserEntity user) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);
      await createUser(user);
    } on FirebaseAuthException catch (e) {
      toast(message: e.message!);
    }
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    Map<String, dynamic> updatedUser = {};

    if (user.username != null && user.username != "") {
      updatedUser["username"] = user.username;
    }
    if (user.name != null && user.name != "") {
      updatedUser["name"] = user.name;
    }
    print(updatedUser);
    if (user.email != null && user.email != "") {
      updatedUser["email"] = user.email;
    }
    if (user.bio != null && user.bio != "") {
      updatedUser["bio"] = user.bio;
    }
    if (user.website != null && user.website != "") {
      updatedUser["website"] = user.website;
    }
    print(updatedUser);
    if (user.totalPosts != null && user.totalPosts != 0) {
      updatedUser["totalPosts"] = user.totalPosts;
    }
    if (user.totalFollowing != null && user.totalFollowing != 0) {
      updatedUser["totalFollowing"] = user.totalFollowing;
    }
    if (user.totalFollowers != null && user.totalFollowers != 0) {
      updatedUser["totalFollowers"] = user.totalFollowers;
    }
    if (user.profileUrl != null && user.profileUrl != "") {
      updatedUser["profileUrl"] = user.profileUrl;
    }
    print(updatedUser);
    await firestore
        .collection(FirebaseConsts.user)
        .doc(user.uid)
        .update(updatedUser);
  }

  @override
  Future<void> followUser(UserEntity targetUser, UserEntity currentUser) async {
    final followRef = firestore.collection(FirebaseConsts.user).doc(targetUser.uid);
    final currentUserRef = firestore.collection(FirebaseConsts.user).doc(currentUser.uid);
    try{
      //Update total followers  and totalFollowers of target user
      final  doc = await followRef.get();
      final num totalFollowers = await doc.get("totalFollowers");
      final List<dynamic> followers = await doc.get("followers");
      if(followers.contains(currentUser.uid))
      {
        await followRef.update({
          "totalFollowers" : totalFollowers - 1,
          "followers" : FieldValue.arrayRemove([currentUser.uid]),
        });
      }
      else
      {
        await followRef.update({
          "totalFollowers" : totalFollowers + 1,
          "followers" : FieldValue.arrayUnion([currentUser.uid]),
        });
      }
      // Update CurrentUser's totalFollowing and following
      final  currentUserDoc = await currentUserRef.get();
      final num totalFollowers2 = await currentUserDoc.get("totalFollowing");
      final List<dynamic> followers2 = await currentUserDoc.get("following");
      if(followers2.contains(targetUser.uid))
      {
        await currentUserRef.update({
          "totalFollowing" : totalFollowers2 - 1,
          "following" : FieldValue.arrayRemove([targetUser.uid]),
        });
      }
      else
      {
        await currentUserRef.update({
          "totalFollowing" : totalFollowers2 + 1,
          "following" : FieldValue.arrayUnion([targetUser.uid]),
        });
      }
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<File?> pickImage() async {
    try {
      XFile? pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        return File(pickedImage.path);
      } else {
        toast(message: "No image Picked");
        throw "No image picked";
      }
    } catch (e) {
      toast(message: e.toString());
      rethrow;
    }
  }

  @override
  Future<String> postImageToStorage(File image, bool isPost, String uid) async {
    try {
      if (isPost == true) {
        const uuid = Uuid();
        String id = uuid.v1();
        await firebaseStorage
            .ref(FirebaseConsts.storagePosts)
            .child(uid)
            .child(id)
            .putFile(image);
        return firebaseStorage
            .ref(FirebaseConsts.storagePosts)
            .child(uid)
            .child(id)
            .getDownloadURL();
      } else {
        await firebaseStorage
            .ref(FirebaseConsts.user)
            .child(uid)
            .putFile(image);
        return firebaseStorage
            .ref(FirebaseConsts.user)
            .child(uid)
            .getDownloadURL();
      }
    } catch (e) {
      throw "Error occurred during uploading";
    }
  }

  @override
  Stream<List<PostEntity>> getSinglePost(PostEntity postEntity) {
    final ref = firestore.collection(FirebaseConsts.post).where("id",isEqualTo: postEntity.id!).snapshots();
    return ref.map((event) => event.docs.map((e) => PostModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> createPost(PostEntity postEntity) async {
    try {
      //creating post
      final postRef =
          firestore.collection(FirebaseConsts.post).doc(postEntity.id);
      Map<String, dynamic> post = PostModel(
        profilePic: postEntity.profilePic,
        postImage: postEntity.postImage,
        id: postEntity.id,
        username: postEntity.username,
        createAt: postEntity.createAt,
        createUid: postEntity.createUid,
        description: postEntity.description,
        likes: const [],
        totalComments: 0,
        totalLikes: 0,
      ).toMap();
      await postRef.set(post);
      //creating post
      // Updating total Posts
      final userRef =
          firestore.collection(FirebaseConsts.user).doc(postEntity.createUid);
      final userDoc = await userRef.get();
      final num totalPosts = userDoc.get("totalPosts");
      userRef.update({
        "totalPosts": totalPosts + 1,
      });
      // Updating total Posts
    } catch (e) {
      toast(message: e.toString());
    }
  }

  @override
  Future<void> deletePost(PostEntity postEntity) async {
    try {
      final postRef =
          firestore.collection(FirebaseConsts.post).doc(postEntity.id);
      await postRef.delete();
      // Updating total Posts
      final userRef =
          firestore.collection(FirebaseConsts.user).doc(postEntity.createUid);
      final userDoc = await userRef.get();
      final num totalPosts = userDoc.get("totalPosts");
      userRef.update({
        "totalPosts": totalPosts - 1,
      });
      // Updating total Posts
    } catch (e) {
      toast(message: e.toString());
    }
  }

  @override
  Stream<List<PostEntity>> getPosts(PostEntity postEntity) {
    try {
      final postRef = firestore
          .collection(FirebaseConsts.post)
          .orderBy("createAt", descending: true)
          .snapshots();
      return postRef.map(
          (event) => event.docs.map((e) => PostModel.fromSnapshot(e)).toList());
    } catch (e) {
      toast(message: e.toString());
      rethrow;
    }
  }

  @override
  Future<void> likePost(PostEntity postEntity) async {
    try {
      final postRef =
          firestore.collection(FirebaseConsts.post).doc(postEntity.id);
      final currentUid = await getUserUid();
      final post = await postRef.get();
      final like = await post.get("likes");
      final totalLikes = await post.get("totalLikes");
      if (like.contains(currentUid)) {
        await postRef.update({
          "likes": FieldValue.arrayRemove([currentUid]),
          "totalLikes": totalLikes! - 1,
        });
      } else {
        await postRef.update({
          "likes": FieldValue.arrayUnion([currentUid]),
          "totalLikes": totalLikes! + 1,
        });
      }
    } catch (e) {
      toast(message: e.toString());
    }
  }

  @override
  Future<void> updatePost(PostEntity postEntity) async {
    try {
      final postRef =
          firestore.collection(FirebaseConsts.post).doc(postEntity.id);
      Map<String, dynamic> updatePost = {};
      if (postEntity.description != null && postEntity.description != "") {
        updatePost["description"] = postEntity.description;
      }
      if (postEntity.postImage != null && postEntity.postImage != "") {
        updatePost["postImage"] = postEntity.postImage;
      }
      await postRef.update(updatePost);
    } catch (e) {
      toast(message: e.toString());
    }
  }

  //Comment Implementation
  @override
  Future<void> createComment(CommentEntity comment) async {
    final commentRef = FirebaseFirestore.instance
        .collection(FirebaseConsts.post)
        .doc(comment.postId);
    Map<String, dynamic> postComment = CommentModel(
      commentId: comment.commentId,
      postId: comment.postId,
      createAt: comment.createAt,
      createrUid: comment.createrUid,
      likes: comment.likes,
      username: comment.username,
      userProfileUrl: comment.userProfileUrl,
      totalReplys: comment.totalReplys,
      description: comment.description,
      totalLikes: comment.totalLikes,
    ).toMap();
    try {
      await commentRef
          .collection(FirebaseConsts.comments)
          .doc(comment.commentId)
          .set(postComment);
      final getTotalComments = await commentRef.get();
      final num totalComments = await getTotalComments.get("totalComments");
      await commentRef.update({"totalComments": totalComments + 1});
    } on FirebaseException catch (e) {
      toast(message: e.message!);
    } catch (e) {
      toast(message: e.toString());
    }
  }

  @override
  Future<void> deleteComment(CommentEntity comment) async {
    final commentRef = FirebaseFirestore.instance
        .collection(FirebaseConsts.post)
        .doc(comment.postId)
        .collection(FirebaseConsts.comments)
        .doc(comment.commentId);
    final ref = FirebaseFirestore.instance
        .collection(FirebaseConsts.post)
        .doc(comment.postId);
    try {
      final comments = await ref.get();
      final num totalComments = await comments.get("totalComments");
      ref.update({
        "totalComments": totalComments - 1,
      });
      await commentRef.delete();
    } catch (e) {
      toast(message: e.toString());
    }
  }

  @override
  Stream<List<CommentEntity>> getComment(CommentEntity comment) {
    final commentRef = FirebaseFirestore.instance
        .collection(FirebaseConsts.post)
        .doc(comment.postId)
        .collection(FirebaseConsts.comments)
        .orderBy("createAt", descending: true)
        .snapshots();
    try {
      return commentRef.map((event) =>
          event.docs.map((e) => CommentModel.fromSnapshot(e)).toList());
    } catch (e) {
      toast(message: e.toString());
      rethrow;
    }
  }

  @override
  Future<void> likeComment(CommentEntity comment) async {
    final commentRef = FirebaseFirestore.instance
        .collection(FirebaseConsts.post)
        .doc(comment.postId)
        .collection(FirebaseConsts.comments)
        .doc(comment.commentId);
    try {
      final like = await commentRef.get();
      final List<dynamic> listOfLikes = await like.get("likes");
      final totalLikes = await like.get("totalLikes");
      if (listOfLikes.contains(comment.createrUid)) {
        commentRef.update({
          "likes": FieldValue.arrayRemove([comment.createrUid]),
          "totalLikes": totalLikes - 1,
        });
      } else {
        commentRef.update({
          "likes": FieldValue.arrayUnion([comment.createrUid]),
          "totalLikes": totalLikes + 1,
        });
      }
    } catch (e) {
      toast(message: e.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateComment(CommentEntity comment) async {
    final commentRef = FirebaseFirestore.instance
        .collection(FirebaseConsts.post)
        .doc(comment.postId)
        .collection(FirebaseConsts.comments)
        .doc(comment.commentId);
    try {
      Map<String, dynamic> updateComment = {};
      if (comment.description != null && comment.description != "") {
        updateComment["description"] = comment.description;
      }
      await commentRef.update(updateComment);
    } catch (e) {
      toast(message: e.toString());
      rethrow;
    }
  }

// Reply Functions
  @override
  Future<void> createReply(ReplyEntity reply) async {
    final commentRef = firestore
        .collection(FirebaseConsts.post)
        .doc(reply.postId)
        .collection(FirebaseConsts.comments)
        .doc(reply.commentId)
        .collection(FirebaseConsts.replys);
    final sendReply = ReplyModel(
      replyId: reply.replyId,
      commentId: reply.commentId,
      postId: reply.postId,
      username: reply.username,
      userProfilePic: reply.userProfilePic,
      createrUid: reply.createrUid,
      description: reply.description,
      createAt: reply.createAt,
      likes: reply.likes,
      totalLikes: reply.totalLikes,
    ).toMap();

    try {
      final comment = firestore
          .collection(FirebaseConsts.post)
          .doc(reply.postId)
          .collection(FirebaseConsts.comments)
          .doc(reply.commentId);
      print(reply.postId);
      print(reply.commentId);
      final commentDoc = await comment.get();
      final totalReplys = await commentDoc.get("totalReplys");
      await comment.update({
        "totalReplys": totalReplys + 1,
      });
      await commentRef.doc(reply.replyId).set(sendReply);
    } catch (e) {
      toast(message: e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteReply(ReplyEntity reply) async {
    final commentRef = firestore
        .collection(FirebaseConsts.post)
        .doc(reply.postId)
        .collection(FirebaseConsts.comments)
        .doc(reply.commentId)
        .collection(FirebaseConsts.replys);
    try {
      final comment = firestore
          .collection(FirebaseConsts.post)
          .doc(reply.postId)
          .collection(FirebaseConsts.comments)
          .doc(reply.commentId);
      final commentDoc = await comment.get();
      final totalReplys = await commentDoc.get("totalReplys");
      await comment.update({
        "totalReplys": totalReplys - 1,
      });
      await commentRef.doc(reply.replyId).delete();
    } catch (e) {
      toast(message: e.toString());
      rethrow;
    }
  }

  @override
  Stream<List<ReplyEntity>> getReply(ReplyEntity reply) {
    final commentRef = firestore
        .collection(FirebaseConsts.post)
        .doc(reply.postId)
        .collection(FirebaseConsts.comments)
        .doc(reply.commentId)
        .collection(FirebaseConsts.replys)
        .snapshots();
    return commentRef.map(
        (event) => event.docs.map((e) => ReplyModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> likeReply(ReplyEntity reply) async {
    final commentRef = firestore
        .collection(FirebaseConsts.post)
        .doc(reply.postId)
        .collection(FirebaseConsts.comments)
        .doc(reply.commentId)
        .collection(FirebaseConsts.replys);
    try {
      final replyDoc = await commentRef.doc(reply.replyId).get();
      final List<dynamic> likes = await replyDoc.get("likes");
      final num totalLikes = await replyDoc.get("totalLikes");
      final currentUid = await getUserUid();
      if (likes.contains(currentUid)) {
        await commentRef.doc(reply.replyId).update({
          "likes": FieldValue.arrayRemove([currentUid]),
          "totalLikes": totalLikes - 1,
        });
      } else {
        await commentRef.doc(reply.replyId).update({
          "likes": FieldValue.arrayUnion([currentUid]),
          "totalLikes": totalLikes + 1,
        });
      }
    } catch (e) {
      toast(message: e.toString());
    }
  }

  @override
  Future<void> updateReply(ReplyEntity reply) async {
    final commentRef = firestore
        .collection(FirebaseConsts.post)
        .doc(reply.postId)
        .collection(FirebaseConsts.comments)
        .doc(reply.commentId)
        .collection(FirebaseConsts.replys);
    Map<String, dynamic> update = {};
    if (reply.description!.isNotEmpty &&
        reply.description != null &&
        reply.description != "") {
      update["description"] = reply.description!;
    }
    try {
      await commentRef.doc(reply.replyId).update(update);
    } catch (e) {
      toast(message: e.toString());
    }
  }





}
