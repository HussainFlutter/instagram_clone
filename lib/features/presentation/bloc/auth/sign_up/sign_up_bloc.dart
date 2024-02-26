import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/core/constants.dart';
import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import '../../../../domain/use case/User/Auth/signUp_usecase.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUp;
  SignUpBloc({required this.signUp}) : super(SignUpInitial( loading: false)) {
   on<CreateUserEvent>((event, emit) => _createUserFunc(event,emit));
  }

  Future<void> _createUserFunc (
      CreateUserEvent event,
      Emitter<SignUpState> emit,
      ) async {
    emit(SignUpLoading(loading: true));
    try{
      await signUp(event.user);
      emit(SignUpLoaded(loading: false));
    }catch(e){
      toast(message: e.toString());
      emit(SignUpError(loading: false));
    }
  }
}
