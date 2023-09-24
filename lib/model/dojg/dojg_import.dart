// Package imports:
import 'package:file_picker/file_picker.dart';

void importJoDGDeck() async {
  FilePickerResult? selection =
    await FilePicker.platform.pickFiles(
      allowedExtensions: [".txt", ".apkg"],
      allowMultiple: true
    );

  // assure a valid selection
  if(selection == null) return;
  if(selection.count != 2) return;
  /*{
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Please select 2 files"),
      ),
    );
  }*/

  //setState(() {
    //jodgImported = true;
  //});
}

void parseJoDGDeck() {

}

void createJoDGIsar(){

}
