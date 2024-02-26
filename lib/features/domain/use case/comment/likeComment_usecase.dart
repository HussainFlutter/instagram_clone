import '../../entities/CommentEntity.dart';
import '../../repo/UserRepo.dart';

class LikeCommentUseCase {
  final UserRepo repo;

  const LikeCommentUseCase({required this.repo});

  Future<void> call (CommentEntity comment) => repo.likeComment(comment);
}