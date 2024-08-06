String fullName(String name, String lastName) {
  final firstName = name[0].toUpperCase() + name.substring(1);
  final surname = lastName[0].toUpperCase() + lastName.substring(1);

  return "$firstName $surname";
}
