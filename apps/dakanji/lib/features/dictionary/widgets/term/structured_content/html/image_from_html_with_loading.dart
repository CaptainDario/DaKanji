import 'package:flutter/material.dart';

class ImageFromHtmlWithLoading extends StatefulWidget {
  final ImageProvider provider;
  final Widget child;
  const ImageFromHtmlWithLoading({required this.provider, required this.child, super.key});

  @override
  State<ImageFromHtmlWithLoading> createState() => _ImageFromHtmlWithLoadingState();
}

class _ImageFromHtmlWithLoadingState extends State<ImageFromHtmlWithLoading> {
  bool _loaded = false;
  ImageStreamListener? _listener;
  ImageStream? _stream;

  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  void _subscribe() {
    _stream = widget.provider.resolve(ImageConfiguration.empty);
    _listener = ImageStreamListener(
      (_, _) { if (mounted) setState(() => _loaded = true); },
      onError: (_, _) { if (mounted) setState(() => _loaded = true); },
    );
    _stream!.addListener(_listener!);
  }

  @override
  void dispose() {
    _stream?.removeListener(_listener!);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        widget.child,
        if (!_loaded)
          const SizedBox(
            width: 24, height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
      ],
    );
  }
}