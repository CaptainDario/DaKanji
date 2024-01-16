// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:feedback_sentry/feedback_sentry.dart';

/// Opens an overlay to share feedback 
void sendFeedback(BuildContext context) {

  BetterFeedback.of(context).showAndUploadToSentry();

}
