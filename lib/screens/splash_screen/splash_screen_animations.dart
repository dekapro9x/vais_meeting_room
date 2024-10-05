import 'dart:async';
import 'dart:ui';

import 'package:app_base_flutter/common/dimensions.dart';
import 'package:app_base_flutter/configs/global_images.dart';
import 'package:app_base_flutter/configs/global_size_responsive_configs.dart';
import 'package:app_base_flutter/routers/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'staggered_raindrop_animation.dart';

class SplashScreenAppAnimations extends StatefulWidget {
  const SplashScreenAppAnimations({super.key});
  @override
  State<SplashScreenAppAnimations> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenAppAnimations>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late StaggeredRaindropAnimation _animation;
  Size _size = Size.zero;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    _checkFirstTime();
  }

  void _initializeAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation = StaggeredRaindropAnimation(_controller);
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('firstTime') ?? true;
    String navigationRoute = RouteGenerator.welcomeScreen;
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (firstTime) {
          prefs.setBool('firstTime', false);
        }
        _navigateToNextScreen(navigationRoute);
      },
    );
  }

  void _navigateToNextScreen(String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  @override
  void didChangeDependencies() {
    setState(() {
      _size = MediaQuery.of(context).size;
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundCircle(
              top: 0,
              left: 0,
              blurSigma: 100.0,
              color: const Color.fromRGBO(198, 84, 232, 1).withOpacity(0.72),
              radius:
                  const BorderRadius.only(bottomRight: Radius.circular(120))),
          _buildBackgroundCircle(
              bottom: 0,
              right: 0,
              blurSigma: 100.0,
              color: const Color.fromRGBO(211, 167, 221, 1).withOpacity(0.3),
              radius: const BorderRadius.only(topLeft: Radius.circular(120))),
          Positioned(
            bottom: _animation.dropPosition.value * _size.height,
            child: SizedBox(
              width: _size.width,
              child: Center(
                child: Image.asset(
                  GlobalImages.logoApp,
                  width: Dimensions.splashImg,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundCircle({
    double? top,
    double? left,
    double? bottom,
    double? right,
    required double blurSigma,
    required Color color,
    required BorderRadius radius,
  }) {
    SizeConfigResponsiveApp sizeConfigReponsive =
        SizeConfigResponsiveApp(context);
    return Positioned(
      top: top,
      left: left,
      bottom: bottom,
      right: right,
      child: Container(
        width: sizeConfigReponsive.getWidthReposive(190),
        height: sizeConfigReponsive.getWidthReposive(190),
        decoration: BoxDecoration(
          color: color,
          borderRadius: radius,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Container(
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
