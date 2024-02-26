

import 'dart:io';

import 'package:instagram_clone/features/domain/repo/UserRepo.dart';

class PickImageUseCase {

  final UserRepo repo;

  const PickImageUseCase({required this.repo});

  Future<File?> call () {
    return repo.pickImage();
  }

}