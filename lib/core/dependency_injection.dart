import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_clone/features/domain/use%20case/User/Auth/createUser_usecase.dart';
import 'package:instagram_clone/features/domain/use%20case/User/Auth/getSingleUser_usecase.dart';
import 'package:instagram_clone/features/domain/use%20case/User/follow_someone.dart';
import 'package:instagram_clone/features/domain/use%20case/User/get_followers_use_case.dart';
import 'package:instagram_clone/features/domain/use%20case/User/get_followings_use_case.dart';
import 'package:instagram_clone/features/domain/use%20case/User/get_single_other_user_use_case.dart';
import 'package:instagram_clone/features/domain/use%20case/firebase_storage/pick_image_usecase.dart';
import 'package:instagram_clone/features/domain/use%20case/firebase_storage/upload_image_usecase.dart';
import 'package:instagram_clone/features/domain/use%20case/post/create_post_usecase.dart';
import 'package:instagram_clone/features/domain/use%20case/post/delete_post_usecase.dart';
import 'package:instagram_clone/features/domain/use%20case/post/get_posts_usecase.dart';
import 'package:instagram_clone/features/domain/use%20case/post/like_post_usecase.dart';
import 'package:instagram_clone/features/domain/use%20case/post/update_post_usecase.dart';
import 'package:instagram_clone/features/presentation/bloc/auth/login/login_bloc.dart';
import 'package:instagram_clone/features/presentation/bloc/auth/sign_up/pick_image_cubit.dart';
import 'package:instagram_clone/features/presentation/bloc/auth/sign_up/sign_up_bloc.dart';
import 'package:instagram_clone/features/presentation/bloc/get_single_user/get_single_user_bloc.dart';
import 'package:instagram_clone/features/presentation/bloc/get_single_user_for_profile/get_single_use_for_profile_bloc.dart';
import 'package:instagram_clone/features/presentation/bloc/home/home_bloc.dart';
import 'package:instagram_clone/features/presentation/bloc/profile/pick_image_for_edit_profile_cubit.dart';
import 'package:instagram_clone/features/presentation/bloc/profile/profile_bloc.dart';
import 'package:instagram_clone/features/presentation/bloc/reply/reply_bloc.dart';
import 'package:instagram_clone/features/presentation/bloc/user_actions/follow_someone/user_actions_bloc.dart';
import '../features/data/data source/remote_data_source/auth_remote_data_source.dart';
import '../features/data/data source/remote_data_source/auth_remote_data_source_impl.dart';
import '../features/data/repo/auth_data_repository.dart';
import '../features/domain/repo/UserRepo.dart';
import '../features/domain/use case/User/Auth/getUserUid_usecase.dart';
import '../features/domain/use case/User/Auth/getUsers_usecase.dart';
import '../features/domain/use case/User/Auth/isLogin_usecase.dart';
import '../features/domain/use case/User/Auth/logOut_usecase.dart';
import '../features/domain/use case/User/Auth/loginUser_usecase.dart';
import '../features/domain/use case/User/Auth/signUp_usecase.dart';
import '../features/domain/use case/User/Auth/updateUser_usecase.dart';
import '../features/domain/use case/comment/createComment_usecase.dart';
import '../features/domain/use case/comment/deleteComment_usecase.dart';
import '../features/domain/use case/comment/getComment_usecase.dart';
import '../features/domain/use case/comment/likeComment_usecase.dart';
import '../features/domain/use case/comment/updateComment_usecase.dart';
import '../features/domain/use case/post/get_single_post.dart';
import '../features/domain/use case/reply/create_reply_usecase.dart';
import '../features/domain/use case/reply/delete_reply_usecase.dart';
import '../features/domain/use case/reply/get_replys_usecase.dart';
import '../features/domain/use case/reply/like_reply_usecase.dart';
import '../features/domain/use case/reply/update_reply_usecase.dart';
import '../features/presentation/bloc/comment/comment_bloc.dart';
import '../features/presentation/bloc/get_single_post/get_single_post_cubit.dart';
import '../features/presentation/bloc/posts/posts_bloc.dart';


GetIt sl = GetIt.instance;

Future<void> initDi () async {
  //Blocs
  sl.registerFactory(() => LoginBloc(
      currentUserUid: sl<GetUserUidUseCase>(),
      isLogin: sl<IsLoginUseCase>(),
      login: sl<LoginUserUseCase>(),
      getUser: sl<GetSingleUserUseCase>(),
  ));
  sl.registerFactory(() => SignUpBloc( signUp: sl<SignUpUseCase>()));
  sl.registerFactory(() => HomeBloc(getUsers: sl<GetUsersUseCase>()));
  sl.registerFactory(() => ProfileBloc(
      edit: sl<UpdateUserUseCase>(),
      logOut: sl<LogOutUseCase>(),
      postImage: sl<UploadImageUseCase>(),
  ));
  sl.registerFactory(() => PickImageCubit(pick: sl<PickImageUseCase>()));
  sl.registerFactory(() => PickImageForEditProfileCubit(
      pick: sl<PickImageUseCase>(),
  ));
  sl.registerFactory(() => PostsBloc(
      uploadImage: sl<UploadImageUseCase>(),
      create: sl<CreatePostUseCase>(),
      update: sl<UpdatePostUseCase>(),
      getPosts: sl<GetPostsUseCase>(),
      delete: sl<DeletePostUseCase>(),
      like: sl<LikePostUseCase>(),
  ));
  sl.registerFactory(() => CommentBloc(
      create: sl<CreateCommentUseCase>(),
      update: sl<UpdateCommentUseCase>(),
      delete: sl<DeleteCommentUseCase>(),
      get: sl<GetCommentUseCase>(),
      like: sl<LikeCommentUseCase>(),
  ));
  sl.registerFactory(() => ReplyBloc(
    create: sl<CreateReplyUseCase>(),
    update: sl<UpdateReplyUseCase>(),
    delete: sl<DeleteReplyUseCase>(),
    get: sl<GetReplyUseCase>(),
    like: sl<LikeReplyUseCase>(),
  ));
  sl.registerFactory(() => GetSinglePostCubit(
    get: sl<GetSinglePostUseCase>(),
  ));
  sl.registerFactory(() => UserActionsBloc(
    follow: sl<FollowSomeoneUseCase>(),
  ));
  sl.registerFactory(() => GetSingleUserBloc(
    getUser: sl<GetSingleUserUseCase>(),
  ));
  sl.registerFactory(() => GetSingleUseForProfileBloc(
    getUser: sl<GetSingleOtherUserUseCase>(),
  ));
  //Use Cases
  sl.registerLazySingleton(() => CreateUserUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetSingleUserUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetUsersUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetUserUidUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetFollowersUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetFollowingsUseCase(repo: sl()));
  sl.registerLazySingleton(() => IsLoginUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetSingleOtherUserUseCase(repo: sl()));
  sl.registerLazySingleton(() => LoginUserUseCase(repo: sl()));
  sl.registerLazySingleton(() => LogOutUseCase(repo: sl()));
  sl.registerLazySingleton(() => SignUpUseCase(repo: sl()));
  sl.registerLazySingleton(() => UpdateUserUseCase(repo: sl()));
  sl.registerLazySingleton(() => FollowSomeoneUseCase(repo: sl()));
  //storage
  sl.registerLazySingleton(() => PickImageUseCase(repo: sl()));
  sl.registerLazySingleton(() => UploadImageUseCase(repo: sl()));
  // post
  sl.registerLazySingleton(() => CreatePostUseCase(repo: sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetPostsUseCase(repo: sl()));
  sl.registerLazySingleton(() => LikePostUseCase(repo: sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetSinglePostUseCase(repo: sl()));
  //Comment
  sl.registerLazySingleton(() => CreateCommentUseCase(repo: sl()));
  sl.registerLazySingleton(() => DeleteCommentUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetCommentUseCase(repo: sl()));
  sl.registerLazySingleton(() => LikeCommentUseCase(repo: sl()));
  sl.registerLazySingleton(() => UpdateCommentUseCase(repo: sl()));
  // Reply
  sl.registerLazySingleton(() => CreateReplyUseCase(repo: sl()));
  sl.registerLazySingleton(() => DeleteReplyUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetReplyUseCase(repo: sl()));
  sl.registerLazySingleton(() => LikeReplyUseCase(repo: sl()));
  sl.registerLazySingleton(() => UpdateReplyUseCase(repo: sl()));
  //Repositories
  sl.registerLazySingleton<UserRepo>(() => AuthRepository(dataSource: sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
      firestore: sl(),
      firebaseAuth: sl(),
      firebaseStorage:sl(),
  ));
  //externals
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  sl.registerLazySingleton(() => firestore);
  sl.registerLazySingleton(() => storage);
  sl.registerLazySingleton(() => auth);
  //externals
}