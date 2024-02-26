import '../../entities/ReplyEntity.dart';
import '../../repo/UserRepo.dart';

class DeleteReplyUseCase {
  final UserRepo repo;

  const DeleteReplyUseCase({required this.repo});
  Future<void> call (ReplyEntity reply) async => repo.deleteReply(reply);
}