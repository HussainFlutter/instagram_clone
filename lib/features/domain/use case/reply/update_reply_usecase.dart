import '../../entities/ReplyEntity.dart';
import '../../repo/UserRepo.dart';

class UpdateReplyUseCase {
  final UserRepo repo;

  const UpdateReplyUseCase({required this.repo});
  Future<void> call (ReplyEntity reply) async => repo.updateReply(reply);
}