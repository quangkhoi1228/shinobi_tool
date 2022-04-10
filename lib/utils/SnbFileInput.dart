import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SnbFileInput extends StatefulWidget {
  bool isPickFile = true;
  bool isPickDirectory;
  String labelText;
  Function onChanged;
  Function? onEditingComplete;
  TextEditingController controller;
  List<String> allowedExtensions;

  SnbFileInput(
      {Key? key,
      required this.labelText,
      required this.controller,
      this.isPickDirectory = false,
      this.allowedExtensions = const [],
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
        labelText: widget.labelText,
      ),
      onTap: () {
        if (widget.isPickDirectory) {
          selectDirectory();
        }

        if (widget.isPickFile) {
          selectFile();
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

  Future<void> selectFile() async {
    FileType fileType = FileType.any;
    var allowedExtensions;
    if (widget.allowedExtensions.length > 0) {
      fileType = FileType.custom;
      allowedExtensions = widget.allowedExtensions;
    }
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: fileType, allowedExtensions: allowedExtensions);

    if (result != null) {
      print(":a");
      String path = "";
      if (result.files.single.path != null) {
        path = result.files.single.path!;
      }
      File file = File(path);
      print(file.path);
      widget.controller.text = file.path;
      widget.onChanged(file.path);
    } else {
      print(":a2");
      // User canceled the picker
      widget.controller.text = "";
    }
  }
}
