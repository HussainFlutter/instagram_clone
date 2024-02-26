import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/domain/entities/PostEntity.dart';

import '../../../../core/constants.dart';
import '../../../domain/use case/post/get_single_post.dart';

part 'get_single_post_state.dart';

class GetSinglePostCubit extends Cubit<GetSinglePostState> {
  final GetSinglePostUseCase get;
  GetSinglePostCubit({required this.get}) : super(GetSinglePostInitial());
  void getSinglePost (PostEntity poste) async{
    List<PostEntity> post = [];
    final Completer<void> completer = Completer<void>();
    get.call( PostEntity(id: poste.id)).listen(
          (posts) {
        post = posts;
        print(posts);
        emit(GetSinglePostLoaded(singlePost: post[0]));
      },
      onDone: () => completer.complete(),
      onError: (error) {
        toast(message: error.toString());
        completer.complete(); // Resolve the Completer in case of an error
      },
    );
    await completer.future;
    print(post);
    emit(GetSinglePostLoaded(singlePost: post[0]));
  }
}
