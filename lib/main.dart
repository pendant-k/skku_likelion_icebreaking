import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:likelion_2023_question_shuffle/constants.dart';
import './questions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, _) {
        return MaterialApp(
          title: '2023 SKKU 멋사 아이스브레이킹 프로그램',
          theme: ThemeData(primaryColor: Constants.mainColor),
          debugShowCheckedModeBanner: false,
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // check is on progress or not
  List<String> localQuestions = [...questions];
  bool _isInit = true;
  // check is finished
  // bool _isFinish = false;
  int _pickNum = 0;

  // Change current question
  void _changeQuestion() {
    setState(() {
      if (localQuestions.length > 1) {
        _pickNum = Random().nextInt(localQuestions.length - 1);
      }
    });
  }

  void _shuffle() {
    // 시작하지 않았다면?
    if (_isInit) {
      setState(() {
        _isInit = false;
      });
      return;
    }
    // 끝났다면?
    if (localQuestions.isEmpty) {
      setState(() {
        _isInit = true;
        localQuestions = [...questions];
      });
      return;
    }
    // 질문을 뽑는다면?
    localQuestions.removeAt(_pickNum);
    _changeQuestion();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesk = MediaQuery.of(context).size.width > 520;
    // check is desktop or Mobile

    return Scaffold(
      backgroundColor: const Color(0xFF2B6652),
      // floating button 가운데 정렬
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: Center(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          constraints: const BoxConstraints(maxWidth: 512),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: isDesk ? 20 : 20.h,
                ),
                const MainTitleWidget(),
                SizedBox(height: isDesk ? 130 : 130.w),
                Image.asset(
                  "assets/character.png",
                  width: isDesk ? 150 : 110.w,
                  height: isDesk ? 150 : 110.w,
                ),
                SizedBox(
                  height: isDesk ? 20 : 20.w,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    height: isDesk ? 200 : 200.w,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 3,
                            color: Constants.mainColor.withAlpha(200)),
                        borderRadius: BorderRadius.circular(30)),
                    child: _isInit
                        ? AnimatedTextKit(
                            key: UniqueKey(),
                            totalRepeatCount: 1,
                            animatedTexts: [
                              TypewriterAnimatedText(
                                '질문을 뽑아 봅시다!',
                                speed: const Duration(milliseconds: 50),
                                textStyle: TextStyle(
                                  fontFamily: "Dunggen",
                                  fontSize: isDesk ? 25 : 25.spMin,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        : AnimatedTextKit(
                            key: UniqueKey(),
                            totalRepeatCount: 1,
                            animatedTexts: [
                              TypewriterAnimatedText(
                                localQuestions.isEmpty
                                    ? "와우! 모든 질문을 뽑았어요"
                                    : localQuestions[_pickNum],
                                speed: const Duration(milliseconds: 50),
                                textStyle: TextStyle(
                                  fontFamily: "Dunggen",
                                  fontSize: isDesk ? 25 : 25.spMin,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                SizedBox(
                  height: isDesk ? 40 : 40.w,
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: double.infinity,
                  height: isDesk ? 50 : 50.w,
                  padding: EdgeInsets.symmetric(
                    horizontal: questions.isEmpty ? 40 : 20,
                  ),
                  child: ShuffleButtonWidget(
                    isFinish: localQuestions.isEmpty,
                    onTap: _shuffle,
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
