import 'package:instagram_clone/features/domain/repo/UserRepo.dart';

class IsLoginUseCase {
  final UserRepo repo;
  IsLoginUseCase({required this.repo});

  Future<bool> call () {
    return repo.isLogin();
  }

}