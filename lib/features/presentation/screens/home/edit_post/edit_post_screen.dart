import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/PostEntity.dart';
import 'package:instagram_clone/features/presentation/screens/home/edit_post/widgets/appBar.dart';
import 'package:instagram_clone/features/presentation/screens/home/edit_post/widgets/formField.dart';
import 'package:instagram_clone/features/presentation/screens/home/edit_post/widgets/image_container_for_edit_post.dart';
import 'package:instagram_clone/features/presentation/screens/home/edit_post/widgets/username%20and%20Picture.dart';
import '../../../../../core/constants.dart';
import '../../../bloc/posts/posts_bloc.dart';

class EditPostScreen extends StatefulWidget {
  final PostEntity post;
  const EditPostScreen({super.key, required this.post});

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    descriptionController.text = widget.post.description!;
  }
  @override
  void dispose() {
    super.dispose();
    descriptionController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final ImageContainerForUpdate imageContainer = ImageContainerForUpdate(image:widget.post.postImage!);
    return Scaffold(
      backgroundColor: Constants.backGroundColor,
      appBar: EditAppBar(
        onTapOfTick: (){
          if(returnImage != widget.post.postImage && descriptionController.text.isNotEmpty)
            {
              print("1");
              context.read<PostsBloc>().add(
                  UpdatePostEvent(
                    update: true,
                      context: context,
                      postEntity: PostEntity(
                    postImage: returnImage,
                    description: descriptionController.text,
                    createUid: widget.post.createUid,
                    id: widget.post.id,
                  )));
            }
          if(returnImage == widget.post.postImage && descriptionController.text.isNotEmpty)
            {
              print("2");
              context.read<PostsBloc>().add(
                  UpdatePostEvent(
                      update: false,
                      context: context,
                      postEntity: PostEntity(
                        postImage: widget.post.postImage,
                        description: descriptionController.text,
                        createUid: widget.post.createUid,
                        id: widget.post.id,
                      )));
            }
          if(returnImage != widget.post.postImage && descriptionController.text.isEmpty)
          {
            print("3");
            context.read<PostsBloc>().add(
                UpdatePostEvent(
                    update: true,
                    context: context,
                    postEntity: PostEntity(
                      postImage: returnImage,
                      description: widget.post.description,
                      createUid: widget.post.createUid,
                      id: widget.post.id,
                    )));
          }
          // if(returnImage == widget.post.postImage && descriptionController.text == "" && descriptionController.text.isEmpty){
          //   toast(message: "Post updated",toastBackGroundColor: Constants.greenColor);
          //   Navigator.pop(context);
          //   Navigator.pop(context);
          // }


        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: mediaHeight(context, 0.05),horizontal: mediaWidth(context, 0.03)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               NameAndProfile(profilePic: widget.post.profilePic,name: widget.post.username!,),
              sizeVer(mediaHeight(context, 0.01)),
              imageContainer,
              sizeVer(mediaHeight(context, 0.01)),
              Text("Write your description",style: Theme.of(context).textTheme.displayMedium),
              sizeVer(mediaHeight(context, 0.01)),
               PostEditFormField(
                controller: descriptionController,
                hintText: "Description",
              )
            ],
          ),
        ),
      ),
    );
  }

}
