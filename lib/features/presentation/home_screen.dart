import 'package:chess/core/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../constants/icons.dart';
import '../../constants/routes.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Image.asset(AppIcons.mainMenu).color,
      body: Stack(
        children: [
          Image.asset(AppIcons.mainMenu3,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppIcons.mainWidget,
              width: MediaQuery.of(context).size.width,
              ),
              const Gap(10),
              MainButton(
                  destination: AppRoutes.comingSoon,
                  text: "VS CPU"
              ),
              const Gap(12),
              MainButton(
                  destination: AppRoutes.comingSoon,
                  text: "TWO PLAYER"
              ),
              const Gap(12),
              MainButton(
                  destination: AppRoutes.comingSoon,
                  text: "LOCAL"
              ),
              const Gap(12),
              MainButton(
                  destination: AppRoutes.comingSoon,
                  text: "WITH FRIENDS"
              ),
              const Gap(12),
              MainButton(
                  destination: AppRoutes.comingSoon,
                  text: "ONLINE"
              ),

            ],
          ),

        ],
      )
    );
  }
}
