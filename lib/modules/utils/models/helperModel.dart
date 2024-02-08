class Data {
  int? id;
  final String name;
  final String city;

  Data({required this.name, required this.city});

  factory Data.rawToObject({required Map data}) {
    return Data(
      name: data['name'],
      city: data['city'],
    );
  }
}
