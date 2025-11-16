import 'dart:typed_data';

import 'package:dakanji_db_core/database/dakanji_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';



BuildOp htmlImgToImageWidget(String path, int indexId, DaKanjiDB db) {

  final Future<Uint8List?> imageFuture = db.mediaDao.getMediaByPath(path, indexId);

  return BuildOp.inline(
    onRenderInlineBlock: (meta, child) {

      return WidgetPlaceholder(
        builder: (context, _) {
          
          return FutureBuilder<Uint8List?>(
            future: imageFuture,
            builder: (context, snapshot) {
              
              if (snapshot.connectionState == ConnectionState.waiting) return SizedBox();

              final img = snapshot.data;
              print(meta.element.attributes);
              if (img == null) {
                return Text(
                  "Image not found (path: $path, indexId: $indexId)",
                  style: const TextStyle(color: Colors.red),
                );
              }

              return Column(
                children: [
                  Image.memory(
                    img,
                    height: meta.element.attributes.containsKey('height')
                      ? double.tryParse(meta.element.attributes['height'] ?? '') 
                      : null,
                    width: meta.element.attributes.containsKey('width')
                      ? double.tryParse(meta.element.attributes['width'] ?? '') 
                      : null,
                    fit: BoxFit.fill,
                    semanticLabel: meta.element.attributes['alt'] ?? '',
                  ),
                  if(meta.element.attributes.containsKey('title'))
                    Text(meta.element.attributes['title']!)
                ]
              );
            },
          );
        },
      );
    },
  );
}