part of 'get_single_user_bloc.dart';

abstract class GetSingleUserEvent extends Equatable {
  const GetSingleUserEvent();
}
class GetSingleUser extends GetSingleUserEvent {
  final UserEntity targetUser;

  const GetSingleUser({required this.targetUser});
  @override
  List<Object?> get props => [targetUser];

}