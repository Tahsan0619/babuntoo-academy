import 'package:flutter/material.dart';
import '../function/function.dart';
import '../function/array_function.dart';
import '../function/pointer_function.dart';



class FunctionsMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      {'label': 'Function', 'widget': CFunctionsPage()},
      {'label': 'Array to Function', 'widget': ArraysToFunctionsPage()},
      {'label': 'Pointer to Function', 'widget': FunctionPointerPage()},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Functions Menu')),
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
