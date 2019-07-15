// import 'package:json_annotation/json_annotation.dart';
// part 'city.g.dart';

// @JsonSerializable(createFactory: true)
class City {
  int id;
  String name;

  City({this.id, this.name});

  //Map<String, dynamic> toJson() => _$CityToJson(this);

  // factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}
