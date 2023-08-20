import 'dart:convert';



/// Anki status codes and messages
class AnkiStatus {

  /// Status code; -1 if error, 0 if success
  /// null if not initialized
  int? code;
  /// Detailed error explanation
  Map? message;

  AnkiStatus(String message)
    {
      Map m = jsonDecode(message);
      if(m["error"] != "null"){
        code = -1;
      }
    }

}