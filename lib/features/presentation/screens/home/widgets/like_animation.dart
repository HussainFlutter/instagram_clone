
import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final bool isLikeAnimating;
  final VoidCallback? onLikeFinish;
  const LikeAnimation({super.key, required this.child, required this.duration, required this.isLikeAnimating, this.onLikeFinish});

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> scale;
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: widget.duration.inMilliseconds));
    scale = Tween<double>(begin: 1,end: 1.2).animate(_controller);
  }
  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    if(widget.isLikeAnimating != oldWidget.isLikeAnimating)
      {
        beginLikeAnimation();
      }
    super.didUpdateWidget(oldWidget);
  }
  beginLikeAnimation()async{
   if(widget.isLikeAnimating)
     {
       await _controller.forward();
       await _controller.reverse();
       await Future.delayed(const Duration(milliseconds: 200));
       if(widget.onLikeFinish != null)
         {
           widget.onLikeFinish!();
         }
     }
  }
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: scale,child: widget.child,);
  }
}
