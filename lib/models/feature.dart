import 'package:tyba_app/models/responses/places_response.dart';

class Feature {
  Feature({
    required this.id,
    required this.type,
    required this.placeType,
    required this.relevance,
    required this.text,
    required this.placeName,
    required this.center,
    required this.context,
  });

  final String id;
  final String type;
  final List<String>? placeType;
  final double relevance;
  final String text;
  final String placeName;
  final List<double> center;
  final List<Context> context;

  Feature copyWith({
    String? id,
    String? type,
    List<String>? placeType,
    double? relevance,
    String? text,
    String? placeName,
    List<double>? center,
    List<Context>? context,
  }) =>
      Feature(
        id: id ?? this.id,
        type: type ?? this.type,
        placeType: placeType ?? this.placeType,
        relevance: relevance ?? this.relevance,
        text: text ?? this.text,
        placeName: placeName ?? this.placeName,
        center: center ?? this.center,
        context: context ?? this.context,
      );

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: json["place_type"] != null
            ? List<String>.from(json["place_type"].map((x) => x))
            : null,
        relevance: json["relevance"].toDouble(),
        text: json["text"],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        context:
            List<Context>.from(json["context"].map((x) => Context.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "place_type": placeType != null
            ? List<dynamic>.from(placeType!.map((x) => x))
            : null,
        "relevance": relevance,
        "text": text,
        "place_name": placeName,
        "center": List<dynamic>.from(center.map((x) => x)),
        "context": List<dynamic>.from(context.map((x) => x.toJson())),
      };
}
