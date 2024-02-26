

import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/domain/repo/UserRepo.dart';

class GetFollowingsUseCase {
  final UserRepo repo;

  GetFollowingsUseCase({required this.repo});

  Stream<List<UserEntity>> call (String uid ) => repo.getUserFollowings(uid);


}