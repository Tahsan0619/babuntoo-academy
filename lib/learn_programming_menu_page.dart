import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'learn_c_page.dart';
import 'learn_python_page.dart';

class LearnProgrammingMenuPage extends StatelessWidget {
  const LearnProgrammingMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'icon': Icons.memory,
        'title': 'Learn C Programming',
        'subtitle': 'Master the fundamentals of C language',
        'page': LearnCPage(),
      },
      {
        'icon': Icons.code,
        'title': 'Learn Python Programming',
        'subtitle': 'Master the basics of Python language',
        'page': LearnPythonPage(),
      },
    ];

    final deviceWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = deviceWidth * 0.06;
    final cardPadding = deviceWidth * 0.06;

    return Scaffold(
      appBar: AppBar(
        title: Text('Learn Programming', style: AppTextStyles.appBar(context)),
        centerTitle: true,
        backgroundColor: AppColors.background(context),
        elevation: 0,
      ),
      backgroundColor: AppColors.background(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 18),
        child: ListView.separated(
          itemCount: items.length,
          separatorBuilder: (_, __) => SizedBox(height: cardPadding),
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 3,
              color: AppColors.background(context),
              child: ListTile(
                contentPadding: EdgeInsets.all(cardPadding),
                leading: Icon(
                  item['icon'] as IconData,
                  color: AppColors.primary(context),
                  size: 44,
                ),
                title: Text(
                  item['title'] as String,
                  style: AppTextStyles.headline(context).copyWith(
                    fontSize: deviceWidth < 400 ? 16 : 20,
                  ),
                ),
                subtitle: Text(
                  item['subtitle'] as String,
                  style: AppTextStyles.subtitle(context).copyWith(
                    fontSize: deviceWidth < 400 ? 13 : 15,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.accent(context),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => item['page'] as Widget,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
