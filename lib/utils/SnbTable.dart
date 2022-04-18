import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnbTable extends StatelessWidget {
  final List<SnbTableCell> header;
  final List<SnbTableRow> body;
  const SnbTable({Key? key, required this.header, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DataTable(
          showBottomBorder: true, columns: buildHeader(), rows: buildBody()),
    );
  }

  List<DataColumn> buildHeader() {
    return header
        .map((SnbTableCell headerItem) =>
            DataColumn(label: Text(headerItem.data)))
        .toList();
  }

  List<DataRow> buildBody() {
    return body
        .map((SnbTableRow rowItem) => DataRow(
            cells: rowItem.children
                .map((SnbTableCell cellItem) => buildBodyCell(cellItem))
                .toList()))
        .toList();
  }

  DataCell buildBodyCell(SnbTableCell cellItem) {
    return DataCell(Container(
        decoration: BoxDecoration(
            border: Border.all(color: Get.theme.colorScheme.onSurface)),
        child: Text(cellItem.data)));
  }
}

class SnbTableCell {
  final String data;
  SnbTableCell(this.data);
}

class SnbTableRow {
  final List<SnbTableCell> children;
  const SnbTableRow({Key? key, required this.children});
}
