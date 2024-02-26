part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();
  @override
  List<Object?> get props =>[];
}

class CreatePostEvent extends PostsEvent {
  final PostEntity postEntity;
  final BuildContext context;
  final UserEntity currentUser;
  const CreatePostEvent({required this.postEntity,required this.currentUser,required this.context});
  @override
  List<Object?> get props =>[postEntity,context,currentUser];
}
class DeletePostEvent extends PostsEvent {
  final PostEntity postEntity;

  const DeletePostEvent({required this.postEntity});
  @override
  List<Object?> get props =>[postEntity];
}
class UpdatePostEvent extends PostsEvent {
  final PostEntity postEntity;
  final BuildContext context;
  final bool update;
  const UpdatePostEvent({required this.postEntity,required this.context,required this.update});
  @override
  List<Object?> get props =>[postEntity,context];
}
class LikePostEvent extends PostsEvent {
  final PostEntity postEntity;

  const LikePostEvent({required this.postEntity});
  @override
  List<Object?> get props =>[postEntity];
}
class GetPostsEvent extends PostsEvent {}
