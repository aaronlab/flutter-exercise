import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: 30.0,
              color: Colors.white,
              child: Text('Hello'),
            ),
            SizedBox(
              width: 30.0,
            ),
            Container(
              width: 30.0,
              color: Colors.red,
              child: Text(
                'Hello',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              width: 30.0,
              color: Colors.orange,
              child: Text(
                'Hello',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
