import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nftickets/presentation/screens/events_screen.dart';
import 'package:nftickets/utils/strings.dart';
import 'package:nftickets/utils/theme.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List _screens = [const EventsScreen(), Container(), Container()];
  var _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: _screens[_selectedIndex],
          bottomNavigationBar: FlashyTabBar(
            backgroundColor: theme.colorScheme.background,
            iconSize: AppSizes.kiconSize,
            showElevation: false,
            animationDuration: const Duration(milliseconds: 400),
            animationCurve: Curves.linear,
            selectedIndex: _selectedIndex,
            onItemSelected: (index) => setState(() {
              _selectedIndex = index;
            }),
            items: [
              FlashyTabBarItem(
                activeColor: theme.colorScheme.onBackground,
                icon: const Icon(
                  FontAwesomeIcons.solidCalendar,
                ),
                title: Text(
                  AppStrings.kevents,
                  style: theme.textTheme.bodyMedium!
                      .copyWith(color: theme.colorScheme.onBackground),
                ),
              ),
              FlashyTabBarItem(
                activeColor: theme.colorScheme.onBackground,
                icon: const Icon(
                  FontAwesomeIcons.landmark,
                ),
                title: Text(
                  AppStrings.kmonuments,
                  style: theme.textTheme.bodyMedium!
                      .copyWith(color: theme.colorScheme.onBackground),
                ),
              ),
              FlashyTabBarItem(
                activeColor: theme.colorScheme.onBackground,
                icon: const Icon(
                  FontAwesomeIcons.solidUser,
                ),
                title: Text(
                  AppStrings.kprofile,
                  style: theme.textTheme.bodyMedium!
                      .copyWith(color: theme.colorScheme.onBackground),
                ),
              ),
            ],
          ),
        ));
  }
}
