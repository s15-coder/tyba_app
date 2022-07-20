part of 'places_bloc.dart';

abstract class PlacesEvent {
  const PlacesEvent();
}

class StartFetchingPlaces extends PlacesEvent {}

class StopFetchingPlaces extends PlacesEvent {
  final List<Feature> places;

  StopFetchingPlaces(this.places);
}

class ClearFeatures extends PlacesEvent {}
