// Flutter imports:
import 'package:flutter/services.dart';

/// InputFormatter that replaces some characters for better compatability with
/// MeCab
class MecabTextFieldFormatter extends TextInputFormatter {


  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    
    String newText = newValue.text;

    // replace all spaces with full width spaces
    newText = newText.replaceAll(RegExp(r' '), '　');

    return newValue.copyWith(text: newText);
  }
}
