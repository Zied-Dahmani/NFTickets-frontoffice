import 'package:flutter/material.dart';
import 'package:nftickets/data/repositories/auth_repository.dart';
import 'package:nftickets/utils/theme.dart';
import '../router/routes.dart';
import '../views/slide.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;

  void nextPage(progressValue) {
    progressValue != 100
        ? _pageController.nextPage(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInQuad)
        : Navigator.of(context).pushNamed(AppRoutes.signInScreen);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: PageView(controller: _pageController, children: [
        Slide(
            image: 'assets/microphone-recording.gif',
            fullDescription: AppStrings.konBoardingScreenDescription1,
            progressValue: 0,
            function: () => nextPage(0)),
        Slide(
            image: 'assets/microphone-recording.gif',
            fullDescription: AppStrings.konBoardingScreenDescription2,
            progressValue: 50,
            function: () => nextPage(50)),
        Slide(
            image: 'assets/microphone-recording.gif',
            fullDescription: AppStrings.konBoardingScreenDescription3,
            progressValue: 100,
            function: () => nextPage(100)),
      ]),
    );
  }
}
