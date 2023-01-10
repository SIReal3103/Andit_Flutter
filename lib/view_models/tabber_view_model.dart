import 'package:flutter/material.dart';
import 'dart:async';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum TabbarItem { home, map, test }

class TabbarViewModel extends ChangeNotifier {
  TabbarItem selectedTabItem = TabbarItem.home;
  int homeTabIndex = 0;
  Timer? configTimer;
  List<TabbarItem> TabbarItems = [
    TabbarItem.home,
    TabbarItem.map,
    TabbarItem.test,
  ];

  setSelectedTabItem(TabbarItem item) {
    selectedTabItem = item;
    notifyListeners();
  }

  setSelectedTabIndex(int index) {
    homeTabIndex = index;
    var item = TabbarItems[index];
    setSelectedTabItem(item);
    notifyListeners();
  }

  int getSelectedTabItem() {
    var index = TabbarItems.indexOf(selectedTabItem);
    return index;
  }

  String tabTitle(TabbarItem item) {
    switch (item) {
      case TabbarItem.home:
        return "Home";
      case TabbarItem.map:
        return "Map";
      case TabbarItem.test:
        return "Login";
      default:
    }
    return "";
  }

  Icon tabIcon(TabbarItem item) {
    switch (item) {
      case TabbarItem.home:
        return Icon(Icons.home);
      case TabbarItem.map:
        return Icon(FontAwesomeIcons.map);
      case TabbarItem.test:
        return Icon(FontAwesomeIcons.lockOpen);
      default:
    }
    return Icon(Icons.home);
  }
}
