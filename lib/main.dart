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
  bool _isInit = true;
  bool _isFinish = false;
  int _pickNum = 5;

  void _changeQuestion() {
    setState(() {
      if (questions.length > 1) {
        _pickNum = Random().nextInt(questions.length - 1);
      } else {
        _isFinish = true;
      }
    });
  }

  void _shuffle() {
    // 시작하지 않았다면?
    if (_isInit) {
      setState(() {
        _isInit = false;
      });
      _changeQuestion();
    } else {
      questions.removeAt(_pickNum);
      _changeQuestion();
    }
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
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 512),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: isDesk ? 30 : 30.w,
                ),
                Text(
                  '멋사 질문 생성기',
                  style: TextStyle(
                    color: Colors.black,
                    backgroundColor: Constants.mainColor.withOpacity(0.7),
                    fontFamily: 'Aggro',
                    fontWeight: FontWeight.w500,
                    fontSize: 40.spMin,
                  ),
                ),
                SizedBox(height: isDesk ? 130 : 130.w),
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
                                _isFinish
                                    ? "와우! 모든 질문을 뽑았어요"
                                    : questions[_pickNum],
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
                const SizedBox(height: 50),
                Image.asset(
                  "assets/character.png",
                  width: isDesk ? 150 : 110.w,
                  height: isDesk ? 150 : 110.w,
                ),
                SizedBox(
                  height: isDesk ? 300 : 300.w,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: isDesk ? 20 : 20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '버튼을 눌러 질문을 뽑아주세요!',
                style: TextStyle(
                  fontFamily: "Dunggen",
                  fontSize: 13.spMin,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              SizedBox(height: isDesk ? 5 : 5.w),
              FloatingActionButton(
                elevation: 3,
                backgroundColor: Constants.mainColor,
                onPressed: _shuffle,
                child: const Icon(Icons.rocket_launch_outlined),
              ),
            ],
          )), //
    );
  }
}
