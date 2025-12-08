import 'package:flutter/material.dart';
import '../memory management/calloc_realoc_malloc_free.dart';



class MemoryManagementMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      {'label': 'Memory Functions', 'widget': MemoryAllocPage()},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Memory Management Menu')),
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
