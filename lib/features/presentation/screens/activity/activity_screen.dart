import 'package:flutter/material.dart';
import 'package:instagram_clone/features/presentation/widgets/custom_appbar.dart';

import '../../../../core/constants.dart';


class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Constants.backGroundColor,
      appBar: CustomAppBar(
        title: "Activity",
      ),
    );
  }
}
