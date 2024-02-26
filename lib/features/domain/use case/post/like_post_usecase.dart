

import 'package:instagram_clone/features/domain/entities/PostEntity.dart';
import 'package:instagram_clone/features/domain/repo/UserRepo.dart';

class LikePostUseCase {
  final UserRepo repo;

  const LikePostUseCase({required this.repo});

  Future <void> call (PostEntity postEntity) async => repo.likePost(postEntity);

}