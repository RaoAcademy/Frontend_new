import 'package:flutter/material.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';

class ContainerWithBorder extends StatelessWidget {
  const ContainerWithBorder({
    Key? key,
    this.borderWidth,
    this.borderColor,
    this.borderRadius,
    this.boxColor,
    this.shadowBlurRadius,
    this.shadowColor,
    this.offsetDx,
    this.offsetDy,
    this.margin,
    this.padding,
    this.alignment,
    this.child,
    this.height,
    this.width,
    this.decoration,
    this.boxShadow,
    this.borderR,
    this.freeWidth = false,
    this.constraints,
  }) : super(key: key);

  final num? height;
  final num? width;
  final num? borderWidth;
  final Color? borderColor;
  final num? borderRadius;
  final Color? boxColor;
  final num? shadowBlurRadius;
  final Color? shadowColor;
  final num? offsetDx;
  final num? offsetDy;
  final Widget? child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Alignment? alignment;
  final BoxDecoration? decoration;
  final List<BoxShadow>? boxShadow;
  final BorderRadius? borderR;
  final bool freeWidth;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints,
      height: height?.toDouble(),
      width: width?.toDouble() ??
          (freeWidth ? null : MediaQuery.of(context).size.width),
      margin: margin ?? EdgeInsets.zero,
      padding: padding ?? EdgeInsets.zero,
      alignment: alignment ?? Alignment.center,
      decoration: decoration ??
          BoxDecoration(
            color: boxColor ?? LoopsColors.colorWhite,
            border: Border.all(
                width: borderWidth?.toDouble() ?? 0,
                color: borderColor ?? Colors.transparent),
            borderRadius: borderR ??
                BorderRadius.all(
                  Radius.circular(borderRadius?.toDouble() ?? 0),
                ),
            boxShadow: boxShadow ??
                [
                  BoxShadow(
                    blurRadius: shadowBlurRadius?.toDouble() ?? 0,
                    color: shadowColor ?? Colors.transparent,
                    offset: Offset(
                        offsetDx?.toDouble() ?? 0, offsetDy?.toDouble() ?? 0),
                  )
                ],
          ),
      child: freeWidth
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: child,
            )
          : child ?? Container(),
    );
  }
}
