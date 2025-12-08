import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'models/education_model.dart';
import 'widgets/education_model_card.dart';

class EducationModelPage extends StatelessWidget {
  final EducationModel model;

  const EducationModelPage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardColors = [
      [Colors.grey.shade400, Colors.black],
      [Colors.grey.shade400, Colors.black],
      [Colors.black, Colors.white],
      [Colors.black, Colors.white],
      [Colors.black, Colors.white],
      [Colors.black, Colors.white],
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Education Model')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 48.r,
                  backgroundColor: Colors.grey.shade500,
                  child: Icon(Icons.person, color: Colors.white, size: 60.r),
                ),
                SizedBox(height: 10.h),
                Text(
                  model.inventorName,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  model.yearPublished,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 20.h),
                ...List.generate(
                  model.sections.length,
                      (i) => Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: EducationModelCard(
                      title: model.sections[i].title,
                      items: model.sections[i].points,
                      backgroundColor: cardColors[i][0],
                      textColor: cardColors[i][1],
                    ),
                  ),
                ),
                SizedBox(height: 25.h),
                Container(
                  height: 80.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Center(
                    child: Icon(Icons.image, size: 40.sp, color: Colors.grey.shade700),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
