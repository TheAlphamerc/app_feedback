import 'package:flutter/material.dart';
// part of '../feedback_sheet.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      this.onPressed,
      this.label,
      this.isLoading,
      this.color,
      this.labelStyle,
      this.isWraped = false,
      this.isColored = true,
      this.buttonStyle,
      this.padding = const EdgeInsets.symmetric(horizontal: 40, vertical: 12)})
      : super(key: key);
  final Function? onPressed;
  final String? label;
  final TextStyle? labelStyle;
  final ValueNotifier<bool>? isLoading;
  final bool isWraped;
  final bool isColored;
  final Color? color;
  final EdgeInsetsGeometry padding;
  final ButtonStyle? buttonStyle;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: isWraped ? null : double.infinity,
      child: ValueListenableBuilder<bool>(
        valueListenable: isLoading ?? ValueNotifier(false),
        builder: (context, loading, child) {
          return TextButton(
            style: buttonStyle ??
                ButtonStyle(
                    padding: MaterialStateProperty.all(padding),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      !isColored
                          ? null
                          : color ?? Theme.of(context).primaryColor,
                    ),
                    foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.onPrimary,
                    )),
            onPressed: loading ? null : onPressed as void Function()?,
            child: loading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: FittedBox(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            color ?? Theme.of(context).primaryColor),
                      ),
                    ),
                  )
                : child!,
          );
        },
        child: Text(label!, style: labelStyle),
      ),
    );
  }
}
