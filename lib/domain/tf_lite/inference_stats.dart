// Flutter imports:
import 'package:flutter/material.dart';

/// Bundles different elapsed times
class InferenceStats with ChangeNotifier {

  /// Time taken to pre-process the image
  int? preProcessingTime;

  /// Time for which inference runs
  int? inferenceTime;

  /// Time taken to post-process the output of the tf lite interpreter
  int? postProcessingTime;

  /// The complete time used inside of the isolate (pre/postprocessing + inference)
  int? get totalIsolateTime {
    if(preProcessingTime == null || inferenceTime == null || postProcessingTime == null) {
      return null;
    }

    return preProcessingTime! + inferenceTime! + postProcessingTime!;
  }

  int? get communicationOverhead {
    if(totalIsolateTime == null || totalTime == null) {
      return null;
    }

    return totalTime! - totalIsolateTime!;
  }
    

  /// The complete time for invoking the interpreter this includes the isolate
  /// communication overhead
  int? totalTime;

  /// copies the values of the given stats object
  void copy(InferenceStats stats){
    preProcessingTime  = stats.preProcessingTime;
    inferenceTime      = stats.inferenceTime;
    postProcessingTime = stats.postProcessingTime;
    totalTime          = stats.totalTime;
    notifyListeners();
  }

}
