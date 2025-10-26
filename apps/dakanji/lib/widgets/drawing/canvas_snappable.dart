library snappable;

// Dart imports:
import 'dart:math' as math;
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:da_kanji_mobile/entities/bitmap.dart';

class CanvasSnappable extends StatefulWidget {
  /// Widget to be snapped
  final Widget child;

  /// Direction and range of snap effect
  /// (Where and how far will particles go)
  final Offset offset;

  /// Duration of whole snap animation
  final Duration duration;

  /// How much can particle be randomized,
  /// For example if [offset] is (100, 100) and [randomDislocationOffset] is (10,10),
  /// Each layer can be moved to maximum between 90 and 110.
  final Offset randomDislocationOffset;

  /// Number of layers of images,
  /// The more of them the better effect but the more heavy it is for CPU
  final int numberOfBuckets;

  /// Function that gets called when snap ends
  final VoidCallback? onSnapped;

  /// The color of the particles from the snap
  final Color snapColor;

  const CanvasSnappable({
    required Key key,
    required this.child,
    required this.snapColor,
    this.offset = const Offset(16, -16),
    this.duration = const Duration(milliseconds: 500),
    this.randomDislocationOffset = const Offset(8, 8),
    this.numberOfBuckets = 8,
    this.onSnapped,
  }) : super(key: key);

  @override
  CanvasSnappableState createState() => CanvasSnappableState();
}

class CanvasSnappableState extends State<CanvasSnappable>
    with SingleTickerProviderStateMixin {
  static const double _singleLayerAnimationLength = 0.6;
  static const double _lastLayerAnimationStart =
      1 - _singleLayerAnimationLength;

  bool get isGone => _animationController.isCompleted;

  /// Main snap effect controller
  late AnimationController _animationController;

  /// Key to get image of a [widget.child]
  final GlobalKey _globalKey = GlobalKey();

  /// Layers of image
  List<Uint8List>? _layers;

  /// Values from -1 to 1 to dislocate the layers a bit
  List<double> _randoms = [];

  /// Size of child widget
  int width = 0;
  int height = 0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    if (widget.onSnapped != null) {
      _animationController.addStatusListener((status) {
        if (status == AnimationStatus.completed){
          if(widget.onSnapped != null) {
            widget.onSnapped!();
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return Stack(
        children: <Widget>[
          if (_layers != null) ..._layers!.map(_imageToWidget),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return _animationController.isDismissed ? child! : Container();
            },
            child: RepaintBoundary(
              key: _globalKey,
              child: widget.child,
            ),
          )
        ],
      );
  }

  /// dissolve the canvas 
  Future<void> snap(Uint8List canvas, int width, int height) async {

    this.width = width;
    this.height = height;
    
    _layers = List.generate(
      widget.numberOfBuckets, (index) {
        return Uint8List(width * height * 4);
      }
    );

    // for every line of pixels
    for (int y = 0; y < height; y++) {
      // generate weight list of probabilities determining
      // to which bucket should given pixels go
      List<int> weights = List.generate(
        widget.numberOfBuckets,
        (bucket) => _gauss(
          y / height,
          bucket / widget.numberOfBuckets,
        ),
      );
      int sumOfWeights = weights.fold(0, (sum, el) => sum + el);

      //for every pixel in a line
      for (int x = 0; x < width; x++) {
        //choose a bucket for a pixel
        int imageIndex = _pickABucket(weights, sumOfWeights);
        //set the pixel from chosen bucket
        for (int i = 0; i < 4; i++){
          _layers![imageIndex][(y * width + x) * 4 + i] =
            canvas[(y * width + x) * 4 + 1];
      }
      }
    }

    //prepare random dislocations and set state
    setState(() {
      _randoms = List.generate(
        widget.numberOfBuckets,
        (i) => (math.Random().nextDouble() - 0.5) * 2,
      );
    });

    //give a short delay to draw images
    await Future.delayed(const Duration(milliseconds: 50));

    //start the snap!
    _animationController.forward();
  }

  /// reset the snap to the original image 
  void reset() {
    setState(() {
      _layers = null;
      _animationController.reset();
    });
  }

  /// Turn the given [layer] image to a Widget.
  Widget _imageToWidget(Uint8List layer) {

    if(_layers == null) {
      throw "this._layers is null";
    }

    //get layer's index in the list
    int index = _layers!.indexOf(layer);

    //based on index, calculate when this layer should start and end
    double animationStart = (index / _layers!.length) * _lastLayerAnimationStart;
    double animationEnd = animationStart + _singleLayerAnimationLength;

    //create interval animation using only part of whole animation
    CurvedAnimation animation = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        animationStart,
        animationEnd,
        curve: Curves.easeOut,
      ),
    );

    Offset randomOffset = widget.randomDislocationOffset.scale(
      _randoms[index],
      _randoms[index],
    );

    Animation<Offset> offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: widget.offset + randomOffset,
    ).animate(animation);

    return AnimatedBuilder(
      animation: _animationController,
      child: Image.memory(
        Bitmap.fromHeadless(width, height, layer).buildHeaded(),
        color: widget.snapColor,
      ),
      builder: (context, child) {
        return Transform.translate(
          offset: offsetAnimation.value,
          child: Opacity(
            opacity: 1 - animation.value,
            child: child,
          ),
        );
      },
    );
  }

  /// Returns index of a randomly chosen bucket
  int _pickABucket(List<int> weights, int sumOfWeights) {
    int rnd = math.Random().nextInt(sumOfWeights);
    int chosenImage = 0;
    for (int i = 0; i < widget.numberOfBuckets; i++) {
      if (rnd < weights[i]) {
        chosenImage = i;
        break;
      }
      rnd -= weights[i];
    }
    return chosenImage;
  }

  bool snapIsRunning(){
    return _animationController.status == AnimationStatus.forward;
  }

  int _gauss(double center, double value) {
    return (1000 * math.exp(-(math.pow((value - center), 2) / 0.14))).round();
  }

}
