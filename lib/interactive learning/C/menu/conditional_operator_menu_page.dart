import 'package:flutter/material.dart';
import '../conditional/if_else_page.dart';
import '../conditional/switch_page.dart' as sw;
import '../conditional/ternary_operator.dart' as te;

class ConditionalOperatorMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      {'label': 'If-Else Statement', 'widget': IfElseStatementsPage()},
      {'label': 'Switch Statement', 'widget': sw.SwitchStatementPage()},
      {'label': 'Ternary Operator', 'widget': te.SwitchStatementPage()},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Conditional Operators')),
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
