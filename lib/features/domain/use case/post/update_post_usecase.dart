

import 'package:instagram_clone/features/domain/entities/PostEntity.dart';
import 'package:instagram_clone/features/domain/repo/UserRepo.dart';

class UpdatePostUseCase {
  final UserRepo repo;

  const UpdatePostUseCase({required this.repo});

  Future <void> call (PostEntity postEntity) async => repo.updatePost(postEntity);

}