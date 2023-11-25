import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants/colors.dart';
import '../../constants/icons.dart';
import '../../constants/routes.dart';
import '../widgets/w_scale.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController pageController;

  int page = 0;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WScale(
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.home),
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'SKIP',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.625,
            child: PageView(
              onPageChanged: (index) {
                setState(() {
                  page = index;
                });
              },
              controller: pageController,
              children: [
                Column(
                  children: [
                    Expanded(
                        child: Image.asset(
                          AppIcons.time,
                        ),

                    ),
                    const Gap(60),
                    Text(
                      'Effective use of free time.',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const Gap(6),
                    Text(
                      'Making good use of your time and doing mental exercises.',
                      style: Theme.of(context).textTheme.displaySmall,
                    )
                  ],
                ),
                Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        AppIcons.world_player,
                      ),

                    ),
                    const Gap(60),
                    Text(
                      'From all sides of the world.',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const Gap(6),
                    Text(
                      'The possibility to play with any player.',
                      style: Theme.of(context).textTheme.displaySmall,
                    )
                  ],
                ),
                Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        AppIcons.friends,
                      ),

                    ),
                    const Gap(60),
                    Text(
                      'Friends from various countries.',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const Gap(6),
                    Text(
                      'The ability to make friends from any country.',
                      style: Theme.of(context).textTheme.displaySmall,
                    )
                  ],
                ),
                Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        AppIcons.kings,
                      ),

                    ),
                    const Gap(60),
                    Text(
                      'Kings of Chess',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const Gap(6),
                    Text(
                      'Play,Be a winner and be the Best player of the world',
                      style: Theme.of(context).textTheme.displaySmall,
                    )
                  ],
                ),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (page != 0)
                  WScale(
                    onTap: () {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SvgPicture.asset(AppIcons.next),
                    ),
                  )
                else
                  const Gap(44),
                SmoothPageIndicator(
                  controller: pageController,
                  count: 4,
                  effect: ExpandingDotsEffect(
                    activeDotColor: blue,
                    dotWidth: 8,
                    dotHeight: 8,
                    dotColor: blue.withOpacity(.32),
                    expansionFactor: 3,
                    spacing: 4,
                  ),
                ),
                WScale(
                  onTap: () {
                    if (page == 3) {
                      Navigator.of(context)
                          .pushReplacementNamed(AppRoutes.home);
                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SvgPicture.asset(AppIcons.next),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
