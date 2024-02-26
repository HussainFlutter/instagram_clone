part of 'pick_image_cubit.dart';

abstract class PickImageState extends Equatable {
  const PickImageState();
  @override
  List<Object> get props => [];
}

class PickImageInitial extends PickImageState {}
class PickImageLoading extends PickImageState {}
class PickImageLoaded extends PickImageState {
  final String image;

  const PickImageLoaded({required this.image});

  @override
  List<Object> get props => [image];
}

