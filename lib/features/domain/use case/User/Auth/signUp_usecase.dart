

import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/domain/repo/UserRepo.dart';

class SignUpUseCase {
  final UserRepo repo;
  SignUpUseCase({required this.repo});

  Future<void> call (UserEntity user) {
    return repo.signUpUser(user);
  }

}