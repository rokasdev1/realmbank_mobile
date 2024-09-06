import 'package:hive/hive.dart';

part 'contact.g.dart';

@HiveType(typeId: 1)
class Contact {
  @HiveField(0)
  final String fullName;

  @HiveField(1)
  final String cardNumber;

  @HiveField(2)
  int? key;

  Contact({
    required this.fullName,
    required this.cardNumber,
    this.key,
  });
}
