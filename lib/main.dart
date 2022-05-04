import 'package:flutter/material.dart';

void main() {
  //runApp(const MyApp());
  runApp(
    Column(
      children: <Widget>[
        const Text(
          'Deliver features faster',
          textDirection: TextDirection.ltr,
        ),
        const Text(
          'Craft beautiful UIs',
          textDirection: TextDirection.ltr,
        ),
        const Text(
          'Craft beautiful UIs',
          textDirection: TextDirection.ltr,
        ),
        Column(
          children: const <Widget>[
            Text(
              'Deliver features faster',
              textDirection: TextDirection.ltr,
            ),
          ],
        ),
      ],
    ),
  );
}
