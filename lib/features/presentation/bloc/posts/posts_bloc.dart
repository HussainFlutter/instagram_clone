import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/constants.dart';
import 'package:instagram_clone/features/domain/entities/PostEntity.dart';
import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/domain/use%20case/firebase_storage/upload_image_usecase.dart';
import 'package:instagram_clone/features/domain/use%20case/post/delete_post_usecase.dart';
import 'package:instagram_clone/features/domain/use%20case/post/get_posts_usecase.dart';
import 'package:instagram_clone/features/domain/use%20case/post/like_post_usecase.dart';
import 'package:instagram_clone/features/domain/use%20case/post/update_post_usecase.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/use case/post/create_post_usecase.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final CreatePostUseCase create;
  final DeletePostUseCase delete;
  final GetPostsUseCase getPosts;
  final UploadImageUseCase uploadImage;
  final LikePostUseCase like;
  final UpdatePostUseCase update;
  PostsBloc(
      {required this.create,
      required this.update,
      required this.delete,
      required this.getPosts,
      required this.like,
      required this.uploadImage})
      : super(PostsInitial()) {
    on<CreatePostEvent>((event, emit) => _createPost(event, emit));
    on<DeletePostEvent>((event, emit) => _deletePost(event, emit));
    on<GetPostsEvent>((event, emit) => _getPosts(emit));
    on<LikePostEvent>((event, emit) => _likePost(event, emit));
    on<UpdatePostEvent>((event, emit) => _updatePost(event, emit));
  }

  Future<void> _getPosts(
    Emitter<PostsState> emit,
  ) async {
    try {
      emit(PostsLoading());
      List<PostEntity> post = [];
      final Completer<void> completer = Completer<void>();
      getPosts.call(const PostEntity()).listen(
            (posts) {
              post = posts;
              emit(PostsLoaded(posts: post));
            },
            onDone: () => completer.complete(),
            onError: (error) {
              toast(message: error.toString());
              emit(PostsError());
              completer.complete(); // Resolve the Completer in case of an error
            },
          );
      await completer.future;
      emit(PostsLoaded(posts: post));
    } catch (e) {
      toast(message: e.toString());
      emit(PostsError());
    }
  }

  Future<void> _createPost(
    CreatePostEvent event,
    Emitter<PostsState> emit,
  ) async {
    try {
      showDialog(
          barrierDismissible: false,
          context: event.context,
          builder: (context) {
            return AlertDialog(
                backgroundColor: Constants.backGroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                content: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Creating Post",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const CircularProgressIndicator(
                              color: Constants.blueColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
          });
      String postImage = await uploadImage(
        File(event.postEntity.postImage!),
        true,
        event.postEntity.createUid!,
      );
      String id = const Uuid().v1();
      final post = PostEntity(
        id: id,
        createAt: Timestamp.now(),
        description: event.postEntity.description,
        postImage: postImage,
        likes: event.postEntity.likes,
        totalLikes: event.postEntity.totalLikes,
        totalComments: event.postEntity.totalComments,
        profilePic: event.postEntity.profilePic,
        createUid: event.postEntity.createUid,
        username: event.postEntity.username,
      );
      await create(post);
      toast(
          message: "Post Created!", toastBackGroundColor: Constants.greenColor);
      if (event.context.mounted) {
        Navigator.pop(event.context);
        Navigator.pushNamed(event.context, "/",
            arguments: {event.currentUser.uid, event.currentUser});
      }
    } catch (e) {
      toast(message: e.toString());
    }
  }

  Future<void> _deletePost(
    DeletePostEvent event,
    Emitter<PostsState> emit,
  ) async {
    try {
      await delete(event.postEntity);
      toast(message: "Post Deleted!");
    } catch (e) {
      toast(message: e.toString());
    }
  }

  Future<void> _updatePost(
    UpdatePostEvent event,
    Emitter<PostsState> emit,
  ) async {
    try {
      showDialog(
          barrierDismissible: false,
          context: event.context,
          builder: (context) {
            return AlertDialog(
                backgroundColor: Constants.backGroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                content: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Updating Post",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const CircularProgressIndicator(
                              color: Constants.blueColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
          });
      String postImage = "";
      if (event.update == true) {
        postImage = await uploadImage(
          File(event.postEntity.postImage!),
          true,
          event.postEntity.createUid!,
        );
      }
      PostEntity post = PostEntity(
        description: event.postEntity.description,
        postImage:
            event.update == true ? postImage : event.postEntity.postImage,
        id: event.postEntity.id,
      );
      await update(post);
      toast(
          message: "Post Updated!", toastBackGroundColor: Constants.greenColor);
      Navigator.pop(event.context);
      Navigator.pop(event.context);
      Navigator.pop(event.context);
    } catch (e) {
      toast(message: e.toString());
    }
  }

  Future<void> _likePost(
    LikePostEvent event,
    Emitter<PostsState> emit,
  ) async {
    try {
      await like(event.postEntity);
    } catch (e) {
      toast(message: e.toString());
    }
  }
}
