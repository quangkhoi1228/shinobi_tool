import 'package:flutter/material.dart';

class RootTemplate extends StatefulWidget {
  final Widget child;
  const RootTemplate({Key? key, required this.child}) : super(key: key);

  @override
  State<RootTemplate> createState() => _RootTemplateState();
}

class _RootTemplateState extends State<RootTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        drawer: _buildDrawer(),
        body: Center(child: widget.child));
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            title: const Text('Setup Source Code'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
