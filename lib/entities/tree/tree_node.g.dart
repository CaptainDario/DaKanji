// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TreeNode<T> _$TreeNodeFromJson<T>(Map<String, dynamic> json) => TreeNode<T>(
      TreeNodeConverter<T>().fromJson(json['value'] as Object),
      id: json['id'] as int? ?? 0,
      automaticallyUpdateIDs: json['automaticallyUpdateIDs'] as bool? ?? false,
      children: (json['children'] as List<dynamic>?)
              ?.map((e) => TreeNode<T>.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    )
      ..parentID = json['parentID'] as int?
      .._level = json['_level'] as int;

Map<String, dynamic> _$TreeNodeToJson<T>(TreeNode<T> instance) =>
    <String, dynamic>{
      'value': TreeNodeConverter<T>().toJson(instance.value),
      'id': instance.id,
      'automaticallyUpdateIDs': instance.automaticallyUpdateIDs,
      'children': instance.children.map((e) => e.toJson()).toList(),
      'parentID': instance.parentID,
      '_level': instance._level,
    };
