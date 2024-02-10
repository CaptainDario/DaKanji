// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tuple/tuple.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/tf_lite/inference_backend.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:da_kanji_mobile/init.dart';
import 'package:da_kanji_mobile/locales_keys.dart';

/// Popup that asks the user if he wants to optimize the backends for the
/// tflite models and tells that it will take some time.
AwesomeDialog optimizeBackendsPopup(BuildContext context){
  return AwesomeDialog(
    context: context,
    headerAnimationLoop: false,
    dialogType: DialogType.noHeader,
    dismissOnTouchOutside: true,
    btnCancelColor: g_Dakanji_red,
    btnCancelText: LocaleKeys.SettingsScreen_advanced_settings_optimize_cancel.tr(),
    btnCancelOnPress: (){},
    btnOkColor: g_Dakanji_green,
    btnOkText: LocaleKeys.SettingsScreen_advanced_settings_optimize_ok.tr(),
    btnOkOnPress: () async {
      // show intermediate dialog while optimizing
      optimizingDialog(context).show();
      
      // wait a bit so the dialog can be shown
      await Future.delayed(const Duration(seconds: 1));

      final results = await optimizeTFLiteBackendsForModels();
      
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();

      // ignore: use_build_context_synchronously
      await resultsDialog(context, results).show();

    },
    body: Column(
      children: [
        Text(
          LocaleKeys.SettingsScreen_advanced_settings_optimze_warning.tr(),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

/// Dialog that is shown while the NN backends are tested
AwesomeDialog optimizingDialog(BuildContext context){
  return AwesomeDialog(
    context: context,
    headerAnimationLoop: false,
    dialogType: DialogType.noHeader,
    dismissOnTouchOutside: false,
    body: Column(
      children: [
        const SpinKitSpinningLines(
          color: g_Dakanji_green,
          lineWidth: 3,
          size: 30.0,
          itemCount: 10,
        ),
        const SizedBox(height: 20,),
        Text(
          LocaleKeys.SettingsScreen_advanced_settings_optimizing.tr()
        ),
        const SizedBox(height: 20,)
      ]
    ),
  );
}

/// Dialog that is shown after the NN backends have been tested that shows
/// the results
AwesomeDialog resultsDialog(BuildContext context, List<Tuple2<String, List<MapEntry<InferenceBackend, double>>>> results){
  return AwesomeDialog(
    context: context,
    headerAnimationLoop: false,
    dialogType: DialogType.noHeader,
    dismissOnTouchOutside: false,
    btnOkOnPress: (){},
    btnOkColor: g_Dakanji_green,
    body: LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Results", style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 16,),
              SizedBox(
                width: constraints.maxWidth-26,
                height: MediaQuery.sizeOf(context).height*0.7,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final result in results)
                        ...[
                          Text(result.item1, style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 8,),
                          
                          DataTable(
                            columns: [
                              DataColumn(label: Text("Backend")),
                              DataColumn(label: Text("Latency (ms)"))
                            ],
                            rows: [
                              for (final backendResult in result.item2.sublist(1))
                                DataRow(
                                  cells: [
                                    DataCell(Text(backendResult.key.name)),
                                    DataCell(Text(backendResult.value.toString()))
                                  ]
                                )
                            ]
                          )
                        ]
                    ]
                  ),
                ),
              ),
            ],
          ),
        );
      }
    ),
  );
}
