import 'package:dio/dio.dart';
import 'package:tyba_app/models/feature.dart';
import 'package:tyba_app/models/lat_lng.dart';
import 'package:tyba_app/models/responses/places_response.dart';

class ApiMapBox {
  static const accessToken =
      'pk.eyJ1Ijoic2VyZ2lvMWVzdGViYW4iLCJhIjoiY2t6OTd0Z2FxMGhsYjMwcDRhNTd1eWMxZiJ9.6CiPrF4mZ_5AZAZx8L6dtg';
  static late final Dio _placesDio;
  static const String _basePlacessUrl =
      'https://api.mapbox.com/geocoding/v5/mapbox.places';
  ApiMapBox() {
    _placesDio = Dio();
  }
  Future<List<Feature>> getPlacesSuggestions(
      LatLng? proximity, String? city) async {
    if ((city == null || city.isEmpty) && proximity == null) return [];
    late String url;
    if (city != null) {
      url = '$_basePlacessUrl/$city - restaurante.json';
    } else {
      url = '$_basePlacessUrl/restaurante.json';
    }
    final Map<String, dynamic> queryParameters = {
      'language': 'es',
      'access_token': ApiMapBox.accessToken,
      "type": "poi",
    };
    if (proximity != null) {
      queryParameters.addAll(
          {"proximity": '${proximity.longitude},${proximity.latitude}'});
    }
    final resp = await _placesDio.get(url, queryParameters: queryParameters);
    print(resp.data);
    final placesResponse = PlacesResponse.fromJson(resp.data);
    return placesResponse.features;
  }
}
