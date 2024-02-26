
import 'package:instagram_clone/features/domain/entities/PostEntity.dart';
import 'package:instagram_clone/features/domain/repo/UserRepo.dart';

class GetPostsUseCase {
  final UserRepo repo;

  const GetPostsUseCase({required this.repo});

  Stream<List<PostEntity>> call (PostEntity postEntity) {
    return repo.getPosts(postEntity);
  }

}