import 'package:app_base_flutter/configs/global_images.dart';
import 'package:app_base_flutter/configs/global_size_responsive_configs.dart';
import 'package:app_base_flutter/screens/splash_screen/splash_screen_animations.dart';
import 'package:flutter/material.dart';

import 'hole_painter.dart';
import 'staggered_raindrop_animation.dart';

class SplashScreenLogoApp extends StatefulWidget {
  const SplashScreenLogoApp({Key? key}) : super(key: key);

  @override
  State<SplashScreenLogoApp> createState() => _SplashScreenLogoAppState();
}

class _SplashScreenLogoAppState extends State<SplashScreenLogoApp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late StaggeredRaindropAnimation _animation;
  late Size _size;

  @override
  void initState() {
    super.initState();
    _initializeAnimationController();
    _startAnimation();
  }

  void _initializeAnimationController() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _animation = StaggeredRaindropAnimation(_controller);
  }

  void _startAnimation() {
    _controller.forward().whenComplete(_navigateToNextScreen);
    _controller.addListener(() {
      setState(() {});
    });
  }

  void _navigateToNextScreen() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SplashScreenAppAnimations(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation.drive(
              Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.ease)),
            ),
            child: child,
          );
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _size = MediaQuery.of(context).size;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeConfigResponsive = SizeConfigResponsiveApp(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: HolePainter(
              color: const Color.fromRGBO(145, 23, 183, 1),
              holeSize: _animation.holeSize.value * _size.width,
            ),
          ),
          Center(
            child: Container(
              width: sizeConfigResponsive.getWidthReposive(320),
              height: sizeConfigResponsive.getWidthReposive(320),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  sizeConfigResponsive.getWidthReposive(80),
                ),
                image: const DecorationImage(
                  image: AssetImage(GlobalImages.logoApp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
