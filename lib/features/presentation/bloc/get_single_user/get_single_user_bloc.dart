import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import '../../../domain/use case/User/Auth/getSingleUser_usecase.dart';

part 'get_single_user_event.dart';
part 'get_single_user_state.dart';

class GetSingleUserBloc extends Bloc<GetSingleUserEvent, GetSingleUserState> {
  final GetSingleUserUseCase getUser;
  GetSingleUserBloc({required this.getUser}) : super(GetSingleUserInitial()) {
    on<GetSingleUser>((event, emit) => _getSingleUser(event,emit));
  }
  Future<void> _getSingleUser(
      GetSingleUser event,
      Emitter<GetSingleUserState> emit,
      ) async {
    try{
      emit(GetSingleUserLoading());
      UserEntity user2 = const UserEntity();
      final Completer<void> completer = Completer<void>();
      final sub = getUser(event.targetUser.uid!).listen(
            (userData)  {
          user2 = userData[0];
          emit(GetSingleUserLoaded(targetUser: user2));
            },
        onDone: ()=>completer.complete(), // Resolve the Completer when the stream is done
        onError: (error) {
          //   toast(message: error.toString());
          completer.complete(); // Resolve the Completer in case of an error
          throw "no user found";
        },
      );
      // Wait for the Completer to complete before moving on
      await completer.future;
      sub.cancel();
      emit(GetSingleUserLoaded(targetUser: user2));

    }catch(e)
    {
     rethrow;
    }

  }
}
