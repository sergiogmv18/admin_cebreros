import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

class FunctionClass{

static const double borderRadius = 10;
  
String generateRandomNumber() {
  Random random = Random();
  int randomValue = random.nextInt(999999999); // Generates a random number up to 9 digits
  // Formats the number as a 9-character string, padding with zeros on the left if necessary
  String formattedNumber = randomValue.toString().padLeft(9, '0');
  return formattedNumber;
}


  /*
 * Convert base64 to bytes and return or value for show imagen of event
 * @author  SGV             - 20231019
 * @version 1.0             - 20231019 - initial release
 * @param   <String>  - img  - image in format base64                                               
 * @return  <widget>  widget 
 */
  static showContainerImg(String img){
    Uint8List bytes = base64Decode(img);
    return bytes;
  }
}