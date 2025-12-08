import 'package:flutter/material.dart';
import '../operators/arithmetic_operators_page.dart';
import '../operators/bitwise_operators_page.dart';
import '../operators/logical_operators_page.dart';
import '../operators/relational_operators_page.dart';

class OperatorsMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      {'label': 'Arithmetic Operators', 'widget': ArithmeticOperatorsPage()},
      {'label': 'Bitwise Operators', 'widget': BitwiseOperatorsPage()},
      {'label': 'Logical Operators', 'widget': LogicalOperatorsPage()},
      {'label': 'Relational Operators', 'widget': RelationalOperatorsPage()},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Operators Menu')),
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
