import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:dakanji_db_core/database/search_profiles/search_profiles_entry.dart';
import 'package:dakanji_db_ui/widgets/settings/search_profile_settings_card_add_button.dart';
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
    var db = GetIt.I<DaKanjiDB>();

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
              "Create New Profile", // TODO: Localization
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
    final db = GetIt.I<DaKanjiDB>();
    final theme = Theme.of(context);
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
              tooltip: "Rename",
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
                tooltip: "Delete",
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleDelete(BuildContext context, SearchProfilesEntry profile, DaKanjiDB db) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Profile?"),
        content: Text("Are you sure you want to delete '${profile.name}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final success = await db.searchProfilesDao.deleteProfile(profile.id);
      if (!success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cannot delete the only remaining profile.")),
        );
      }
    }
  }
  
  Future<void> _showRenameDialog(BuildContext context, SearchProfilesEntry profile) async {
    final controller = TextEditingController(text: profile.name);
    
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Rename Profile"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: "Profile Name"),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                final db = GetIt.I<DaKanjiDB>();
                await db.searchProfilesDao.updateProfile(
                  profile.copyWith(name: controller.text)
                );
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}