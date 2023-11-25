import 'package:chess/constants/colors.dart';
import 'package:chess/constants/icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppIcons.comingSoon,width: 250,height: 250,
            ),
            const Gap(24),
            Text('This page is not ready for use.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(color: bodySmallTextColor),)
          ],
        ),
      ),
    );
  }
}
