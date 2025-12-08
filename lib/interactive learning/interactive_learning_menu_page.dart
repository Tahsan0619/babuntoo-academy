import 'package:flutter/material.dart';
import 'package:BabunToo_Academy/interactive learning/C/interactive_c_learning_menu_page.dart';


class InteractiveLearningMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {'label': 'C', 'widget': InteractiveCLearningMenuPage()},
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
