import 'package:flutter/material.dart';
import '../basics/char_and_format_specifiers_page.dart';
import '../basics/int_and_float_page.dart';
import '../basics/printf_and_scanf_page.dart';
import '../basics/syntax_of_c_page.dart';
import '../basics/variable_page.dart';


class BasicMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      {'label': 'Syntax', 'widget': SyntaxOfCPage()},
      {'label': 'Variables', 'widget': VariableJourneyPage()},
      {'label': 'Printf and Scanf', 'widget': PrintfAndScanfPage()},
      {'label': 'int and float', 'widget': IntAndFloatPage()},
      {'label': 'char and format specifier', 'widget': CharAndFormatSpecifierPage()},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Basic Menu')),
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
