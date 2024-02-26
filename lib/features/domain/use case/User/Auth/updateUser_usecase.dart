


import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/domain/repo/UserRepo.dart';

class UpdateUserUseCase {
  final UserRepo repo;
  UpdateUserUseCase({required this.repo});

  Future<void> call (UserEntity user) {
    return repo.updateUser(user);
  }

}