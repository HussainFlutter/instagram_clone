import '../../entities/ReplyEntity.dart';
import '../../repo/UserRepo.dart';

class GetReplyUseCase {
  final UserRepo repo;

  const GetReplyUseCase({required this.repo});
  Stream<List<ReplyEntity>> call (ReplyEntity reply)  => repo.getReply(reply);
}