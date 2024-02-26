import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/core/constants.dart';
import 'package:instagram_clone/features/domain/entities/ReplyEntity.dart';
import '../../../domain/use case/reply/create_reply_usecase.dart';
import '../../../domain/use case/reply/delete_reply_usecase.dart';
import '../../../domain/use case/reply/get_replys_usecase.dart';
import '../../../domain/use case/reply/like_reply_usecase.dart';
import '../../../domain/use case/reply/update_reply_usecase.dart';

part 'reply_event.dart';
part 'reply_state.dart';

class ReplyBloc extends Bloc<ReplyEvent, ReplyState> {
  final CreateReplyUseCase create;
  final DeleteReplyUseCase delete;
  final UpdateReplyUseCase update;
  final GetReplyUseCase get;
  final LikeReplyUseCase like;

   ReplyBloc({
      required this.update,
      required this.get,
      required this.delete,
      required this.like,
      required this.create,
      })
      : super(ReplyInitial()) {
     on<CreateReplyEvent>((event, emit) =>_createReply(event));
     on<GetReplyEvent>((event, emit) =>_getReply(event,emit));
     on<LikeReplyEvent>((event,emit) =>_likeReply(event));
   }

   Future<void> _createReply (
       CreateReplyEvent event,
       ) async {
     try{
       await create(event.reply);
     }catch(e){
       toast(message: e.toString());
       rethrow;
     }
   }

  Future<void> _likeReply (
      LikeReplyEvent event,
      ) async {
    try{
      await like(event.reply);
    }catch(e){
      toast(message: e.toString());
      rethrow;
    }
  }

  Future<void> _getReply(
      GetReplyEvent event,
      Emitter<ReplyState> emit,
      ) async {
     emit(ReplyLoading());
    try{
      List<ReplyEntity> reply = [];
       final Completer<void> completer = Completer<void>();
       get.call(event.reply).listen((replys) {
         reply = replys;
         emit(ReplyLoaded(replyList: reply));
       },
         onDone: () => completer.complete(),
         onError: (error) {
           toast(message: error.toString());
           emit(ReplyError());
           completer.complete(); // Resolve the Completer in case of an error
         },
       );
       await completer.future;
       emit(ReplyLoaded(replyList: reply));
    }catch(e){
      toast(message: e.toString());
      rethrow;
    }
  }

}
