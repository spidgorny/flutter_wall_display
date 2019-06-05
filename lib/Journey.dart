import 'package:xml/xml.dart';

class Journey {
  String name;
  String category = '';
  String internalCategory = '';
  String operator = '';
  String number = '';
  String direction = '';
  String info = '';
  String externalID = '';
  String time = '';
  String delay = '';

  String get title => this.category + ' ' + this.number;

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
//    print(Dep);
    jo.time = Dep.findElements('Time').first.text;
    jo.delay = Dep.findElements('Delay').first.text;

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
      case 'EXTERNALID':
        this.externalID = val;
        break;
      default:
        print('Key ' + key + ' undefined in Journey');
    }
  }

  get icon {
    var bus = 'https://www.rmv.de/auskunft/s/n/img/monitor/products/64_pic.png';
    var tram =
        'https://www.rmv.de/auskunft/s/n/img/monitor/products/32_pic.png';
    return this.category == 'Tram' ? tram : bus;
  }
}
