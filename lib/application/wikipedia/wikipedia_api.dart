// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:http/http.dart';

/// Queries the wikipedia API and returns the definition of the `topic`.
/// Returns the summary of the topic if it exists, otherwise an empty string.
/// Uses the given locale to query the wikipedia API.
Future<String> getWikipediaDefinition(String topic, String locale) async {

  String url = "https://$locale.wikipedia.org/w/api.php?action=query&rvprop=content&prop=extracts&format=json&exintro=&titles=$topic";
  Response response;

  try{
    response = await get(Uri.parse(url));
  }
  catch (e) {
    print(e);
    return "";
  }

  if(response.statusCode == 200){
    Map<String, dynamic> json = jsonDecode(response.body);
    String? extract = json["query"]["pages"].values.first["extract"];
    if(extract != null){
      return extract;
    }
  }

  return "";

}
