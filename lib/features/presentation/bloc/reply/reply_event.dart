part of 'reply_bloc.dart';

abstract class ReplyEvent extends Equatable {
  const ReplyEvent();
  @override
  List<Object?> get props => [];
}

class CreateReplyEvent extends ReplyEvent {
  final ReplyEntity reply;

  const CreateReplyEvent({required this.reply});
  @override
  List<Object?> get props => [];

}

class UpdateReplyEvent extends ReplyEvent {
  final ReplyEntity reply;

  const UpdateReplyEvent({required this.reply});
  @override
  List<Object?> get props => [];

}

class DeleteReplyEvent extends ReplyEvent {
  final ReplyEntity reply;

  const DeleteReplyEvent({required this.reply});
  @override
  List<Object?> get props => [];

}

class LikeReplyEvent extends ReplyEvent {
  final ReplyEntity reply;

  const LikeReplyEvent({required this.reply});
  @override
  List<Object?> get props => [];

}
class GetReplyEvent extends ReplyEvent {
  final ReplyEntity reply;

  const GetReplyEvent({required this.reply});
  @override
  List<Object?> get props => [];

}
