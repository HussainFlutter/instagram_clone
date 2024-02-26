import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/core/constants.dart';
import 'package:instagram_clone/features/domain/entities/CommentEntity.dart';
import 'package:instagram_clone/main.dart';
import '../../../domain/use case/comment/createComment_usecase.dart';
import '../../../domain/use case/comment/deleteComment_usecase.dart';
import '../../../domain/use case/comment/getComment_usecase.dart';
import '../../../domain/use case/comment/likeComment_usecase.dart';
import '../../../domain/use case/comment/updateComment_usecase.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {

  final CreateCommentUseCase create;
  final UpdateCommentUseCase update;
  final DeleteCommentUseCase delete;
  final LikeCommentUseCase like;
  final GetCommentUseCase get;

  CommentBloc({
    required this.create,
    required this.update,
    required this.delete,
    required this.get,
    required this.like,
  }) : super(const CommentInitial(loading: false)) {
    on<CreateCommentEvent>((event, emit) => _createComment(event));
    on<UpdateCommentEvent>((event, emit) => _updateComment(event));
    on<DeleteCommentEvent>((event, emit) => _deleteComment(event));
    on<LikeCommentEvent>((event, emit) => _likeComment(event));
    on<GetCommentsEvent>((event, emit) => _getComment(emit,event));
  }
  Future<void> _createComment (
      CreateCommentEvent event,
      ) async {
    CommentEntity comment = CommentEntity(
      commentId: randomId.v1(),
      postId: event.comment.postId,
      createAt: Timestamp.now(),
      username: event.comment.username,
      userProfileUrl: event.comment.userProfileUrl,
      likes: const [],
      totalLikes: 0,
      totalReplys: 0,
      description: event.comment.description,
      createrUid: event.comment.createrUid,
    );
    try{
      await create(comment);
    }catch(e)
    {
      rethrow;
    }
  }

   Future<void> _deleteComment (
       DeleteCommentEvent event,
       ) async {
    try{
      await delete(event.comment);
    }catch(e)
    {
      rethrow;
    }
  }

   Future<void> _updateComment (
       UpdateCommentEvent event,
       ) async {
    try{
      await update(event.comment);
    }catch(e)
    {
      rethrow;
    }
  }

   Future<void> _likeComment (
       LikeCommentEvent event,
       ) async {
    try{
      await like(event.comment);
    }catch(e)
    {
      rethrow;
    }
  }

   Future<void> _getComment  (
       Emitter<CommentState> emit,
       GetCommentsEvent event,
       ) async {
     emit(const CommentLoading(loading: true));
     try{
       Completer<void> complete = Completer<void>();
       List<CommentEntity> comments = [];
       get(event.comment).listen((event) {
         comments = event;
         emit(CommentLoaded(loading: false, commentList: comments));
       },
       onDone: () => complete.complete(),
       onError: (error) {
         toast(message: error.toString());
         emit(const CommentError(loading: false));
         complete.complete();
       }
       );
       await complete.future;
       emit(CommentLoaded(loading: false, commentList: comments));
    }catch(e)
    {
      rethrow;
    }
  }


}
