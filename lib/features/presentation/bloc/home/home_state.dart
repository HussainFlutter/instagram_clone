part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}
class HomeLoaded extends HomeState {
  final List<UserEntity> usersList;

  const HomeLoaded({required this.usersList});
  @override
  List<Object> get props => [usersList];
}
class HomeError extends HomeState {}
