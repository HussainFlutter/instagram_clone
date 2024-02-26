part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();
  @override
  List<Object?> get props => [];
}

class CreateCommentEvent extends CommentEvent{
  final CommentEntity comment;

  const CreateCommentEvent({required this.comment});
  @override
  List<Object?> get props => [comment];
}
class UpdateCommentEvent extends CommentEvent{
  final CommentEntity comment;

  const UpdateCommentEvent({required this.comment});
  @override
  List<Object?> get props => [comment];
}
class DeleteCommentEvent extends CommentEvent{
  final CommentEntity comment;

  const DeleteCommentEvent({required this.comment});
  @override
  List<Object?> get props => [comment];
}
class LikeCommentEvent extends CommentEvent{
  final CommentEntity comment;

  const LikeCommentEvent({required this.comment});
  @override
  List<Object?> get props => [comment];
}
class GetCommentsEvent extends CommentEvent{
  final CommentEntity comment;

  const GetCommentsEvent({required this.comment});
  @override
  List<Object?> get props => [comment];
}