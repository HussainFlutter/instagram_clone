import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/core/constants.dart';
import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import '../../../../domain/use case/User/Auth/getSingleUser_usecase.dart';
import '../../../../domain/use case/User/Auth/getUserUid_usecase.dart';
import '../../../../domain/use case/User/Auth/isLogin_usecase.dart';
import '../../../../domain/use case/User/Auth/loginUser_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IsLoginUseCase isLogin;
  final LoginUserUseCase login;
  final GetSingleUserUseCase getUser;
  final GetUserUidUseCase currentUserUid;
  LoginBloc(
      {required this.currentUserUid,
      required this.isLogin,
      required this.login,
      required this.getUser})
      : super(LoginInitial()) {
    on<IsLoginEvent>((event, emit) => _appStarted(emit));
    on<LoginUser>((event, emit) => _loginUser(event, emit));
  }

  Future<void> _appStarted(
    Emitter<LoginState> emit,
  ) async {
    final bool user = await isLogin();
    if (user == true) {
      UserEntity user2 = const UserEntity();
      String uid = await currentUserUid();
      final Completer<void> completer = Completer<void>();

      getUser(uid).listen(
        (userData) {
          UserEntity user2 = userData[0];
          emit(LoginLoaded(user: user2, uid: uid));
        },
        onDone: () => completer
            .complete(), // Resolve the Completer when the stream is done
        onError: (error) {
          toast(message: error.toString());
          emit(LoginError());
          completer.complete(); // Resolve the Completer in case of an error
        },
      );

      // Wait for the Completer to complete before moving on
      await completer.future;
      emit(LoginLoaded(user: user2, uid: uid));
    }
  }

  Future<void> _loginUser(
    LoginUser event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      await login(UserEntity(
        email: event.email,
        password: event.password,
      ));
      String uid = await currentUserUid();
      UserEntity user2 = UserEntity();
      final Completer<void> completer = Completer<void>();

      getUser(uid).listen(
        (userData) {
          UserEntity user2 = userData[0];
          emit(LoginLoaded(user: user2, uid: uid));
        },
        onDone: () => completer
            .complete(), // Resolve the Completer when the stream is done
        onError: (error) {
          toast(message: error.toString());
          emit(LoginError());
          completer.complete(); // Resolve the Completer in case of an error
        },
      );

      // Wait for the Completer to complete before moving on
      await completer.future;
    } catch (e) {
      toast(message: e.toString());
      emit(LoginError());
    }
  }
}
