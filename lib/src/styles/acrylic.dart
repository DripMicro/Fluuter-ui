import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';

class Acrylic extends StatelessWidget {
  const Acrylic({
    Key? key,
    this.color,
    this.decoration,
    this.filter,
    this.child,
    this.opacity = 0.8,
    this.width,
    this.height,
    this.padding,
    this.margin,
  }) : super(key: key);

  final Color? color;
  final Decoration? decoration;

  final double opacity;
  final ImageFilter? filter;

  final Widget? child;

  final double? width;
  final double? height;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    debugCheckHasFluentTheme(context);
    final color = (this.color ?? context.theme!.navigationPanelBackgroundColor);
    return AnimatedContainer(
      duration: context.theme!.fastAnimationDuration ?? Duration.zero,
      curve: context.theme!.animationCurve ?? standartCurve,
      padding: margin ?? EdgeInsets.zero,
      width: width,
      height: height,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
          child: AnimatedContainer(
            padding: padding,
            duration: context.theme!.fastAnimationDuration ?? Duration.zero,
            curve: context.theme!.animationCurve ?? standartCurve,
            decoration: decoration ??
                BoxDecoration(
                  color: color?.withOpacity(opacity),
                ),
            child: child,
          ),
        ),
      ),
    );
  }
}
