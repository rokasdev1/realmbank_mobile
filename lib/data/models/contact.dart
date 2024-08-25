import 'package:hive/hive.dart';

part 'contact.g.dart';

@HiveType(typeId: 1)
class Contact {
  @HiveField(0)
  final String fullName;

  @HiveField(1)
  final String cardNumber;

  Contact({
    required this.fullName,
    required this.cardNumber,
  });
}
