import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FadingScrollView extends HookWidget {
  const FadingScrollView({
    required this.child,
    this.top = true,
    this.bottom = true,
    this.gradientColor,
    this.gradientHeight = 24,
    this.threshold = 0,
    super.key,
  });

  final bool top;
  final bool bottom;
  final Color? gradientColor;
  final double gradientHeight;
  final double threshold;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final animController = useAnimationController(
      duration: const Duration(milliseconds: 50),
    );
    final animation = CurvedAnimation(
      parent: animController,
      curve: Curves.easeInOut,
    );

    useEffect(
      () {
        void scrollListener() {
          if (scrollController.offset > threshold) {
            animController.forward();
          } else {
            animController.reverse();
          }
        }

        scrollController.addListener(scrollListener);

        return () => scrollController.removeListener(scrollListener);
      },
      [],
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                if (top) ...[
                  Colors.black.withValues(alpha: 1 - animController.value),
                  Colors.black,
                ],
                if (bottom) ...[
                  Colors.black,
                  Colors.black.withValues(alpha: 1 - animController.value),
                ],
              ],
              stops: [
                if (top) ...[
                  0.0,
                  0.05,
                ],
                if (bottom) ...[
                  0.95,
                  1.0,
                ],
              ],
            ).createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            );
          },
          blendMode: BlendMode.dstIn,
          child: child,
        );
      },
      child: SingleChildScrollView(
        controller: scrollController,
        child: child,
      ),
    );
  }
}
