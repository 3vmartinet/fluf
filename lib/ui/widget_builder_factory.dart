import 'package:fluf/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class WidgetBuilderFactory {
  Widget buildLoadingState(
      {required BuildContext context, String? loadingHeadlineText}) {
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

  Widget buildEmptyState({
    required BuildContext context,
    required String header,
    required String subheader,
    required IconData icon,
    String? cta,
    Function()? callback,
  }) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(header,
                  textAlign: TextAlign.center,
                  style: context.textTheme.headlineMedium),
            ),
            Text(subheader,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium),
            if (cta != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(onPressed: callback, child: Text(cta)),
              )
          ]),
    ));
  }
}
