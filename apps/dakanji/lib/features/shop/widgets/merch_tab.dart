import 'package:da_kanji_mobile/features/shop/model/mock_merch.dart';
import 'package:da_kanji_mobile/features/shop/widgets/shop_category_page.dart';
import 'package:flutter/material.dart';



class MerchTab extends StatelessWidget {
  const MerchTab({super.key});

  @override
  Widget build(BuildContext context) {
    // This widget now acts as a configuration wrapper for the generic shop page
    return ShopCategoryPage(
      products: kMockProducts,
    );
  }
}