import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/UserEntity.dart';
import '../../../domain/use case/User/Auth/getUsers_usecase.dart';


part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUsersUseCase getUsers;
  HomeBloc({required this.getUsers}) : super(const HomeLoaded(usersList: [])) {
    on<GetAllUsersEvent>((event, emit) => _getAllUsers(emit));
  }
  _getAllUsers(
      Emitter<HomeState> emit,
      )async{
    //emit(HomeLoading());
    try{
      print("in");
      Completer<void> complete = Completer<void>();
      List<UserEntity> fectedUsers = [];
     final sub =  getUsers().listen((users) {
        fectedUsers = users;
        emit(HomeLoaded(usersList: fectedUsers));
        print("Emitted HomeLoaded with ${fectedUsers.length} users");
     //   print(fectedUsers);
        complete.complete();
      },
     onDone: () => complete.complete(),
      onError: (e){
        complete.complete();
        throw "Users not found";
      },
      );
     await complete.future;
      sub.cancel();
   //   print("out");
      emit(HomeLoaded(usersList: fectedUsers));
    }catch(e){
      emit(HomeError());
      rethrow;
    }
  }
}
