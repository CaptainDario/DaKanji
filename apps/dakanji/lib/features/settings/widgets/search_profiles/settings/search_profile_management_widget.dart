import 'package:da_db/database/da_db.dart';
import 'package:da_db/database/search_profiles/search_profiles_entry.dart';
import 'package:da_kanji_mobile/locales_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'search_profile_settings_card_add_button.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reorderables/reorderables.dart';

class SearchProfileManagementWidget extends StatefulWidget {
  const SearchProfileManagementWidget({super.key});

  @override
  State<SearchProfileManagementWidget> createState() =>
      _SearchProfileManagementWidgetState();
}

class _SearchProfileManagementWidgetState extends State<SearchProfileManagementWidget> {

  @override
  Widget build(BuildContext context) {
    var db = GetIt.I<DaDb>();

    return StreamBuilder<List<SearchProfilesEntry>>(
      stream: db.searchProfilesDao.watchAllProfiles(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return const SizedBox.shrink();
        }

        final profiles = snapshot.data!;

        return Column(
          mainAxisSize: .min,
          children: [
            ReorderableColumn(
              scrollController: ScrollController(),
              onReorder: (oldIndex, newIndex) async {
                await db.searchProfilesDao.reorderProfiles(oldIndex, newIndex);
              },
              children: [
                for (int i = 0; i < profiles.length; i++)
                  _buildProfileCard(context, profiles[i], i)
              ],
            ),
        
            SearchProfileSearchProfileCardAddButton(
              LocaleKeys.SettingsScreenSearchProfiles_search_profiles_create_new_profile.tr(),
              onPressed: () async {
                 await db.searchProfilesDao.createNewProfile(false);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildProfileCard(BuildContext context, SearchProfilesEntry profile, int index) {
    final db = GetIt.I<DaDb>();
    final isActive = profile.isActiveProfile;

    return Card(
      key: ValueKey(profile.id),
      elevation: isActive ? 4 : 1,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isActive 
          ? BorderSide(color: Colors.grey[700]!, width: 1.25) 
          : BorderSide.none,
      ),
      child: ListTile(
        // Tap the card to switch profiles if it's not already active
        onTap: isActive ? null : () => db.searchProfilesDao.switchActiveProfile(profile.id),
        
        leading: ReorderableDragStartListener(
          index: index,
          child: const Icon(Icons.drag_handle),
        ),

        title: Text(
          profile.name,
          style: TextStyle(
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          ),
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Rename Button
            IconButton(
              icon: const Icon(Icons.edit_outlined, size: 20),
              onPressed: () => _showRenameDialog(context, profile),
              tooltip: LocaleKeys.SettingsScreenSearchProfiles_search_profiles_rename.tr(),
            ),
            
            // Selection Indicator or Delete Button
            if (isActive)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.check,),
              )
            else
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 20),
                onPressed: () => _handleDelete(context, profile, db),
                tooltip: LocaleKeys.SettingsScreenSearchProfiles_search_profiles_delete.tr(),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleDelete(BuildContext context, SearchProfilesEntry profile, DaDb db) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(LocaleKeys.SettingsScreenSearchProfiles_search_profiles_delete_profile_title.tr()),
        content: Text("${LocaleKeys.SettingsScreenSearchProfiles_search_profiles_delete_profile_body.tr()} '${profile.name}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              LocaleKeys.SettingsScreenSearchProfiles_search_profiles_cancel.tr()
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              LocaleKeys.SettingsScreenSearchProfiles_search_profiles_delete.tr(),
              style: TextStyle(color: Colors.red)
            ),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final success = await db.searchProfilesDao.deleteProfile(profile.id);
      if (!success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(LocaleKeys.SettingsScreenSearchProfiles_search_profiles_delete_last_not_possible.tr())),
        );
      }
    }
  }
  
  Future<void> _showRenameDialog(BuildContext context, SearchProfilesEntry profile) async {
    final controller = TextEditingController(text: profile.name);
    
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(LocaleKeys.SettingsScreenSearchProfiles_search_profiles_rename_profile_dialog_title.tr()),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: LocaleKeys.SettingsScreenSearchProfiles_search_profiles_rename_profile_dialog_hint_text.tr()
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(LocaleKeys.SettingsScreenSearchProfiles_search_profiles_rename_profile_dialog_title_cancel.tr()),
          ),
          TextButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                final db = GetIt.I<DaDb>();
                await db.searchProfilesDao.updateProfile(
                  profile.copyWith(name: controller.text)
                );
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: Text(LocaleKeys.SettingsScreenSearchProfiles_search_profiles_rename_profile_dialog_title_save.tr()),
          ),
        ],
      ),
    );
  }
}