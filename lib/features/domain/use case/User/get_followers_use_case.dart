

import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/domain/repo/UserRepo.dart';

class GetFollowersUseCase {
  final UserRepo repo;

  GetFollowersUseCase({required this.repo});

  Stream<List<UserEntity>> call (String uid ) => repo.getUserFollowers(uid);


}