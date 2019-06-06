import 'package:flutter/material.dart';

import 'VGFPlan.dart';
import 'WeatherMap.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var title = 'Wall Display';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: title),
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
  void initState() {
    super.initState();
    this.asyncInitState();
  }

  void asyncInitState() async {}

  void _incrementCounter() {
    setState(() {});
    asyncInitState();
  }

  @override
  Widget build(BuildContext context) {
    double wHeight = MediaQuery.of(context).size.height;

    var appBar = AppBar(
      title: Text(widget.title),
    );
    double abHeight = appBar.preferredSize.height;
    double height = wHeight - abHeight;

    return Scaffold(
      appBar: appBar,
      body: Column(children: [
        Container(height: 0.45 * height, child: WeatherMap()),
        Container(height: 0.45 * height, child: VGFPlan()),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
