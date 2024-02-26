

import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/domain/repo/UserRepo.dart';

class GetSingleUserUseCase {
  final UserRepo repo;
  GetSingleUserUseCase({required this.repo});

  Stream<List<UserEntity>> call (String uid) {
    return repo.getSingleUser(uid);
  }

}