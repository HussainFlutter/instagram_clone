part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginLoaded extends LoginState {
  final String uid;
  final UserEntity user;
  const LoginLoaded({required this.user,required this.uid});
  @override
  List<Object> get props => [uid,user];
}
class LoginError extends LoginState {}
