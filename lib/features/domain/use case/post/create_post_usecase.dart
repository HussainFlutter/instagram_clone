

import 'package:instagram_clone/features/domain/entities/PostEntity.dart';
import 'package:instagram_clone/features/domain/repo/UserRepo.dart';

class CreatePostUseCase {
  final UserRepo repo;

  const CreatePostUseCase({required this.repo});

  Future <void> call (PostEntity postEntity) async => repo.createPost(postEntity);

}