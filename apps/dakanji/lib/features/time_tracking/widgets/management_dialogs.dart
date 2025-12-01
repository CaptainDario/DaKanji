import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:da_kanji_mobile/core/user/user_data_db.dart';



/// shows a bottom sheet to select, delete or add category(s).
Future showCategorySelectionBottomSheet(
  BuildContext context,
  {
    Function(String category)? onCategorySelected
  }
) async {

  _showCategoryTagBottomSheet(
    context: context,
    title: LocaleKeys.TimeTrackingScreen_select_category.tr(),
    getOptions: GetIt.I<UserDataDB>().timeTrackingDao.getAllCategories,
    getSelectedOption: GetIt.I<UserDataDB>().timeTrackingDao.getSelectedCategory,
    onAddPressed: () async {
      String? newTagName = await _showAddCategoryTagDialog(
        context,
        LocaleKeys.TimeTrackingScreen_add_category.tr(),
        LocaleKeys.TimeTrackingScreen_add_category_hint.tr(),
      );
      if (newTagName == null) return;

      await GetIt.I<UserDataDB>().timeTrackingDao.addCategory(newTagName);
    },
    onDeletePressed: (String category) async {
      await GetIt.I<UserDataDB>().timeTrackingDao.deleteCategory(category);
    },
    onOptionTapped: (String category) async {
      if(onCategorySelected != null) onCategorySelected(category);
      
    },
  );

}

/// shows a bottom sheet to select, delete or add tag(s).
Future showTagSelectionBottomSheet(
  BuildContext context,
  {
    Function(String tag)? onTagSelected
  }
) async {

  _showCategoryTagBottomSheet(
    context: context,
    title: LocaleKeys.TimeTrackingScreen_select_tag.tr(),
    getOptions: GetIt.I<UserDataDB>().timeTrackingDao.getAllTags,
    getSelectedOption: GetIt.I<UserDataDB>().timeTrackingDao.getSelectedTag,
    onAddPressed: () async {
      String? newTagName = await _showAddCategoryTagDialog(
        context,
        LocaleKeys.TimeTrackingScreen_add_tag.tr(),
        LocaleKeys.TimeTrackingScreen_add_tag_hint.tr(),
      );
      if (newTagName == null) return;

      await GetIt.I<UserDataDB>().timeTrackingDao.addTag(newTagName);
    },
    onDeletePressed: (String tag) async {
      await GetIt.I<UserDataDB>().timeTrackingDao.deleteTag(tag);
    },
    onOptionTapped: (String tag) async {
      if(onTagSelected != null) onTagSelected(tag);
    },
  );

}

/// shows a bottom sheet to select category or tag.
/// Also allows:
/// * adding new categories/tags 
/// * deleting existing categories/tags
/// 
/// Note: only for internal use, externally use
/// [showCategorySelectionBottomSheet], [showTagSelectionBottomSheet]
Future _showCategoryTagBottomSheet({
    required BuildContext context,
    required String title,
    required Future<List<String>> Function() getOptions,
    required Future<String?> Function() getSelectedOption,
    Function()? onAddPressed,
    Function(String option)? onDeletePressed,
    Function(String option)? onOptionTapped
  }) async {

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, builder) {

          return FutureBuilder<({List<String> options, String? selectedOption})>(
            future: () async {
              return (
                options: await getOptions(),
                selectedOption: await getSelectedOption(),
              );
            } (),
            builder: (context, asyncSnapshot) {

              if(!asyncSnapshot.hasData) return SizedBox();

              List<String> options = asyncSnapshot.data!.options;
              String? selectedOption = asyncSnapshot.data!.selectedOption;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          title,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(Icons.add),
                            // add new category/tag function
                            onPressed: () async {
              
                              if(onAddPressed != null) await onAddPressed();
                              
                              builder((){});
                            }
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: asyncSnapshot.data!.options.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: options[index] == selectedOption
                            ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
                            : null,
                          title: Text(options[index]),
                          trailing: IconButton(
                            icon: Icon(Icons.delete_outline),
                            // delete function
                            onPressed: () async {
                              if(onDeletePressed == null) return;
              
                              await onDeletePressed(options[index]);
              
                              builder((){});
                            }
                          ),
                          // select function
                          onTap: () async {
                            if(onOptionTapped == null) return;
                            
                            await onOptionTapped(options[index]);
              
                            builder((){});
                          }
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          );
        }
      );
    },
  );
}

/// Base function that can be used to add categories / tags.
/// 
/// Note: only for internal use, externally use
/// [showCategorySelectionBottomSheet], [showTagSelectionBottomSheet]
Future<String?> _showAddCategoryTagDialog(
    BuildContext context,
    String title,
    String hintText
  ) async {
  final TextEditingController controller = TextEditingController();

  return showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            hintText: hintText,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Return null
            child: Text(LocaleKeys.TimeTrackingScreen_cancel.tr()),
          ),
          TextButton(
            onPressed: () {
              // Return the text entered
              Navigator.pop(context, controller.text.trim());
            },
            child: Text(LocaleKeys.TimeTrackingScreen_add.tr()),
          ),
        ],
      );
    },
  );
}