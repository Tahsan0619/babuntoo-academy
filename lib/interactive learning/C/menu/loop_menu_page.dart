import 'package:flutter/material.dart';
import '../loops/for_loop_page.dart';
import '../loops/while_loop_page.dart';
import '../loops/do_while_loop_page.dart';

class LoopMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      {'label': 'For Loop', 'widget': ForLoopPage()},
      {'label': 'While Loop', 'widget': WhileLoopPage()},
      {'label': 'Do-While Loop', 'widget': DoWhilePage()},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Loops Menu')),
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
