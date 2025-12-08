import 'package:flutter/material.dart';
import '../pointer/pointer.dart';
import '../pointer/pointer_pointer.dart';



class PointerMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      {'label': 'Pointer', 'widget': PointerPage()},
      {'label': 'Pointer to Pointer', 'widget': PointerToPointerPage()},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Pointer Menu')),
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
