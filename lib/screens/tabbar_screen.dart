import 'package:flutter/material.dart';
import 'package:andit/view_models/tabber_view_model.dart';

import 'package:andit/screens/home_screen/home_screen.dart';
import 'package:andit/screens/map_screen/map_screen.dart';
import 'package:andit/screens/test_screen/test_screen.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/color_constant.dart';

import 'dart:developer';

class TabbarScreen extends StatelessWidget {
  const TabbarScreen({Key? key}) : super(key: key);

  List<BottomNavigationBarItem> _tabbarItems(TabbarViewModel vm) {
    return vm.TabbarItems.map((e) =>
            BottomNavigationBarItem(icon: vm.tabIcon(e), label: vm.tabTitle(e)))
        .toList();
  }

  Widget _tabContainerView(TabbarItem tab) {
    switch (tab) {
      case TabbarItem.home:
        return const HomeScreen();
      case TabbarItem.map:
        return const MapScreen();
      case TabbarItem.test:
        return const TestScreen();
      default:
    }
    return Text("Test");
  }

  Widget build(BuildContext context) {
    var vm = Provider.of<TabbarViewModel>(context);
    var auth = Provider.of<ApplicationState>(context);
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: _tabContainerView(vm.selectedTabItem),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).backgroundColor,
          items: _tabbarItems(vm),
          onTap: (value) {
            var item = vm.TabbarItems[value];
            // if ((item == TabbarItem.test)) {
            //   //!auth.loggedIn) {
            //   Navigator.pushNamed(context, '/sign-in');
            //   return;
            // }
            vm.setSelectedTabIndex(value);
          },
          unselectedItemColor: ColorConstant.lightGreyColor,
          showUnselectedLabels: true,
          selectedItemColor: Theme.of(context).primaryColor,
          currentIndex: vm.homeTabIndex,
        ),
      ),
    );
  }
}
