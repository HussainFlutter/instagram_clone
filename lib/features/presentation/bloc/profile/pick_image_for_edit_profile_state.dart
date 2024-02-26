part of 'pick_image_for_edit_profile_cubit.dart';

abstract class PickImageForEditProfileState extends Equatable {
  const PickImageForEditProfileState();
  @override
  List<Object> get props => [];
}

class PickImageForEditProfileInitial extends PickImageForEditProfileState {}
class PickImageForEditProfileLoading extends PickImageForEditProfileState {}
class PickImageForEditProfileLoaded extends PickImageForEditProfileState {
  final String image;

  const PickImageForEditProfileLoaded({required this.image});

  @override
  List<Object> get props => [image];
}