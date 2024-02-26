import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instagram_clone/features/domain/use%20case/firebase_storage/pick_image_usecase.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/dependency_injection.dart';
import '../../../../domain/repo/UserRepo.dart';

class ImageContainer extends StatefulWidget {
   String image;
   ImageContainer({super.key,this.image = "",});
  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Container(
          color: widget.image != "" ? Colors.transparent : Constants.darkGreyColor,
          height: mediaHeight(context, 0.3),
          width: double.infinity,
          child:  widget.image != "" ? Image.file(File(widget.image),) : const SizedBox(),
        ),
        Positioned(
            right: 0,
            child: IconButton(
              onPressed: () async {
                File? pickedImage = await PickImageUseCase(repo: sl<UserRepo>()).call();
                if(pickedImage != null)
                  {
                    setState(() {
                      widget.image = pickedImage.path;
                    });
                  }
              },
              icon: CircleAvatar(radius: mediaHeight(context, 0.025),backgroundColor: Constants.primaryColor,child: const Icon(Icons.edit,color: Constants.blueColor,)),)
        ),
      ],
    );
  }
}
