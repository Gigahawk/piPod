import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'statusbar.dart';
import 'pipodnavigator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => MyHomePage(title: "home"),
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
        !await navigatorKey.currentState.maybePop(),
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(20.0),
            child: StatusBar(),
            ),
          body: PiPodNavigator(navigatorKey: navigatorKey)
        ),
    );
  }
}

