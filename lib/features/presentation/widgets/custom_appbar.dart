import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize{
  final String? title;
  final String? svgPath;
  final bool svgOrTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final bool goBack;
  const CustomAppBar({
    super.key,
    this.title,
    this.svgPath,
    this.svgOrTitle = false,
    this.actions,
    this.leading,
    this.goBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Constants.primaryColor
      ),
      backgroundColor: Constants.backGroundColor,
      automaticallyImplyLeading: goBack,
      leading: leading,
      title: svgOrTitle == true ? SvgPicture.asset(svgPath!,height: mediaHeight(context, 0.06)) : Text(title!,style: const TextStyle(color:Constants.primaryColor),),
      actions: actions,
    );
  }
  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
