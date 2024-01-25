import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

Future<List<File>> pickImage() async {
  List<File> image = [];

  try {
    var result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);
    var file = result!.paths;

    if (file != null) {
      for (int i = 0; i < file.length; i++) {
        image.add(File(file[i]!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return image;
}

Future<String?> selectImage() async {
  
    FilePickerResult? res = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

    if (res != null) {
      PlatformFile file = res.files.first;

      return file.path;
    }
    return null;
  
}
