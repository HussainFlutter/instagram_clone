import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/core/constants.dart';
import 'package:instagram_clone/features/domain/entities/UserEntity.dart';

import '../../../domain/use case/User/Auth/logOut_usecase.dart';
import '../../../domain/use case/User/Auth/updateUser_usecase.dart';
import '../../../domain/use case/firebase_storage/upload_image_usecase.dart';



part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateUserUseCase edit;
  final LogOutUseCase logOut;
  final UploadImageUseCase postImage;
  ProfileBloc({required this.edit,required this.logOut,required this.postImage}) : super(ProfileInitial()) {
   on<EditProfileEvent>((event, emit) => _editProfile(event, emit));
   on<LogOutEvent>((event, emit) => _logOut(event));
  }

  Future<void> _editProfile (
      EditProfileEvent event,
      Emitter<ProfileState> emit,
      ) async {
    emit(ProfileLoading());
    try {
      bool p = false;
      String image = "";
      if(event.currentProfile != event.user.profileUrl)
        {
          p = true;
          image = await postImage (File(event.user.profileUrl!),false,event.user.uid!);
        }
      UserEntity upload = UserEntity(
        uid: event.user.uid,
        username: event.user.username,
        bio: event.user.bio,
        name: event.user.name,
        website: event.user.website,
        profileUrl: p == false ? event.currentProfile : image,
      );
      print(upload);
      await edit(upload);
      emit(ProfileLoaded());
      toast(message: "Profile Edited",toastBackGroundColor: Constants.greenColor);
    }catch (e) {
      toast(message: e.toString());
      emit(ProfileError());
    }
  }

  Future<void> _logOut (
      LogOutEvent event,
      ) async {
    try{
      await logOut();
      Navigator.popUntil(event.context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(
          event.context, RouteNames.loginScreen);
    }catch(e){
      rethrow;
    }
  }

}
