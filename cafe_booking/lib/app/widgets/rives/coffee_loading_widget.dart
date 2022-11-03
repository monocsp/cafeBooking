import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class CoffeeLoading extends StatefulWidget {
  const CoffeeLoading({Key? key}) : super(key: key);

  @override
  _CoffeeLoadingState createState() => _CoffeeLoadingState();
}

class _CoffeeLoadingState extends State<CoffeeLoading> {
  // Controller for playback
  late RiveAnimationController _controller;

  // // Toggles between play and pause animation states
  // void _togglePlay() => setState(() => _controller.isActive = !_controller.isActive);

  /// Tracks if the animation is playing by whether controller is running
  bool get isPlaying => _controller.isActive;
  List<String> controllerNameList = [];

  @override
  void initState() {
    super.initState();
    // int randNumber = Random().nextInt(3);
    _controller = SimpleAnimation('CUP');
  }

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      'assets/rives/cup_walk.riv',
      controllers: [_controller],
      // Update the play state when the widget's initialized
      onInit: (_) => setState(() {}),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
