import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text("iPhone 12 Mini"),
          backgroundColor: Colors.blueGrey[900],
        ),
        body: Center(
          child: Image(
            image: NetworkImage(
                'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-12-gallery1-2020_FMT_WHH?wid=750&hei=778&fmt=jpeg&qlt=80&op_usm=0.5,0.5&.v=1601402683000'),
          ),
        ),
      ),
    ),
  );
}
