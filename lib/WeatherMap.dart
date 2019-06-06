import 'package:flutter/material.dart';

class WeatherMap extends StatelessWidget {
  static const int yStart = 19;
  static const int xStart = 30;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      GridView.builder(
          itemCount: 8 * 8,
          gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
          itemBuilder: (BuildContext context, int index) {
            var zoom = 6;
            var x = xStart + index % 8;
            var y = yStart + (index / 8).floor();
            return GridTile(child: new MapTile(zoom: zoom, x: x, y: y));
          }),
      Opacity(
          opacity: 0.5,
          child: GridView.builder(
              itemCount: 8 * 8,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8),
              itemBuilder: (BuildContext context, int index) {
                var zoom = 6;
                var x = xStart + index % 8;
                var y = yStart + (index / 8).floor();
                return GridTile(child: new WeatherTile(zoom: zoom, x: x, y: y));
              })),
    ]);
  }
}

class MapTile extends StatelessWidget {
  int zoom;
  int x;
  int y;

  MapTile({
    Key key,
    this.zoom,
    this.x,
    this.y,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var baseUrl =
        'https://cartodb-basemaps-c.global.ssl.fastly.net/light_all/6';
    var tileUrl = "$baseUrl/$x/$y.png";
    return Image.network(tileUrl);
  }
}

class WeatherTile extends MapTile {
  static const appid = 'f06510a5a302b510a3673a98275b071b';

  WeatherTile({
    Key key,
    zoom,
    x,
    y,
  }) : super(key: key, zoom: zoom, x: x, y: y);

  @override
  Widget build(BuildContext context) {
    var baseUrl = 'http://tile.openweathermap.org/map/precipitation_new/6';
    var tileUrl = "$baseUrl/$x/$y.png?appid=$appid";
    return Image.network(tileUrl);
  }
}
