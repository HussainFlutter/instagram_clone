

import 'package:instagram_clone/features/domain/entities/ReplyEntity.dart';
import 'package:instagram_clone/features/domain/repo/UserRepo.dart';

class CreateReplyUseCase {
  final UserRepo repo;

  const CreateReplyUseCase({required this.repo});
  Future<void> call (ReplyEntity reply) async => repo.createReply(reply);
}



