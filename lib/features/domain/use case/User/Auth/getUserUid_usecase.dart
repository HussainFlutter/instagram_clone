

import 'package:instagram_clone/features/domain/repo/UserRepo.dart';

class GetUserUidUseCase {
  final UserRepo repo;
  GetUserUidUseCase({required this.repo});

  Future<String> call () {
    return repo.getUserUid();
  }

}