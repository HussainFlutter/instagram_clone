import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/constants.dart';
import '../../../../domain/use case/firebase_storage/pick_image_usecase.dart';

part 'pick_image_state.dart';

class PickImageCubit extends Cubit<PickImageState> {
  final PickImageUseCase pick;
  PickImageCubit({required this.pick}) : super(PickImageInitial());
  void pickAndUploadImage () async {
    try{
      emit(PickImageLoading());
      final pickedImage = await pick();
      emit(PickImageLoaded(image: pickedImage!.path));
    }catch(e)
    {
      toast(message: e.toString());
    }
  }
}
