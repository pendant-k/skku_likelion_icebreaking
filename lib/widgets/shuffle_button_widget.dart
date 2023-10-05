import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:likelion_2023_question_shuffle/constants.dart';

class ShuffleButtonWidget extends StatelessWidget {
  const ShuffleButtonWidget({
    super.key,
    required this.isFinish,
    required this.onTap,
  });

  final bool isFinish;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: Constants.mainColor,
      borderRadius: BorderRadius.circular(isFinish ? 30 : 10),
      child: InkWell(
        splashColor: Colors.white.withOpacity(0.3),
        onTap: onTap,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            isFinish ? '처음으로' : '질문 뽑기',
            style: TextStyle(
              fontFamily: "Dunggen",
              fontSize: 20.spMin,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
