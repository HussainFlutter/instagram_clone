

import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/domain/repo/UserRepo.dart';

class LoginUserUseCase {
  final UserRepo repo;
  LoginUserUseCase({required this.repo});

  Future<void> call (UserEntity user) {
    return repo.loginUser(user);
  }

}