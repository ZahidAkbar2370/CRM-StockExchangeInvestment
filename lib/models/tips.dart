class Tips {
  final String id;
  final String sagment;
  final String ideas;
  final String timeStamp;

  Tips({
    required this.id,
    required this.sagment,
    required this.ideas,
    required this.timeStamp,
  });

  factory Tips.fromJson(Map<String, dynamic> json) {
    return Tips(
      id: json['Id'],
      sagment: json['Sagment'],
      ideas: json['Ideas'],
      timeStamp: json['TimeStamp'].toString(),
    );
  }
}
