

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/PostEntity.dart';
import 'package:instagram_clone/features/presentation/bloc/posts/posts_bloc.dart';

import '../../../../../../core/constants.dart';
import '../../../../widgets/custom_appbar.dart';

class EditAppBar extends StatelessWidget implements PreferredSize{
  final VoidCallback onTapOfTick;
  const EditAppBar({super.key,required this.onTapOfTick});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      leading: IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: const Icon(Icons.close,color: Constants.primaryColor,),
      ),
      actions: [
        IconButton(
          onPressed: onTapOfTick,
          icon: const Icon(Icons.done,color: Constants.blueColor,),
        ),
      ],
      title: "",
    );
  }
  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
