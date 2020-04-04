import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'statusbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double _width = 0;
  double _height = 0;
  final navigatorKey = GlobalKey<NavigatorState>();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _getWindowSize() {
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height = MediaQuery.of(context).size.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0),
        child: StatusBar(),
        ),
      body: Navigator(
        initialRoute: 'menu',
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          builder = (BuildContext context) => PiPodListView();
          return CupertinoPageRoute(builder: builder, settings: settings);
        }
      ),
    );
  }
}

class PiPodListView extends StatelessWidget {
  const PiPodListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemExtent: 20.0,
      itemBuilder: (context, index) => FocusableText(
          index.toString(),
          autofocus: index == 0,
      ),
      itemCount: 10,
    );
  }

}

class FocusableText extends StatelessWidget {
  const FocusableText(this.data, {Key key, this.autofocus}) : super(key: key);

  final String data;
  final bool autofocus;

  bool _onKeyPressed(FocusNode node, RawKeyEvent event, BuildContext context) {
    if (event is RawKeyDownEvent) {
      // print("Got button press");
      // print(event.toString());
      if(event.logicalKey == LogicalKeyboardKey.enter) {
        print("$data selected");
        Navigator.of(context)
          .pushReplacementNamed('menu');
        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.escape) {
        print("Escaping");
        Navigator.of(context).popAndPushNamed('menu');
        return true;
      }
      return false;
    }
    return false;
  }

  bool _onFocusChanged(bool gotFocus) {
    // if(gotFocus)
    //   print("$data got focus");
    // else
    //   print("$data lost focus");
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onKey: (node, event) => _onKeyPressed(node, event, context),
      onFocusChange: _onFocusChanged,
      autofocus: autofocus,
      child: Builder(builder: (BuildContext context) {
        final FocusNode focusNode = Focus.of(context);
        final bool hasFocus = focusNode.hasFocus;
        return GestureDetector(
          child: Container(
            color: hasFocus ? Colors.blue : null,
            child: Text(data),
          ),
        );
      }),
    );
  }
}
