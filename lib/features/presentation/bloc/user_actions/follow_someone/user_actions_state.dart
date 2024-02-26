part of 'user_actions_bloc.dart';

abstract class UserActionsState extends Equatable {
  const UserActionsState();
}

class UserActionsInitial extends UserActionsState {
  @override
  List<Object> get props => [];
}
