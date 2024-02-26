import '../../entities/CommentEntity.dart';
import '../../repo/UserRepo.dart';

class GetCommentUseCase {
  final UserRepo repo;

  const GetCommentUseCase({required this.repo});

  Stream<List<CommentEntity>> call (CommentEntity comment) => repo.getComment(comment);
}