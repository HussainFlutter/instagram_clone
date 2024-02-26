part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  bool loading;
  SignUpState({required this.loading});
  @override
  List<Object> get props => [loading];
}

class SignUpInitial extends SignUpState {
  SignUpInitial({required super.loading});
}

class SignUpLoading extends SignUpState {
  SignUpLoading({required super.loading});
}
class SignUpLoaded extends SignUpState {
  SignUpLoaded({required super.loading});
}
class SignUpError extends SignUpState {
  SignUpError({required super.loading});
}
