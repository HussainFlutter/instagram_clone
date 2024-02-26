part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];

}

class EditProfileEvent extends ProfileEvent {
  final UserEntity user;
  final String currentProfile;
  const EditProfileEvent({required this.user,required this.currentProfile});

  @override
  List<Object?> get props => [user,currentProfile];
}

class LogOutEvent extends ProfileEvent {
  final BuildContext context;
  const LogOutEvent({required this.context});
}
