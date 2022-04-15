import 'dart:io';

import 'package:process_run/shell.dart';

class SnbTerminal {
  static void runCmd(
    String script, {
    Function(List<ProcessResult> results)? onSuccess,
    Function(dynamic result)? onError,
    Function(Process process)? onProcess,
    String? workingDirectory,
  }) {
    Shell shell = Shell(runInShell: true, workingDirectory: workingDirectory);
    shell.run(script).then((List<ProcessResult> results) {
      onSuccess!(results);
    }).catchError((dynamic result) {
      print(result);
      onError!(result);
    });
  }
}
