import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/constants.dart';
import 'package:instagram_clone/features/domain/entities/PostEntity.dart';
import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/presentation/widgets/custom_appbar.dart';
import '../../bloc/posts/posts_bloc.dart';
import '../home/edit_post/widgets/formField.dart';
import 'widgets/image_container.dart';


class AddPostScreen extends StatefulWidget {
  final UserEntity currentUser;
  const AddPostScreen({super.key , required this.currentUser});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController descriptionController = TextEditingController();
  final ImageContainer imageContainer = ImageContainer();
  @override
  void dispose() {
    super.dispose();
    descriptionController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backGroundColor,
      appBar: CustomAppBar(
        title: "Add Post",
        actions: [
          IconButton(onPressed: (){
            if(imageContainer.image != "")
              {
                try{
                  context.read<PostsBloc>().add(CreatePostEvent(
                    context: context,
                      currentUser: widget.currentUser,
                      postEntity: PostEntity(
                        createUid: widget.currentUser.uid!,
                        description: descriptionController.text,
                        postImage: imageContainer.image,
                        profilePic: widget.currentUser.profileUrl,
                        username: widget.currentUser.username,
                        totalComments: 0,
                        totalLikes: 0,
                        likes: const [],
                      )));
                }catch(e){
                  toast(message: e.toString());
                }

              }
            else
              {
                toast(message: "Pick a image");
              }
          }, icon: const Icon(Icons.check,color: Constants.blueColor,))
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: mediaWidth(context, 0.05),vertical: mediaHeight(context, 0.01)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizeVer(mediaHeight(context, 0.08)),
            imageContainer,
           sizeVer(mediaHeight(context, 0.02)),
            Text("Write your description",style: Theme.of(context).textTheme.displayMedium),
            sizeVer(mediaHeight(context, 0.01)),
             PostEditFormField(
               controller: descriptionController,
              hintText: "Description",
            )
          ],
        ),
      ),
    );
  }
}
