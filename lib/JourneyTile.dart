import 'package:flutter/material.dart';

import 'Journey.dart';

class JourneyTile extends StatelessWidget {
  final Journey model;

  JourneyTile(this.model);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Row(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Image.network(model.icon),
        ),
        Text(model.time + '+' + model.delay),
      ]),
      title: Text(model.title),
      trailing: Text(model.direction.replaceFirst('Frankfurt (Main)', '')),
    );
  }
}
