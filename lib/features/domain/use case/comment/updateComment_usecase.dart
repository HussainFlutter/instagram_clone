import '../../entities/CommentEntity.dart';
import '../../repo/UserRepo.dart';

class UpdateCommentUseCase {
  final UserRepo repo;

  const UpdateCommentUseCase({required this.repo});

  Future<void> call (CommentEntity comment) => repo.updateComment(comment);
}