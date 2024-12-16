import 'package:flutter/material.dart';

class DisableSwipeBack extends StatelessWidget {
  final Widget child;

  const DisableSwipeBack({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // Prevent back navigation globally
      },
      child: child,
    );
  }
}
