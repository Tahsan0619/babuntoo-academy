import 'package:flutter/material.dart';
import '../string/string_basic.dart';
import '../string/string_library.dart';


class StringMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      {'label': 'String Basic', 'widget': CStringPage()},
      {'label': 'String Library', 'widget': CStringLibraryPage()},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Strings Menu')),
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
