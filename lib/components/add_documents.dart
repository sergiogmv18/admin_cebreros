import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';


addFilesPicker(BuildContext context,{bool returnValue = false, bool isImg = true}) async {
  List<String>? allowedExtensions = isImg ? [] : ['pdf'];
  FilePickerResult? filesPicker = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: allowedExtensions, allowMultiple: true);
  List listImgs = [];
  if (filesPicker != null) {
    for(PlatformFile imgFile in filesPicker.files){
      List<int> byteArray =imgFile.bytes!.toList();
      String base64String = base64Encode(byteArray); 
      Map<String, dynamic> dataIMG = {'base64String': base64String, 'extension': imgFile.extension};
      listImgs.add(dataIMG);
    }
    if(returnValue){
      return listImgs;
    }else{
      Navigator.of(context).pop(listImgs);
    }
  }
}