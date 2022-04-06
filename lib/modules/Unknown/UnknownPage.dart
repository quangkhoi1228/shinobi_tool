import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shinobi_tool/templates/RootTemplate.dart';

class UnknownPage extends StatelessWidget {
  @override
  Widget build(context) {
    return RootTemplate(
      title: 'Unkownn Page',
      child: Text("The page is not exist"),
    );
  }
}
