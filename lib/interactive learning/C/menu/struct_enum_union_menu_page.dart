import 'package:flutter/material.dart';
import '../struct,enum,union/structure.dart';
import '../struct,enum,union/enum_union.dart';


class StructEnumUnionMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      {'label': 'Struct', 'widget': CProgramStructurePage()},
      {'label': 'Enum and Union', 'widget': EnumUnionPage()},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Struct,Enum,Union Menu')),
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
