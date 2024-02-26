
import '../../entities/ReplyEntity.dart';
import '../../repo/UserRepo.dart';

class LikeReplyUseCase {
  final UserRepo repo;

  const LikeReplyUseCase({required this.repo});
  Future<void> call (ReplyEntity reply) async => repo.likeReply(reply);
}