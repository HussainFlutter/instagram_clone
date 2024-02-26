

import 'package:instagram_clone/features/domain/entities/PostEntity.dart';
import 'package:instagram_clone/features/domain/repo/UserRepo.dart';

class DeletePostUseCase {
  final UserRepo repo;

  const DeletePostUseCase({required this.repo});

  Future <void> call (PostEntity postEntity) async => repo.deletePost(postEntity);

}