part of 'reply_bloc.dart';

abstract class ReplyState extends Equatable {
  const ReplyState();
  @override
  List<Object> get props => [];
}

class ReplyInitial extends ReplyState {}
class ReplyLoading extends ReplyState {}
class ReplyLoaded extends ReplyState {
  final List<ReplyEntity> replyList;

  const ReplyLoaded({required this.replyList});
  @override
  List<Object> get props => [];
}
class ReplyError extends ReplyState {}

