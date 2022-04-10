import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SnbFileInput extends StatefulWidget {
  bool isPickFile = true;
  bool isPickDirectory;
  Function onChanged;
  Function? onEditingComplete;
  TextEditingController controller;
  SnbFileInput(
      {Key? key,
      required this.controller,
      this.isPickDirectory = false,
      this.onEditingComplete,
      required this.onChanged})
      : super(key: key);

  @override
  State<SnbFileInput> createState() => _SnbFileInputState();
}

class _SnbFileInputState extends State<SnbFileInput> {
  @override
  void initState() {
    widget.isPickFile = !widget.isPickDirectory;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      onEditingComplete: () {
        widget.onEditingComplete!();
      },
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Projects Directory',
      ),
      onTap: () {
        if (widget.isPickDirectory) {
          selectDirectory();
        }
      },
    );
  }

  Future<void> selectDirectory() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory == null) {
      // User canceled the picker
      widget.controller.text = "";
    } else {
      print(selectedDirectory);
      widget.controller.text = selectedDirectory;
      widget.onChanged(selectedDirectory);
    }
  }
}
