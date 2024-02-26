part of 'get_single_use_for_profile_bloc.dart';

abstract class GetSingleUseForProfileEvent extends Equatable {
  const GetSingleUseForProfileEvent();
}


class GetSingleUserForProfileEvent extends GetSingleUseForProfileEvent{
  final String uid;

  const GetSingleUserForProfileEvent({required this.uid});
  @override
  List<Object?> get props => [uid];

}