import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EducationModelCard extends StatelessWidget {
  final String title;
  final List<String> items;
  final Color backgroundColor;
  final Color textColor;

  const EducationModelCard({
    Key? key,
    required this.title,
    required this.items,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      margin: EdgeInsets.only(bottom: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: textColor,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(height: 8.h),
          ...items.map(
                (item) => Padding(
              padding: EdgeInsets.only(bottom: 7.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\u2022 ",
                    style: TextStyle(color: textColor, fontSize: 18.sp),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: textTheme.bodyMedium?.copyWith(
                        color: textColor,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
