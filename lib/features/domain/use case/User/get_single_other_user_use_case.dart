

import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/domain/repo/UserRepo.dart';

class GetSingleOtherUserUseCase {
  final UserRepo repo;

  const GetSingleOtherUserUseCase({required this.repo});

  Stream<List<UserEntity>> call (String uid) =>repo.getSingleOtherUser(uid);

}