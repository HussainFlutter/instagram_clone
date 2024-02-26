part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  final List<PostEntity> posts;
  const PostsLoaded({required this.posts});
  @override
  List<Object> get props => [posts];
}

class PostsError extends PostsState {}