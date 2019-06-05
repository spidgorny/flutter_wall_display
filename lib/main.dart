import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:xml/xml.dart';

import 'Journey.dart';
import 'JourneyTile.dart';

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
  bool loading = false;
  List<Journey> rmv = [];

  void initState() {
    super.initState();
    this.asyncInitState();
  }

  void asyncInitState() async {
    setState(() {
      loading = true;
    });
    var url =
        'https://www.rmv.de/auskunft/bin/jp/stboard.exe/dn?L=vs_anzeigetafel&cfgfile=FrankfurtM_3001969_1303738378&outputMode=xml&start=yes&output=xml&';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print('Response status: ${response.statusCode}');
//      print('Response body: ${response.body}');

      XmlDocument document = xml.parse(response.body);
      rmv = [];
      for (var j in document.findAllElements('Journey')) {
        //print(j);
        var jo = Journey.parse(j);
        rmv.add(jo);
      }
    }
    print(rmv.length);
    setState(() {
      loading = false;
    });
  }

  void _incrementCounter() {
    setState(() {});
    asyncInitState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: loading
                ? [CircularProgressIndicator()]
                : [
                    ListView(
                        shrinkWrap: true,
                        children: rmv.map((Journey node) {
                          return JourneyTile(node);
                        }).toList())
                  ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
