

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constants.dart';
import '../../../../../../core/dependency_injection.dart';
import '../../../../../domain/repo/UserRepo.dart';
import '../../../../../domain/use case/firebase_storage/pick_image_usecase.dart';

class ImageContainerForUpdate extends StatefulWidget {
   String image;
   ImageContainerForUpdate({super.key, this.image = "",});
  @override
  State<ImageContainerForUpdate> createState() => ImageContainerUpdateState();
}

String returnImage = "";

class ImageContainerUpdateState extends State<ImageContainerForUpdate> {
  bool edited = false;
  // String returnImage = "";
  late final String defaultImage;
  @override
  void initState() {
    super.initState();
    defaultImage = widget.image;
    returnImage = widget.image;
  }
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Container(
          color: returnImage != "" ? Colors.transparent : Constants.darkGreyColor,
          height: mediaHeight(context, 0.3),
          width: double.infinity,
          child:  edited == false ? Image.network(returnImage) : Image.file(File(returnImage)),
        ),
        Positioned(
            right: 0,
            child: IconButton(
              onPressed: () async {
                File? pickedImage = await PickImageUseCase(repo: sl<UserRepo>()).call();
                if(pickedImage != null)
                {
                  setState(() {
                    edited = true;
                    widget.image = pickedImage.path;
                    returnImage = pickedImage.path;
                  });
                }
                else
                  {
                    setState(() {
                      edited = false;
                      widget.image = defaultImage;
                      returnImage = defaultImage;
                    });
                  }
              },
              icon: CircleAvatar(radius: mediaHeight(context, 0.025),backgroundColor: Constants.primaryColor,child: const Icon(Icons.edit,color: Constants.blueColor,)),)
        ),
      ],
    );
  }

}

