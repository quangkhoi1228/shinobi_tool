import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnbTab extends StatelessWidget {
  final List<SnbTabItem> tabs;
  const SnbTab({Key? key, required this.tabs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Get.theme.colorScheme.background,
          leading: new PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight - 10),
              child: Container()),
          flexibleSpace: new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              new TabBar(
                indicatorColor: Get.theme.colorScheme.primary,
                unselectedLabelColor: Get.theme.colorScheme.surface,
                labelColor: Get.theme.colorScheme.primary,
                automaticIndicatorColorAdjustment: true,
                tabs: tabs
                    .map((SnbTabItem tabItem) => Tab(
                          child: Text(
                            tabItem.name.toUpperCase(),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
        body: new TabBarView(
          children: tabs.map((SnbTabItem tabItem) => tabItem.child).toList(),
        ),
      ),
    );
  }
}

class SnbTabItem {
  final String name;
  final Widget child;
  const SnbTabItem({Key? key, required this.name, required this.child});
}
