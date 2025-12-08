import 'package:flutter/material.dart';
import '../problem_solving_part1/problem1_page.dart';
import '../problem_solving_part1/problem2_page.dart';
import '../problem_solving_part1/problem3_page.dart';
import '../problem_solving_part1/problem4_page.dart';
import '../problem_solving_part1/problem5_page.dart';
import '../problem_solving_part1/problem6_page.dart';
import '../problem_solving_part1/problem7_page.dart';

class Problem1MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      {'label': 'Print First 10 Natural Numbers', 'widget': Problem1NaturalNumbersPage()},
      {'label': 'Sum of First 10 Natural Numbers', 'widget': SumFirstTenPage()},
      {'label': 'Print All Even Numbers (1-100)', 'widget': Problem3EvenNumbersPage()},
      {'label': 'Factorial Calculation', 'widget': Problem4FactorialPage()},
      {'label': 'Day Name by Number (1–7)', 'widget': Problem5DayNamePage()},
      {'label': 'Even or Odd', 'widget': ProblemSixEvenOddPage()},
      {'label': 'Largest of Two Numbers', 'widget': Problem7LargestAnimationPage()},
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Problem Solving Practice')),
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
