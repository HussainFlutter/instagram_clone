

import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/domain/repo/UserRepo.dart';

class FollowSomeoneUseCase {
  final UserRepo repo;

  const FollowSomeoneUseCase({required this.repo});
  Future<void> call (UserEntity targetUser,UserEntity currentUser) async => repo.followUser(targetUser, currentUser);

}