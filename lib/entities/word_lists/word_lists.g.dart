// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_lists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordLists _$WordListsFromJson(Map<String, dynamic> json) => WordLists()
  ..userCreatedLists = (json['userCreatedLists'] as List<dynamic>)
      .map((e) => TreeNode<WordListsData>.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$WordListsToJson(WordLists instance) => <String, dynamic>{
      'userCreatedLists':
          instance.userCreatedLists.map((e) => e.toJson()).toList(),
    };
