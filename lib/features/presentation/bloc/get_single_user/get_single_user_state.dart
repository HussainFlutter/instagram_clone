part of 'get_single_user_bloc.dart';

abstract class GetSingleUserState extends Equatable {
  const GetSingleUserState();
  @override
  List<Object> get props => [];
}

class GetSingleUserInitial extends GetSingleUserState {

}
class GetSingleUserLoading extends GetSingleUserState {

}
class GetSingleUserLoaded extends GetSingleUserState {
  final UserEntity targetUser;

  const GetSingleUserLoaded({required this.targetUser});
  @override
  List<Object> get props => [targetUser];
}
class GetSingleUserError extends GetSingleUserState {

}
