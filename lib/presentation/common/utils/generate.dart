import 'dart:convert';

class Generate {
  static String qrCode({
    required String requestorCardNum,
    required double amount,
    required String description,
  }) {
    // requesterCardNum to amount for description(Request)
    return 'REQUEST-MONEY $requestorCardNum:$amount:$description(Request)';
  }

  static String cardNumber(String email) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final uniqueSeed = utf8.encode(email + timestamp.toString());
    final hash = base64Encode(uniqueSeed).replaceAll(RegExp(r'[^0-9]'), '');

    String cardNumber = '';
    for (int i = 0; i < 16; i++) {
      cardNumber += hash[i % hash.length];
    }

    return "RM$cardNumber";
  }
}
