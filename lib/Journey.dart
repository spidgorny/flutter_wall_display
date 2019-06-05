import 'package:xml/xml.dart';

class Journey {
  String name;
  String category = 'Bus 18';
  String internalCategory;
  String operator;
  String number;
  String direction;
  String info;
  String externalID;

  static parse(XmlElement j) {
    var jo = new Journey();
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
          //print(aType + '=' + text0.text);
          jo[aType] = text0.text;
        }
      }
    }
    XmlElement MainStop = j.findElements('MainStop').first;
    XmlElement BasicStop = MainStop.findElements('BasicStop').first;
    XmlElement Dep = BasicStop.findElements('Dep').first;
    print(Dep);

    return jo;
  }

  operator []=(String key, String val) {
    switch (key) {
      case 'NAME':
        this.name = val;
        break;
      case 'CATEGORY':
        this.category = val;
        break;
      case 'INTERNALCATEGORY':
        this.internalCategory = val;
        break;
      case 'OPERATOR':
        this.operator = val;
        break;
      case 'NUMBER':
        this.number = val;
        break;
      case 'DIRECTION':
        this.direction = val;
        break;
      case 'INFO':
        this.info = val;
        break;
      case 'EXTERNALDID':
        this.externalID = val;
        break;
      default:
        print('Key ' + key + ' undefined in Journey');
    }
  }
}
