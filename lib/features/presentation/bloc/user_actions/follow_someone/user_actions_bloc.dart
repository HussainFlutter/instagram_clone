import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/core/constants.dart';
import 'package:instagram_clone/features/domain/entities/UserEntity.dart';

import '../../../../domain/use case/User/follow_someone.dart';

part 'user_actions_event.dart';
part 'user_actions_state.dart';

class UserActionsBloc extends Bloc<UserActionsEvent, UserActionsState> {
  final FollowSomeoneUseCase follow;
  UserActionsBloc({required this.follow}) : super(UserActionsInitial()) {
    on<FollowSomeoneEvent>((event, emit) => _followSomeone(event));
  }
  _followSomeone (
      FollowSomeoneEvent event
      ) async {
    try
    {
      await follow(event.targetUser,event.currentUser);
    }
    catch(e)
    {
      toast(message: e.toString());
    }
  }
}


