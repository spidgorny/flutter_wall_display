import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:xml/xml.dart' as xml;

import 'Journey.dart';
import 'JourneyTile.dart';

class VGFPlan extends StatefulWidget {
  const VGFPlan({
    Key key,
  }) : super(key: key);

  @override
  _VGFPlanState createState() => _VGFPlanState();
}

class _VGFPlanState extends State<VGFPlan> {
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

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : ListView(
            shrinkWrap: true,
            children: rmv.map((Journey node) {
              return JourneyTile(node);
            }).toList());
  }
}
