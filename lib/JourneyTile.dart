import 'package:flutter/material.dart';

import 'Journey.dart';

class JourneyTile extends StatelessWidget {
  final Journey model;

  JourneyTile(this.model);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('img'),
      title: Text(model.name),
    );
  }
}
