import 'package:equatable/equatable.dart';

class RatingDto extends Equatable {
  final String? Source;
  final String? Value;

  const RatingDto({this.Source, this.Value});

  factory RatingDto.fromMap(Map<String, dynamic> jsonMap) =>
      RatingDto(Source: jsonMap['Source'], Value: jsonMap['Value']);

  Map<String, dynamic> toMap() => {
    'Source': Source,
    'Value': Value,
  };

  bool get isNotEmpty => props.isNotEmpty;
  bool get isEmpty => props.isEmpty;

  @override
  List<Object?> get props => [
    Source,
    Value,
  ];
}