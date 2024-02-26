

import 'dart:io';

import 'package:instagram_clone/features/domain/repo/UserRepo.dart';

class UploadImageUseCase {

  final UserRepo repo;

  const UploadImageUseCase({required this.repo});

  Future<String> call (File image, bool isPost, String uid) {
    return repo.postImageToStorage( image,  isPost,  uid);
  }

}