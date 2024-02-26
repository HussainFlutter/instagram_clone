import '../../entities/CommentEntity.dart';
import '../../repo/UserRepo.dart';

class DeleteCommentUseCase {
  final UserRepo repo;

  const DeleteCommentUseCase({required this.repo});

  Future<void> call (CommentEntity comment) => repo.deleteComment(comment);
}