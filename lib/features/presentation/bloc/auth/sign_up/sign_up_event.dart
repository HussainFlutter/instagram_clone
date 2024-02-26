part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
  @override
  List<Object?> get props => [];
}

class CreateUserEvent extends SignUpEvent{
  final UserEntity user;

  const CreateUserEvent({required this.user});

  @override
  List<Object?> get props => [user];
}
