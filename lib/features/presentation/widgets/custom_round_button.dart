import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/constants.dart';

class CustomRoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  const CustomRoundButton({
    super.key,
  required this.title,
  required this.onTap,
    this.loading = false,
  });
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        onPressed: onTap,
        child: Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Constants.blueColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: loading == true ? const Center(child: CircularProgressIndicator(color: Constants.primaryColor,),) :  Center(child: Text(title,style: const TextStyle(color: Constants.primaryColor),)),
        ),
    );
  }
}
