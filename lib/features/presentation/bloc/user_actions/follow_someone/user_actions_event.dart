part of 'user_actions_bloc.dart';

abstract class UserActionsEvent extends Equatable {
  const UserActionsEvent();
  @override
  List<Object?> get props => [];
}

class FollowSomeoneEvent extends UserActionsEvent {
  final UserEntity targetUser;
  final UserEntity currentUser;

  const FollowSomeoneEvent({required this.targetUser, required this.currentUser});

  @override
  List<Object?> get props => [targetUser,currentUser];

}
