

import 'package:instagram_clone/features/domain/repo/UserRepo.dart';

class LogOutUseCase {
  final UserRepo repo;
  LogOutUseCase({required this.repo});

  Future<void> call () {
    return repo.logOut();
  }

}