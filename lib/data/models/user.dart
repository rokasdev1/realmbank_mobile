class RMUser {
  final String name;
  final String lastName;
  final double balance;
  final String email;
  final String cardNumber;
  late String uid;

  RMUser({
    required this.name,
    required this.lastName,
    required this.balance,
    required this.email,
    required this.cardNumber,
    required this.uid,
  });
  Map<String, dynamic> toJson() => {
        'name': name,
        'lastName': lastName,
        'balance': balance,
        'email': email,
        'cardNumber': cardNumber,
        'uid': uid,
      };

  static RMUser fromJson(Map<String, dynamic> json) => RMUser(
        name: json['name'],
        lastName: json['lastName'],
        balance: (json['balance'] is int)
            ? (json['balance'] as int).toDouble()
            : (json['balance'] as double),
        email: json['email'],
        cardNumber: json['cardNumber'],
        uid: json['uid'],
      );
}
