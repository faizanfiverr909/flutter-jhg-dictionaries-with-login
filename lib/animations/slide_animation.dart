import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlideAnimation extends StatefulWidget {
  final Widget? mainWidget;

  final VoidCallback? onCmplt;

  const SlideAnimation({super.key, this.mainWidget, this.onCmplt});

  @override
  State<SlideAnimation> createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation>
    with TickerProviderStateMixin {
  late AnimationController _mainWidgetAc;

  void animationTimer() {
    _mainWidgetAc.forward();
  }

  @override
  void initState() {
    super.initState();
    _mainWidgetAc = AnimationController(
      duration: const Duration(seconds: 5),
      reverseDuration: const Duration(seconds: 2),
      vsync: this,
    );

    animationTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mainWidgetAc.reverse();
    _mainWidgetAc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 5),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              reverseCurve: Curves.elasticInOut,
              parent: _mainWidgetAc,
              curve: Curves.elasticInOut,
            ),
          ),
          child: widget.mainWidget,
        ),
      ],
    );
  }
}
