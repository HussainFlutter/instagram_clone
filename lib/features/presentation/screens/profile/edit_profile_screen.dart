import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/constants.dart';
import 'package:instagram_clone/features/domain/entities/UserEntity.dart';
import 'package:instagram_clone/features/presentation/bloc/profile/pick_image_for_edit_profile_cubit.dart';
import 'package:instagram_clone/features/presentation/bloc/profile/profile_bloc.dart';
import 'package:instagram_clone/features/presentation/widgets/custom_appbar.dart';
import 'package:instagram_clone/features/presentation/widgets/custom_text_form_field.dart';

class EditProfileScreen extends StatefulWidget {
  final UserEntity currentUser;
  const EditProfileScreen({super.key,required this.currentUser});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  String? image;
  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    websiteController.dispose();
    bioController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    nameController.text = widget.currentUser.name ?? "";
    usernameController.text = widget.currentUser.username ?? "";
    websiteController.text = widget.currentUser.website ?? "";
    bioController.text = widget.currentUser.bio ?? "";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.cancel,
              color: Constants.primaryColor,
              size: mediaHeight(context, 0.04),
            )),
        title: "Edit Profile",
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: BlocListener<ProfileBloc, ProfileState>(
  listener: (context, state) {
    if(state is ProfileLoaded)
      {
        Navigator.pop(context);
      }
  },
  child: IconButton(
                onPressed: () {
                  context.read<ProfileBloc>().add(EditProfileEvent(user: edit(),currentProfile: widget.currentUser.profileUrl!));
                },
                icon: Icon(
                  Icons.check_circle,
                  color: Constants.blueColor,
                  size: mediaHeight(context, 0.04),
                )),
),
          ),
        ],
      ),
      backgroundColor: Constants.backGroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: mediaWidth(context, 0.07),
              vertical: mediaHeight(context, 0.05)),
          child: Column(
            children: [
              Column(
                children: [
                  BlocBuilder<PickImageForEditProfileCubit,
                      PickImageForEditProfileState>(
                    builder: (context, state) {
                      if(state is PickImageForEditProfileLoaded)
                        {
                          image = state.image;
                          return CircleAvatar(
                            radius: mediaHeight(context, 0.04),
                            backgroundColor: Constants.darkGreyColor,
                            backgroundImage: FileImage(File(state.image)),
                          );
                        }
                      if(state is PickImageForEditProfileLoading)
                      {
                        return CircleAvatar(
                          radius: mediaHeight(context, 0.04),
                          backgroundColor: Constants.darkGreyColor,
                          child: const CircularProgressIndicator(color: Constants.blueColor,),
                        );
                      }
                      else
                        {
                          return CircleAvatar(
                            radius: mediaHeight(context, 0.04),
                            backgroundColor: Constants.darkGreyColor,
                            backgroundImage: NetworkImage(widget.currentUser.profileUrl!),
                          );
                        }
                    },
                  ),
                  TextButton(
                      onPressed: () {
                        context
                            .read<PickImageForEditProfileCubit>()
                            .pickAndUploadImage();
                      },
                      child: Text(
                        "Change Profile Picture",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: Constants.blueColor),
                      ))
                ],
              ),
              sizeVer(mediaHeight(context, 0.02)),
               CustomTextFormField(
                controller: nameController,
                hintText: "Name",
              ),
              sizeVer(mediaHeight(context, 0.01)),
               CustomTextFormField(
                 controller: usernameController,
                hintText: "Username",
              ),
              sizeVer(mediaHeight(context, 0.02)),
               CustomTextFormField(
                 controller: websiteController,
                hintText: "Website",
              ),
              sizeVer(mediaHeight(context, 0.02)),
               CustomTextFormField(
                 controller: bioController,
                hintText: "Bio",
              ),
            ],
          ),
        ),
      ),
    );
  }
  UserEntity edit() {
    return UserEntity(
      uid: widget.currentUser.uid,
      username: usernameController.text,
      bio: bioController.text,
      website: websiteController.text,
      profileUrl: image ?? widget.currentUser.profileUrl,
      name: nameController.text,
    );
  }
}
