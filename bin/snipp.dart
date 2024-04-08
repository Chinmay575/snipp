import 'dart:developer';
import 'dart:io';

import 'src/create_clean_architechture.dart';

void main(List<String> args) async {
  await createCleanArchitectureFiles();

  addFilesToGit();
}


void addFilesToGit() {
  Process.run('git', ['add', '.']).then((result) {
    if (result.exitCode == 0) {
      log('All files added to Git.', name: 'INFO');
    } else {
      log('Failed to add files to Git. Error: ${result.stderr}', name: 'ERROR');
    }
  });
}

extension StringExtension on String {
  String capitalize() {
    return isNotEmpty ? this[0].toUpperCase() + substring(1) : this;
  }

  String toLowerCaseFirst() {
    return isNotEmpty ? this[0].toLowerCase() + substring(1) : this;
  }

  String toSnakeCase() {
    return replaceAllMapped(RegExp(r'([A-Z])'), (match) {
      return '_${match.group(1)!.toLowerCase()}';
    }).replaceAll(RegExp(r'\s+'), '_');
  }
}
