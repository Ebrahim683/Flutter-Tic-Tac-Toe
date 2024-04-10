import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tic_tac_toe/pages/board/game_board_page.dart';
import 'dart:math' show pi;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  void goToGameboard() async {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const GameBoardPage(),
          ));
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _animation =
        Tween<double>(begin: 0.0, end: pi * 2).animate(_animationController!);
    _animationController!.repeat();
    goToGameboard();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: AnimatedBuilder(
                animation: _animation!,
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateZ(_animation!.value),
                    child: Image.asset(
                      'assets/logo/logo.png',
                      height: 150,
                      width: 150,
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
