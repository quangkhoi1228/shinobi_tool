import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shinobi_tool/controllers/home.controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(context) {
    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    final Controller c = Get.put(Controller());

    return Scaffold(
        // Use Obx(()=> to update Text() whenever count is changed.
        appBar: AppBar(title: Obx(() => Text("Clicks: ${c.count}"))),

        // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
        body: Center(
            child:
                ElevatedButton(child: Text("Go to Other"), onPressed: () {})),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: c.increment));
  }
}
