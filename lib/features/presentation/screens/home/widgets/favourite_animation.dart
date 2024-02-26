import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/UserEntity.dart';

import '../../../../domain/entities/PostEntity.dart';
import '../../../bloc/posts/posts_bloc.dart';

class FavIconAnimation extends StatefulWidget {
  final PostEntity post;
  final UserEntity currentUser;
  const FavIconAnimation({
    super.key,
    required this.post,
    required this.currentUser ,
  });

  @override
  State<FavIconAnimation> createState() => _FavIconAnimationState();
}

class _FavIconAnimationState extends State<FavIconAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    animation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(tween: Tween(begin: 40, end: 28), weight: 50),
      TweenSequenceItem<double>(tween: Tween(begin: 52, end: 40), weight: 50),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            height: 40,
            width: 50,
            child: IconButton(
                onPressed: () {
                   widget.post.likes!.contains(widget.currentUser.uid) ? _controller.reverse() : _controller.forward();
                  context.read<PostsBloc>().add(LikePostEvent(
                      postEntity: PostEntity(id: widget.post.id)));
                  setState(() {

                  });
                },
                icon:  !widget.post.likes!.contains(widget.currentUser.uid) ? Icon(Icons.favorite_border,size: animation.value,) : Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: animation.value,
                )),
          );
        });
  }
}
