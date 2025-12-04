import 'package:da_kanji_mobile/features/shop/widgets/features_tab.dart';
import 'package:da_kanji_mobile/features/shop/widgets/merch_tab.dart';
import 'package:da_kanji_mobile/globals.dart';
import 'package:flutter/material.dart';



class ShopWidget extends StatefulWidget {
  const ShopWidget({super.key});

  @override
  State<ShopWidget> createState() => _ShopWidgetState();
}

class _ShopWidgetState extends State<ShopWidget> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).highlightColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Theme.of(context).highlightColor,
          tabs: [
            Tab(text: 'Features'),
            Tab(text: 'Merch'),
          ]
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              FeaturesTab(),
              MerchTab(),
            ]
          ),
        )
      ],
    );
  }
}