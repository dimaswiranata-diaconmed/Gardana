import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:gardana/helpers/translation/app_translations.dart';

/// Custom round-edged long button
class LongButton extends StatelessWidget {
  final Color color;
  final Widget child;
  final Function onPressed;

  /// Default to targetWidth * 0.9
  final double buttonWidth;
  final TextStyle textStyle;
  final Decoration decoration;
  final BorderRadius borderRadius;
  LongButton(
      {this.color,
      this.child,
      this.onPressed,
      this.buttonWidth,
      this.textStyle,
      this.decoration,
      this.borderRadius,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.9;
    double width = targetWidth * 0.9;
    Widget btnChild = child;

    if (btnChild is Text) {
      Text text = btnChild;
      btnChild = Text(text.data,
          style: textStyle ?? Theme.of(context).primaryTextTheme.button);
    }

    return Container(
        decoration: decoration ?? null,
        width: buttonWidth ?? width,
        child: CupertinoButton(
          disabledColor: color ?? Theme.of(context).buttonColor,
          pressedOpacity: 1.0,
          borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(8.0)),
          padding: EdgeInsets.all(10.0),
          color: color ?? Theme.of(context).buttonColor,
          child: btnChild,
          onPressed: onPressed,
        ));
  }
}

/// Custom round-edged compact button
class LeanButton extends StatelessWidget {
  final Color color;
  final Widget child;
  final Function onPressed;

  /// Default to targetWidth * 0.9
  final double buttonWidth;
  final TextStyle textStyle;
  final Decoration decoration;

  /// Default to horizontal 10.0
  final EdgeInsets buttonPadding;
  LeanButton(
      {this.color,
      this.child,
      this.onPressed,
      this.buttonWidth,
      this.textStyle,
      this.decoration,
      Key key,
      this.buttonPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.9;
    double width = targetWidth * 0.9;
    Widget btnChild = child;

    if (btnChild is Text) {
      Text text = btnChild;
      btnChild = Text(text.data,
          textAlign: text.textAlign,
          style: textStyle ?? Theme.of(context).primaryTextTheme.button);
    }

    return Container(
      width: buttonWidth ?? width,
      decoration: decoration ??
          BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: color ?? Theme.of(context).buttonColor,
          ),
      child: FlatButton(
        padding: buttonPadding ?? EdgeInsets.symmetric(horizontal: 10.0),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: btnChild,
        onPressed: onPressed,
      ),
    );
  }
}

/// Custom round-edged delete button with default red background and white text
class DeleteButton extends StatelessWidget {
  /// Default to deviceWidth * 0.9
  final double buttonWidth;
  final Color color;

  /// Delete function
  final Function onPressed;
  DeleteButton({this.buttonWidth, this.color, this.onPressed});
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    double targetWidth = deviceWidth * 0.9;
    return LongButton(
      buttonWidth: buttonWidth ?? targetWidth,
      color: color ?? Theme.of(context).backgroundColor,
      textStyle: Theme.of(context)
          .primaryTextTheme
          .button
          .copyWith(color: Theme.of(context).errorColor),
      child: Text(AppTranslations.of(context).text('delete')),
      onPressed: onPressed,
    );
  }
}
