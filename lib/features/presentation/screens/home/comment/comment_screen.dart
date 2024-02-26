import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/CommentEntity.dart';
import 'package:instagram_clone/features/domain/entities/PostEntity.dart';
import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/presentation/screens/home/comment/widgets/single_comment.dart';
import 'package:instagram_clone/features/presentation/widgets/custom_appbar.dart';

import '../../../../../core/constants.dart';
import '../../../bloc/comment/comment_bloc.dart';


class CommentScreen extends StatefulWidget {
  final UserEntity currentUser;
  final PostEntity postEntity;
  const CommentScreen({super.key,required this.postEntity,required this.currentUser});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController descriptionController  = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    descriptionController.dispose();
  }
  @override
  void initState() {
    super.initState();
    context.read<CommentBloc>().add(GetCommentsEvent(comment: CommentEntity(postId: widget.postEntity.id)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backGroundColor,
      appBar: CustomAppBar(
        leading: IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back,color: Constants.primaryColor,)),
        title: "Comment",
      ),
      body: BlocBuilder<CommentBloc,CommentState>(
        builder: (context,state){
          if(state is CommentLoading)
          {
            return const Center(child: CircularProgressIndicator(),);
          }
          if(state is CommentLoaded)
            {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: mediaWidth(context, 0.03),vertical: mediaHeight(context, 0.02)),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: mediaHeight(context, 0.03),
                                backgroundImage: NetworkImage(widget.postEntity.profilePic!),
                              ),
                              sizeHor(mediaWidth(context, 0.02)),
                              Text(widget.postEntity.username!,style: Theme.of(context).textTheme.displayMedium,),
                            ],
                          ),
                          sizeVer(mediaHeight(context, 0.02)),
                          Text(widget.postEntity.description!,style: Theme.of(context).textTheme.displaySmall,),
                          const Divider(
                            color: Constants.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: mediaWidth(context, 0.03)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: state.commentList.length,
                                itemBuilder: (context,index){
                                  return SingleComment(comment: state.commentList[index],currentUser: widget.currentUser,post: widget.postEntity,);
                                }
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _commentSection(),
                ],
              );
            }
          if(state is CommentError)
            {
              return const Center(child: Text("Error occurred"));
            }
          else
            {
              return const SizedBox();
            }
        },
      )
    );
  }
  _commentSection () {
    return Container(
      height: mediaHeight(context, 0.07),
      width: double.infinity,
      color: Constants.darkGreyColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: mediaHeight(context, 0.027),
          ),
          sizeHor(mediaWidth(context, 0.02)),
          Expanded(
            child: TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: "Post your Comment...",
                hintStyle: TextStyle(
                    color: Colors.grey
                ),
              ),
            ),
          ),
          TextButton(
              onPressed: (){
                createReply();
              },
              child: Text("Post",style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Constants.blueColor,fontSize: mediaHeight(context, 0.023)),),
          ),
        ],
      ),
    );
  }
  createReply(){
    if(descriptionController.text != ""  && descriptionController.text.isNotEmpty)
      {
        context.read<CommentBloc>().add(CreateCommentEvent(
            comment: CommentEntity(
              description: descriptionController.text.toString(),
              username: widget.currentUser.username,
              createrUid: widget.currentUser.uid,
              userProfileUrl: widget.currentUser.profileUrl,
              postId: widget.postEntity.id,
            ),
        ));
        descriptionController.clear();
      }
  }
}
