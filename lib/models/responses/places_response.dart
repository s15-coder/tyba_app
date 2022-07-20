// To parse this JSON data, do
//
//     final placesResponse = placesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:tyba_app/models/feature.dart';

PlacesResponse placesResponseFromJson(String str) =>
    PlacesResponse.fromJson(json.decode(str));

String placesResponseToJson(PlacesResponse data) => json.encode(data.toJson());

class PlacesResponse {
  PlacesResponse({
    required this.type,
    required this.query,
    required this.features,
    required this.attribution,
  });

  final String type;
  final List<String> query;
  final List<Feature> features;
  final String attribution;

  PlacesResponse copyWith({
    String? type,
    List<String>? query,
    List<Feature>? features,
    String? attribution,
  }) =>
      PlacesResponse(
        type: type ?? this.type,
        query: query ?? this.query,
        features: features ?? this.features,
        attribution: attribution ?? this.attribution,
      );

  factory PlacesResponse.fromJson(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"],
        query: List<String>.from(json["query"].map((x) => x)),
        features: List<Feature>.from(
            json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "attribution": attribution,
      };
}

class Context {
  Context({
    required this.id,
    required this.text,
    this.shortCode,
    this.wikidata,
  });

  final String id;
  final String text;
  final String? shortCode;
  final String? wikidata;

  Context copyWith({
    String? id,
    String? text,
    String? shortCode,
    String? wikidata,
  }) =>
      Context(
        id: id ?? this.id,
        text: text ?? this.text,
        shortCode: shortCode ?? this.shortCode,
        wikidata: wikidata ?? this.wikidata,
      );

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        id: json["id"],
        text: json["text"],
        shortCode: json["short_code"],
        wikidata: json["wikidata"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "short_code": shortCode,
        "wikidata": wikidata,
      };
}
