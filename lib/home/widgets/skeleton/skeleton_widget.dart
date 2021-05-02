import 'package:flutter/material.dart';
import 'package:quiz/core/core.dart';

class Skeleton extends StatefulWidget {
  final double height;
  final double width;
  final double borderRadius;

  Skeleton({
    Key? key,
    this.height = 1000,
    this.width = 1000,
    this.borderRadius = 0,
  }) : super(key: key);

  createState() => SkeletonState();
}

class SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation gradientPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);

    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    )..addListener(() {
        setState(() {});
      });

    _controller.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        gradient: LinearGradient(
          begin: Alignment(gradientPosition.value, 0),
          end: Alignment(-1, 0),
          colors: [AppColors.border, Colors.white10, AppColors.border],
        ),
      ),
    );
  }
}
