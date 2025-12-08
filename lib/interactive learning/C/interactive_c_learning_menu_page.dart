import 'package:flutter/material.dart';
import 'menu/loop_menu_page.dart';
import 'menu/operators_menu_page.dart';
import 'menu/conditional_operator_menu_page.dart';
import 'menu/problem1_menu_page.dart';
import 'menu/basic_menu_page.dart';
import 'menu/array_menu_page.dart';
import 'menu/string_menu_page.dart';
import 'menu/struct_enum_union_menu_page.dart';
import 'menu/file_io_menu_page.dart';
import 'menu/functions_menu_page.dart';
import 'menu/recursion_menu_page.dart';
import 'menu/pointer_menu_page.dart';
import 'menu/memory_management_menu_page.dart';

class InteractiveCLearningMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {'label': 'Basic', 'widget': BasicMenuPage()},
      {'label': 'Loops', 'widget': LoopMenuPage()},
      {'label': 'Operators', 'widget': OperatorsMenuPage()},
      {'label': 'Conditional Operators', 'widget': ConditionalOperatorMenuPage()},
      {'label': 'Array', 'widget': ArrayMenuPage()},
      {'label': 'String', 'widget': StringMenuPage()},
      {'label': 'Function', 'widget': FunctionsMenuPage()},
      {'label': 'Recursion', 'widget': RecursionMenuPage()},
      {'label': 'Pointer', 'widget': PointerMenuPage()},
      {'label': 'Struct,enum,union', 'widget': StructEnumUnionMenuPage()},
      {'label': 'Memory Management', 'widget': MemoryManagementMenuPage()},
      {'label': 'File I/O', 'widget': FileIoMenuPage()},
      {'label': 'Problem Solving Practice', 'widget': Problem1MenuPage()},

    ];

    return Scaffold(
      appBar: AppBar(title: Text('Interactive Learning')),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 18),
        children: [
          ...menuItems.map((item) => Card(
            margin: EdgeInsets.symmetric(vertical: 12),
            child: ListTile(
              title: Text(
                item['label'] as String,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
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
