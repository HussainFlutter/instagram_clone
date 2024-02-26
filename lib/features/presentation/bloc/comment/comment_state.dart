part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  final bool loading;
  const CommentState({required this.loading});
  @override
  List<Object> get props => [loading];
}

class CommentInitial extends CommentState {
  const CommentInitial({required super.loading});

}

class CommentLoading extends CommentState {
  const CommentLoading({required super.loading});

}

class CommentLoaded extends CommentState {
  final List<CommentEntity> commentList;
  const CommentLoaded({required super.loading,required this.commentList});

  @override
  List<Object> get props => [commentList];
}

class CommentError extends CommentState {
  const CommentError({required super.loading});

}
