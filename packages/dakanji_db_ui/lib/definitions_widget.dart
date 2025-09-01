import 'package:dakanji_db_ui/ui.dart';
import 'package:flutter/material.dart';



/// Widget that can render the list of definitons of a yomitan dictionary entry
class DefinitionsWidget extends StatefulWidget {

  final List<dynamic> definitions;
  /// The absolute path to the directory where the dictionary archive was unzipped.
  /// This is used to load images referenced in the content.
  final String imageAssetBasePath;

  const DefinitionsWidget(
    {
      super.key,
      required this.definitions,
      required this.imageAssetBasePath
    }
  );

  @override
  State<DefinitionsWidget> createState() => _DefinitionsWidgetState();
}

class _DefinitionsWidgetState extends State<DefinitionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.definitions.map((def) {
        return Card(
          child: DefinitionItemWidget(
            content: def,
            imageAssetBasePath: widget.imageAssetBasePath
          ),
        );
      }).toList(),
    );
  }
}