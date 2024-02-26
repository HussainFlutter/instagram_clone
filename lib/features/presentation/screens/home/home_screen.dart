import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/presentation/bloc/posts/posts_bloc.dart';
import 'package:instagram_clone/features/presentation/screens/home/widgets/single_post_card.dart';
import 'package:instagram_clone/features/presentation/widgets/custom_appbar.dart';

import '../../../../core/constants.dart';


class HomeScreen extends StatefulWidget {
  final String uid ;
  final UserEntity currentUser;
  const HomeScreen({super.key,required this.uid,required this.currentUser});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backGroundColor,
      appBar: const CustomAppBar(
        svgOrTitle: true,
        svgPath: "assets/image_assets/instagram_logo.svg",
      ),
      body: BlocBuilder<PostsBloc,PostsState>(
        builder: (context , state){
          if(state is PostsLoading)
            {
              return const Center(child: CircularProgressIndicator());
            }
          if(state is PostsLoaded)
            {
              if(state.posts.isEmpty)
                {
                  return  Center(child: Text("No Posts To Show",style: Theme.of(context).textTheme.displayMedium,));
                }
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context,index){
                  return SinglePostCard(post: state.posts[index],currentUser: widget.currentUser,);
                },
              );
            }
          if(state is PostsError)
            {
              return  Center(child: Text("Some Error Occurred!",style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Constants.redColor),));
            }
          return  const SizedBox();
        },
      ),
    );
  }
}
