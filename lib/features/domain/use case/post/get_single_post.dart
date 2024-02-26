
import 'package:instagram_clone/features/domain/entities/PostEntity.dart';
import 'package:instagram_clone/features/domain/repo/UserRepo.dart';

class GetSinglePostUseCase {
  final UserRepo repo;

  const GetSinglePostUseCase({required this.repo});

  Stream<List<PostEntity>> call (PostEntity postEntity) {
    return repo.getSinglePost(postEntity);
  }

}