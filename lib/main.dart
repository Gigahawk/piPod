import 'package:flutter/material.dart';
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
        child: StatusBar()
        ),
      body: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title: FocusableText(
            index.toString(),
            autofocus: index == 0,
          ),
        ),
        itemCount: 50,
      ),
    );
  }
}

class FocusableText extends StatelessWidget {
  const FocusableText(this.data, {Key key, this.autofocus}) : super(key: key);

  final String data;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: autofocus,
      child: Builder(builder: (BuildContext context) {
        return Container(
          color: Focus.of(context).hasPrimaryFocus ? Colors.blue : null,
          child: Text(data),
        );
      }),
    );
  }
}
