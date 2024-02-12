// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_lists_tree.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordListsTree _$WordListsTreeFromJson(Map<String, dynamic> json) =>
    WordListsTree()
      ..userCreatedLists = (json['userCreatedLists'] as List<dynamic>)
          .map((e) =>
              TreeNode<WordListsData>.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$WordListsTreeToJson(WordListsTree instance) =>
    <String, dynamic>{
      'userCreatedLists':
          instance.userCreatedLists.map((e) => e.toJson()).toList(),
    };
