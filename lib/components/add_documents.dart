import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';


addFilesPicker(BuildContext context,{bool returnValue = false}) async {
  FilePickerResult? filesPicker = await FilePicker.platform.pickFiles(type: FileType.image, allowMultiple: false);
  List listImgs = [];
  if (filesPicker != null &&  filesPicker.files.isNotEmpty) {
    PlatformFile file = filesPicker.files.first;
    File pickedFile = File(file.path!);
    List<int> bytes = await pickedFile.readAsBytes();
    String base64String = base64Encode(bytes); 
    Map<String, dynamic> dataIMG = {'base64String': base64String, 'extension': file.extension};
    listImgs.add(dataIMG);
    if(returnValue){
      return listImgs;
    }else{
      Navigator.of(context).pop(listImgs);
    }
  }
    
}