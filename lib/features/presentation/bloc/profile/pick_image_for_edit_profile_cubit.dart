import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants.dart';
import '../../../domain/use case/firebase_storage/pick_image_usecase.dart';

part 'pick_image_for_edit_profile_state.dart';

class PickImageForEditProfileCubit extends Cubit<PickImageForEditProfileState> {
  final PickImageUseCase pick;
  PickImageForEditProfileCubit({required this.pick}) : super(PickImageForEditProfileInitial());
  void pickAndUploadImage () async {
    try{
      emit(PickImageForEditProfileLoading());
      final pickedImage = await pick();
      emit(PickImageForEditProfileLoaded(image: pickedImage!.path));
    }catch(e)
    {
      toast(message: e.toString());
    }
  }
}
