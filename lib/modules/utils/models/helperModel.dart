class Data {
  final int? id;
  final String name;
  final String city;

  Data({required this.name, required this.city, this.id});

  factory Data.rawToobject({required Map data}) {
    return Data(
      name: data['name'],
      city: data['city'],
      id: data['id'],
    );
  }
}
