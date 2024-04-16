import 'package:flutter/material.dart';
import '../src/widgets/cat.dart';
import 'dart:math';

// ignore: use_key_in_widget_constructors
class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  late Animation<double> catAnimation;
  late AnimationController catController;
  late Animation<double> boxAnimation;
  late AnimationController boxController;

  @override
  void initState() {
    super.initState();

    boxController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
      CurvedAnimation(
        parent: boxController,
        curve: Curves.easeIn,
      ),
    );
    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });
    catController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    catAnimation = Tween(begin: -45.0, end: -150.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );
    boxController.forward();
  }

  onTap() {
    if (catController.status == AnimationStatus.completed) {
      boxController.forward();
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed) {
      boxController.stop();
      catController.forward();
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abimation'),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            // ignore: deprecated_member_use
            overflow: Overflow.visible,
            children: [
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap(),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          child: Center(child: child),
          top: catAnimation.value,
          right: 0.0,
          left: 0.0,
        );
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 3.0,
      top: 1.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,
          width: 115.0,
          color: Colors.brown,
        ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            alignment: Alignment.topLeft,
            angle: boxAnimation.value,
          );
        },
      ),
    );
  }

  Widget buildRightFlap() {
    return Positioned(
      right: 3.0,
      top: 1.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,
          width: 115.0,
          color: Colors.brown,
        ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            alignment: Alignment.topRight,
            angle: -boxAnimation.value,
          );
        },
      ),
    );
  }
}
