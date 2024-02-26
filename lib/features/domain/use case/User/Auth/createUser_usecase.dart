


import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/domain/repo/UserRepo.dart';

class CreateUserUseCase {
  final UserRepo repo;
  const CreateUserUseCase({required this.repo});

  Future<void> call (UserEntity user) {
    return repo.createUser(user);
  }

}