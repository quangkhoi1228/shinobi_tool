import 'package:flutter/cupertino.dart';
import 'package:shinobi_tool/styles/Css.dart';
import 'package:shinobi_tool/utils/SnbButton.dart';
import 'package:shinobi_tool/utils/SnbTable.dart';

class CompressCssTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Css.padding),
      child: Column(
        children: [
          SnbTable(header: [
            SnbTableCell('Name'),
            SnbTableCell('Path'),
            SnbTableCell('Is Optimize'),
            SnbTableCell(''),
          ], body: []),
          Flexible(
              child: SnbButton(
            text: 'Add folder',
            onPressed: () {},
          )),
        ],
      ),
    );
  }
}
