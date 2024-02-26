import 'package:flutter/material.dart';

import '../../../../../../core/constants.dart';

class NameAndProfile extends StatelessWidget {
  final String name;
  final String? profilePic;
  const NameAndProfile({super.key,required this.name,this.profilePic});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: mediaHeight(context, 0.05),
            backgroundColor: Constants.darkGreyColor,
            backgroundImage: NetworkImage(profilePic!),
          ),
          sizeVer(mediaHeight(context, 0.01)),
          Text(name,style: Theme.of(context).textTheme.displayLarge),
        ],
      ),
    );
  }
}
