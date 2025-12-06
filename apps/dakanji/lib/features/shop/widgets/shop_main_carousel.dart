import 'package:flutter/material.dart';
import 'package:da_kanji_mobile/features/shop/model/product.dart';
import 'shop_constants.dart';
import 'shop_cart_button.dart';
import 'shop_indicator_dot.dart';

class ShopMainCarousel extends StatelessWidget {
  final List<Product> products;
  final PageController pageController;
  final int currentProductIndex;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onVerticalNav;
  final VoidCallback onResetTimer;

  const ShopMainCarousel({
    super.key,
    required this.products,
    required this.pageController,
    required this.currentProductIndex,
    required this.onPageChanged,
    required this.onVerticalNav,
    required this.onResetTimer,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: pageController,
          onPageChanged: onPageChanged,
          itemBuilder: (context, index) {
            final productIndex = index % products.length;
            return ProductItemCard(product: products[productIndex]);
          },
        ),

        // Page Indicators
        Positioned(
          bottom: 60,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              products.length,
              (index) => IndicatorDot(
                isActive: currentProductIndex == index,
                isSmall: false,
              ),
            ),
          ),
        ),

        // Navigation Arrows
        Positioned(
          left: 10,
          top: 0,
          bottom: 0,
          child: Center(
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white.withOpacity(0.3),
                size: 32,
              ),
              onPressed: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
                onResetTimer();
              },
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 0,
          bottom: 0,
          child: Center(
            child: IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white.withOpacity(0.3),
                size: 32,
              ),
              onPressed: () {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
                onResetTimer();
              },
            ),
          ),
        ),

        // Down Arrow
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Center(
            child: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white.withOpacity(0.8),
                size: 28,
              ),
              onPressed: onVerticalNav,
            ),
          ),
        ),
      ],
    );
  }
}

class ProductItemCard extends StatelessWidget {
  final Product product;

  const ProductItemCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Image
        Image.network(
          product.images[0],
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: kCardColor,
          ),
        ),

        // Gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.0),
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                Theme.of(context).scaffoldBackgroundColor,
              ],
              stops: const [0.0, 0.6, 0.9, 1.0],
            ),
          ),
        ),

        // Content
        Positioned(
          bottom: 80,
          left: 20,
          right: 20,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                decoration: BoxDecoration(
                  color: kCardColor.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.subtitle,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 2.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    const AddToCartButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}