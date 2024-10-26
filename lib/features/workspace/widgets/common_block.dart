import 'package:flutter/material.dart';

class CommonBlock extends StatelessWidget {
  final Color? color;
  final Widget? child;

  const CommonBlock({
    super.key,
    this.color,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
