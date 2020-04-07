import 'package:json_annotation/json_annotation.dart';

part 'source.g.dart';

@JsonSerializable()
class Source {
  String id;
  String name;

  Source(this.name);

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  Map<String, dynamic> toJson() => _$SourceToJson(this);

  @override
  String toString() {
    return 'Source{id: $id, name: $name}';
  }
}
