import 'dart:convert'; // For utf8.encode

String generateCardNumber(String email) {
  // Generate a random 16-digit number
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final uniqueSeed = utf8.encode(email + timestamp.toString());
  final hash = base64Encode(uniqueSeed).replaceAll(RegExp(r'[^0-9]'), '');

  // Ensure the card number is 16 digits long
  String cardNumber = '';
  for (int i = 0; i < 16; i++) {
    cardNumber += hash[i % hash.length];
  }

  // Add the "RM" prefix
  return "RM$cardNumber";
}

void main() {
  String email = "user@example.com";
  String cardNumber = generateCardNumber(email);
  print(cardNumber); // Example output: "RM8374298112304598"
}
