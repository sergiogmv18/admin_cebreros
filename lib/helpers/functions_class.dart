import 'dart:math';

class FunctionClass{


  
String generateRandomNumber() {
  Random random = Random();
  int randomValue = random.nextInt(999999999); // Generates a random number up to 9 digits
  // Formats the number as a 9-character string, padding with zeros on the left if necessary
  String formattedNumber = randomValue.toString().padLeft(9, '0');
  return formattedNumber;
}

}