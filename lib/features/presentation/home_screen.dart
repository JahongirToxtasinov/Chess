import 'package:flutter/material.dart';

import '../../constants/icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Image.asset(AppIcons.mainMenu).color,
      body: Stack(
        children: [
          Image.asset(AppIcons.mainMenu,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),

        ],
      )
    );
  }
}
