

import 'package:instagram_clone/features/domain/entities/CommentEntity.dart';
import 'package:instagram_clone/features/domain/repo/UserRepo.dart';

class CreateCommentUseCase {
  final UserRepo repo;

  const CreateCommentUseCase({required this.repo});

  Future<void> call (CommentEntity comment) => repo.createComment(comment);
}









