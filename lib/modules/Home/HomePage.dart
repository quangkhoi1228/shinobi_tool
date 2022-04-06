import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shinobi_tool/styles/Css.dart';
import 'package:shinobi_tool/templates/RootTemplate.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(context) {
    return RootTemplate(
      title: 'Home',
      child: buildBodyWidget(),
    );
  }

  Widget buildBodyWidget() {
    return Container(
      width: 900,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          control(
            child: Text(
              "Git login info",
              style: TextStyle(fontSize: Css.fontSize),
            ),
          ),
          control(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.only(right: Css.padding),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                )
              ],
            ),
          ),
          control(
            child: Text(
              "Project list",
              style: TextStyle(fontSize: Css.fontSize),
            ),
          ),
        ],
      ),
    );
  }

  Widget control({required Widget child}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: Css.padding),
      child: child,
    );
  }
}
