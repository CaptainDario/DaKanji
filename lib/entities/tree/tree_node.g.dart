// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreeNode<T> _$TreeNodeFromJson<T>(Map<String, dynamic> json) => TreeNode<T>(
      TreeNodeConverter<T>().fromJson(json['value'] as Object),
      children: (json['children'] as List<dynamic>?)
              ?.map((e) => TreeNode<T>.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    )
      .._id = json['_id'] as int
      .._parentID = json['_parentID'] as int?
      .._level = json['_level'] as int;

Map<String, dynamic> _$TreeNodeToJson<T>(TreeNode<T> instance) =>
    <String, dynamic>{
      'value': TreeNodeConverter<T>().toJson(instance.value),
      '_id': instance._id,
      'children': instance.children.map((e) => e.toJson()).toList(),
      '_parentID': instance._parentID,
      '_level': instance._level,
    };
