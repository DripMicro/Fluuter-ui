import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';

class Scaffold extends StatelessWidget {
  const Scaffold({
    Key? key,
    this.header,
    this.body,
    this.footer,
    this.backgroundColor,
    this.expandBody = true,
    this.left,
  }) : super(key: key);

  final Widget? header;
  final Widget? body;
  final Widget? footer;
  final Widget? left;

  /// The background color of the scaffold.
  /// If `null`, [Style.scaffoldBackgroundColor] is used
  final Color? backgroundColor;

  /// Wheter the body expands or not
  final bool expandBody;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('backgroundColor', backgroundColor));
    properties.add(FlagProperty(
      'expandBody',
      value: expandBody,
      ifFalse: 'shrinkBody',
    ));
  }

  @override
  Widget build(BuildContext context) {
    debugCheckHasFluentTheme(context);
    final style = context.theme;
    final color =
        backgroundColor ?? style.scaffoldBackgroundColor ?? Colors.white;
    return AnimatedContainer(
      duration: style.mediumAnimationDuration ?? Duration.zero,
      curve: style.animationCurve ?? Curves.linear,
      color: color,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (this.left != null) left!,
        Expanded(
          child: Column(
            children: [
              if (header != null) header!,
              if (body != null) Expanded(child: body!),
              if (footer != null) footer!,
            ],
          ),
        ),
      ]),
    );
  }
}
