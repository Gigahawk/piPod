import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piPod/menus/pipodmainmenu.dart';

class PiPodNavigator extends StatelessWidget {
  PiPodNavigator({this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  PageRoute _onGenerateRoute(RouteSettings settings) {
    WidgetBuilder builder;
    print("Routing to ${settings.name}");

    switch(settings.name) {
      case 'menu':
        builder = (BuildContext context) => PiPodMainMenu();
        break;
      default:
        throw Exception('Invalid route ${settings.name}');
    }

    return CupertinoPageRoute(builder: builder, settings: settings);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: 'menu',
      onGenerateRoute: _onGenerateRoute,);
  }
}