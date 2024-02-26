import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/UserEntity.dart';
import '../../../domain/use case/User/get_single_other_user_use_case.dart';

part 'get_single_use_for_profile_event.dart';
part 'get_single_use_for_profile_state.dart';

class GetSingleUseForProfileBloc extends Bloc<GetSingleUseForProfileEvent, GetSingleUseForProfileState> {
  final GetSingleOtherUserUseCase getUser;
  GetSingleUseForProfileBloc({required this.getUser}) : super(GetSingleUseForProfileInitial()) {
    on<GetSingleUserForProfileEvent>((event, emit) => _getSingleUser(event, emit));
  }
  Future<void> _getSingleUser(
      GetSingleUserForProfileEvent event,
      Emitter<GetSingleUseForProfileState> emit,
      ) async {
    try{
      emit(GetSingleUseForProfileLoading());
      UserEntity user2 = const UserEntity();
      final Completer<void> completer = Completer<void>();
      final sub = getUser(event.uid).listen(
            (userData)  {
          user2 = userData[0];
          emit(GetSingleUseForProfileLoaded(targetUser: user2));
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
      emit(GetSingleUseForProfileLoaded(targetUser: user2));

    }catch(e)
    {
      rethrow;
    }

  }
}
