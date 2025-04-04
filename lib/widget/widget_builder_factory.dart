import 'package:fluf/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class WidgetBuilderFactory {
  static bool _uppercaseHeader = false;
  static TextStyle? _headerStyle;
  static TextStyle? _subHeaderStyle;

  static void setStyles({
    required TextStyle? headerStyle,
    required TextStyle? subHeaderStyle,
    bool uppercaseHeader = false,
  }) {
    _headerStyle = headerStyle;
    _subHeaderStyle = subHeaderStyle;
    _uppercaseHeader = uppercaseHeader;
  }

  Widget buildLoadingState({
    required BuildContext context,
    String? loadingHeadlineText,
  }) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator.adaptive(),
          ),
          if (loadingHeadlineText != null)
            Text(loadingHeadlineText, textAlign: TextAlign.center)
        ],
      ),
    ));
  }

  Widget buildInfoState({
    required BuildContext context,
    required String header,
    required String subheader,
    TextStyle? headerStyle,
    TextStyle? subHeaderStyle,
    required IconData icon,
    Color? iconColor,
    Widget? cta,
    Widget? secondaryCta,
    EdgeInsets padding = const EdgeInsets.all(24.0),
    EdgeInsets iconPadding = const EdgeInsets.all(8.0),
    EdgeInsets titlePadding = const EdgeInsets.all(8.0),
    EdgeInsets ctaPadding = const EdgeInsets.all(8.0),
    EdgeInsets secondaryCtaPadding = const EdgeInsets.all(8.0),
  }) {
    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: iconPadding,
              child: Icon(icon, color: iconColor),
            ),
            Padding(
              padding: titlePadding,
              child: FittedBox(
                child: Text(
                  _uppercaseHeader ? header.toUpperCase() : header,
                  textAlign: TextAlign.center,
                  style: headerStyle ??
                      _headerStyle ??
                      context.textTheme.headlineMedium,
                ),
              ),
            ),
            Text(
              subheader,
              textAlign: TextAlign.center,
              style: subHeaderStyle ??
                  _subHeaderStyle ??
                  context.textTheme.bodyMedium,
            ),
            if (cta != null)
              Padding(
                padding: ctaPadding,
                child: cta,
              ),
            if (secondaryCta != null)
              Padding(
                padding: secondaryCtaPadding,
                child: secondaryCta,
              ),
          ],
        ),
      ),
    );
  }
}
