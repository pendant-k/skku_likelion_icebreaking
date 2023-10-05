import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:likelion_2023_question_shuffle/constants.dart';

class MainTitleWidget extends StatelessWidget {
  const MainTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '멋사 질문 생성기',
      style: TextStyle(
        color: Colors.black,
        backgroundColor: Constants.mainColor.withOpacity(0.7),
        fontFamily: 'Aggro',
        fontWeight: FontWeight.w500,
        fontSize: 40.spMin,
      ),
    );
  }
}
