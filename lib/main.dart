import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;
  bool loading = false;
  List<String> rmv = [];

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

      var document = xml.parse(response.body);
      rmv = [];
      for (var j in document.findAllElements('Journey')) {
        //print(j);
        var entry = '';
        var attrs = j.findAllElements('Attribute');
        for (var a in attrs) {
          var aType = a.getAttribute('type');
          //print(aType);
          for (var v in a.findAllElements('AttributeVariant')) {
            var vType = v.getAttribute('type');
            //print(vType);
            if (vType == 'NORMAL') {
              var text = v.findElements('Text');
              var text0 = text.first;
              print(aType + '=' + text0.text);
              entry += ' ' + aType + '=' + text0.text;
            }
          }
        }
        rmv.add(entry);
      }
    }
    print(rmv.length);
    setState(() {
      loading = false;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
                : rmv.map((node) {
                    return Text(node);
                  }).toList()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
