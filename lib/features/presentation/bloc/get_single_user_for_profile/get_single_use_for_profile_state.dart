part of 'get_single_use_for_profile_bloc.dart';

abstract class GetSingleUseForProfileState extends Equatable {
  const GetSingleUseForProfileState();
  @override
  List<Object> get props => [];
}

class GetSingleUseForProfileInitial extends GetSingleUseForProfileState {}
class GetSingleUseForProfileLoading extends GetSingleUseForProfileState {}
class GetSingleUseForProfileLoaded extends GetSingleUseForProfileState {
  final UserEntity targetUser;

  const GetSingleUseForProfileLoaded({required this.targetUser});
  @override
  List<Object> get props => [targetUser];
}
class GetSingleUseForProfileError extends GetSingleUseForProfileState {}
