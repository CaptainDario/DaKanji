import 'package:da_kanji_mobile/core/routing/screens.dart';
import 'package:da_kanji_mobile/features/drawer/widgets/drawer.dart';
import 'package:da_kanji_mobile/features/shop/widgets/shop_widget.dart';
import 'package:flutter/material.dart';



class ShopScreen extends StatelessWidget {

  /// was this page opened by clicking on the tab in the drawer
  final bool openedByDrawer;

  const ShopScreen(
    this.openedByDrawer,
    {
      super.key
    }
  );

  @override
  Widget build(BuildContext context) {
    return DaKanjiDrawer(
      currentScreen: Screens.shop,
      drawerClosed: !openedByDrawer,
      child: ShopWidget(),
    );
  }
}