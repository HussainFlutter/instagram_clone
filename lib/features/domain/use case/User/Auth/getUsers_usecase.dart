

import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/domain/repo/UserRepo.dart';

class GetUsersUseCase {
  final UserRepo repo;
  GetUsersUseCase({required this.repo});

  Stream<List<UserEntity>> call () {
    return repo.getUsers();
  }

}