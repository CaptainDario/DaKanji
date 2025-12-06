import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:da_kanji_mobile/features/shop/model/product.dart';
import 'shop_constants.dart';
import 'shop_cart_button.dart';
import 'shop_indicator_dot.dart';

class ProductDetailsSection extends StatelessWidget {
  final Product product;
  final PageController pageController;
  final int carouselIndex;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onVerticalNav;

  const ProductDetailsSection({
    super.key,
    required this.product,
    required this.pageController,
    required this.carouselIndex,
    required this.onPageChanged,
    required this.onVerticalNav,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // A. Details Image Carousel
          Expanded(
            flex: 1,
            child: DetailsImageGallery(
              product: product,
              pageController: pageController,
              carouselIndex: carouselIndex,
              onPageChanged: onPageChanged,
              onVerticalNav: onVerticalNav,
            ),
          ),

          // B. Text Description - Card Vibe
          Expanded(
            flex: 2,
            child: DetailsContentSheet(product: product),
          ),
        ],
      ),
    );
  }
}

class DetailsImageGallery extends StatelessWidget {
  final Product product;
  final PageController pageController;
  final int carouselIndex;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onVerticalNav;

  const DetailsImageGallery({
    super.key,
    required this.product,
    required this.pageController,
    required this.carouselIndex,
    required this.onPageChanged,
    required this.onVerticalNav,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: PageView.builder(
                controller: pageController,
                onPageChanged: onPageChanged,
                itemBuilder: (context, index) {
                  final imageIndex = index % product.images.length;
                  return GestureDetector(
                    onTap: () {
                      _showFullScreenImage(context, product, imageIndex);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 10),
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24.0),
                        child: Image.network(
                          product.images[imageIndex],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(color: kCardColor),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),

        // Arrows
        if (product.images.length > 1) ...[
          Positioned(
            left: 20,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kCardColor.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                onPressed: () {
                  pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kCardColor.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                onPressed: () {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ),
        ],

        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              product.images.length,
              (index) => IndicatorDot(
                isActive: carouselIndex == index,
                isSmall: true,
              ),
            ),
          ),
        ),

        // Up Arrow
        Positioned(
          top: 20,
          left: 20,
          child: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: kCardColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.keyboard_arrow_up, color: Colors.white),
            ),
            onPressed: onVerticalNav,
          ),
        ),
      ],
    );
  }

  void _showFullScreenImage(
    BuildContext context,
    Product product,
    int initialIndex,
  ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return FullScreenCarouselDialog(
          product: product,
          initialIndex: initialIndex,
        );
      },
    );
  }
}

class DetailsContentSheet extends StatelessWidget {
  final Product product;

  const DetailsContentSheet({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      decoration: const BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle Bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product.subtitle,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    product.price,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              // Accent line divider
              Container(width: 60, height: 3, color: kAccentHighlight),

              const SizedBox(height: 24),
              const Text(
                "DETAILS",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                product.description,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 15,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 30),
              const AddToCartButton(label: "ADD TO CART"),
            ],
          ),
        ),
      ),
    );
  }
}

class FullScreenCarouselDialog extends StatefulWidget {
  final Product product;
  final int initialIndex;

  const FullScreenCarouselDialog({
    super.key,
    required this.product,
    required this.initialIndex,
  });

  @override
  State<FullScreenCarouselDialog> createState() =>
      _FullScreenCarouselDialogState();
}

class _FullScreenCarouselDialogState extends State<FullScreenCarouselDialog> {
  late final PageController _controller;
  // ignore: unused_field
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;

    final int startPage =
        (widget.product.images.length * 1000) + widget.initialIndex;
    _controller = PageController(initialPage: startPage);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
              ),
            ),
          ),
          PageView.builder(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index % widget.product.images.length;
              });
            },
            itemBuilder: (context, index) {
              final imageIndex = index % widget.product.images.length;
              return GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: Image.network(
                    widget.product.images[imageIndex],
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
          if (widget.product.images.length > 1) ...[
            Positioned(
              left: 20,
              top: 0,
              bottom: 0,
              child: Center(
                child: IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: kCardColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  onPressed: () {
                    _controller.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: 0,
              bottom: 0,
              child: Center(
                child: IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: kCardColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  onPressed: () {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),
          ],
          Positioned(
            top: 50,
            right: 20,
            child: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: kCardColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 28),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}