import 'package:flutter/material.dart';
import '../array/2D_array.dart';
import '../array/3D_array.dart';


class ArrayMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      {'label': '2D Array', 'widget': TwoDArrayPage()},
      {'label': '3D Array', 'widget': ThreeDArrayPage()},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Arrays Menu')),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 18),
        children: [
          ...items.map((item) => Card(
            margin: EdgeInsets.symmetric(vertical: 9),
            child: ListTile(
              title: Text(item['label'] as String, style: TextStyle(fontSize: 16)),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => item['widget'] as Widget,
              )),
            ),
          )),
        ],
      ),
    );
  }
}
