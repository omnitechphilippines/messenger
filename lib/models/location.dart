class Location {
  static const String streetKey = "street";
  static const String cityKey = "city";
  static const String stateKey = "state";
  static const String postcodeKey = "postcode";
  final String street;
  final String city;
  final String state;
  final String postcode;

  Location({required this.street, required this.city, required this.state, required this.postcode});

  factory Location.fromJson(Map<String, Object> json) => Location(street: json[streetKey].toString(), city: json[cityKey].toString(), state: json[stateKey].toString(), postcode: json[postcodeKey].toString());

  toJson() => <String, Object>{streetKey: street, cityKey: city, stateKey: state, postcodeKey: postcode};
}
