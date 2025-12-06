import 'dart:async';
import 'package:da_kanji_mobile/features/shop/model/product.dart';
import 'package:flutter/material.dart';

import 'shop_constants.dart';
import 'shop_main_carousel.dart';
import 'product_details_section.dart';

class ShopCategoryPage extends StatefulWidget {
  final List<Product> products;

  const ShopCategoryPage({
    super.key,
    required this.products,
  });

  @override
  State<ShopCategoryPage> createState() => _ShopCategoryPageState();
}

class _ShopCategoryPageState extends State<ShopCategoryPage> {
  late final PageController _mainHorizontalController;
  final PageController _verticalController = PageController();
  late final PageController _detailsPageController;

  Timer? _mainAutoScrollTimer;
  Timer? _detailsAutoScrollTimer;

  int _currentProductIndex = 0;
  int _detailsCarouselIndex = 0;

  @override
  void initState() {
    super.initState();
    _mainHorizontalController = PageController(
      initialPage: widget.products.length * 1000,
    );

    final startPage = widget.products.isNotEmpty
        ? widget.products[0].images.length * 1000
        : 0;
    _detailsPageController = PageController(initialPage: startPage);

    _startTimers();
  }

  @override
  void dispose() {
    _mainAutoScrollTimer?.cancel();
    _detailsAutoScrollTimer?.cancel();
    _mainHorizontalController.dispose();
    _verticalController.dispose();
    _detailsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.products.isEmpty) {
      return Container(color: Theme.of(context).scaffoldBackgroundColor);
    }

    final currentProduct = widget.products[_currentProductIndex];

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: PageView(
        controller: _verticalController,
        scrollDirection: Axis.vertical,
        children: [
          ShopMainCarousel(
            products: widget.products,
            pageController: _mainHorizontalController,
            currentProductIndex: _currentProductIndex,
            onPageChanged: _handleMainPageChanged,
            onVerticalNav: () => _verticalController.animateToPage(
              1,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            ),
            onResetTimer: _resetMainTimer,
          ),
          ProductDetailsSection(
            product: currentProduct,
            pageController: _detailsPageController,
            carouselIndex: _detailsCarouselIndex,
            onPageChanged: _handleDetailsPageChanged,
            onVerticalNav: () => _verticalController.animateToPage(
              0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            ),
          ),
        ],
      ),
    );
  }

  // --- Helpers ---

  void _startTimers() {
    _mainAutoScrollTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_mainHorizontalController.hasClients) {
        _mainHorizontalController.nextPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });

    _detailsAutoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_detailsPageController.hasClients) {
        _detailsPageController.nextPage(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _resetMainTimer() {
    _mainAutoScrollTimer?.cancel();
    _mainAutoScrollTimer = Timer.periodic(const Duration(seconds: 10), (t) {
      if (_mainHorizontalController.hasClients) {
        _mainHorizontalController.nextPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _handleMainPageChanged(int index) {
    setState(() {
      _currentProductIndex = index % widget.products.length;
      _detailsCarouselIndex = 0;

      if (_detailsPageController.hasClients) {
        final product = widget.products[_currentProductIndex];
        _detailsPageController.jumpToPage(product.images.length * 1000);
      }
    });
  }

  void _handleDetailsPageChanged(int index) {
    final currentProduct = widget.products[_currentProductIndex];
    setState(() {
      _detailsCarouselIndex = index % currentProduct.images.length;
    });
  }
}