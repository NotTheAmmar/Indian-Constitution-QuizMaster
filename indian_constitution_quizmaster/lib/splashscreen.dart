import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void didChangeDependencies() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 400, end: 300).animate(_controller)
      ..addListener(() => setState(() {}));

    _controller.repeat(reverse: true);

    super.didChangeDependencies();

    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context).pushReplacementNamed('/homePage'),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Column(
        children: [
          Expanded(
            child: Image.asset(
              'assets/icons/logo.png',
              width: _animation.value,
              height: _animation.value,
            ),
          ),
          Divider(
            color: Theme.of(context).colorScheme.secondary,
            height: 10,
            indent: 10,
            endIndent: 10,
            thickness: 0.625,
          ),
          Text(
            "Created By Ammar Rangwala",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
