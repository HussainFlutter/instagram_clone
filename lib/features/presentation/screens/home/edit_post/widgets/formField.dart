import 'package:flutter/material.dart';

import '../../../../../../core/constants.dart';

class PostEditFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const PostEditFormField({super.key,required this.hintText,required this.controller});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(
        color: Constants.primaryColor
      ),
      maxLines: null,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Constants.primaryColor
          )
      ),
    );
  }
}
