enum CelebrationType {
  birthday,
  anniversary,
}

class BirthdayPerson {
  final String name;
  final String avatarUrl;
  final CelebrationType type;
  final String dateText;

  BirthdayPerson({
    required this.name,
    required this.avatarUrl,
    required this.type,
    required this.dateText,
  });
}
