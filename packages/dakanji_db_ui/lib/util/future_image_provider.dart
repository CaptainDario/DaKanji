import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



typedef FutureBytesBuilder = Future<Uint8List?> Function();

class FutureImageProvider extends ImageProvider<FutureImageProvider> {
  final String id;
  final FutureBytesBuilder futureBuilder;

  const FutureImageProvider(this.id, this.futureBuilder);

  @override
  Future<FutureImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<FutureImageProvider>(this);
  }

  @override
  ImageStreamCompleter loadImage(
      FutureImageProvider key, ImageDecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, decode),
      scale: 1.0,
      debugLabel: 'FutureImageProvider($id)',
    );
  }

  Future<ui.Codec> _loadAsync(
      FutureImageProvider key, ImageDecoderCallback decode) async {
    try {
      final bytes = await key.futureBuilder();
      
      // 2. Handle null OR empty bytes
      if (bytes == null || bytes.isEmpty) {
        throw StateError('Image data is null or empty for ID: $id');
      }
      
      final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
      return decode(buffer);
    } catch (e) {
      // Rethrowing causes the library to catch the error 
      // and display the "alt" text (or broken image icon).
      rethrow;
    }
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is FutureImageProvider && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}