part of 'places_bloc.dart';

class PlacesState extends Equatable {
  final List<Feature> features;
  final bool fetchingData;

  const PlacesState({this.features = const [], this.fetchingData = false});
  PlacesState copyWith({
    List<Feature>? features,
    bool? fetchingData,
  }) =>
      PlacesState(
        features: features ?? this.features,
        fetchingData: fetchingData ?? this.fetchingData,
      );
  @override
  List<Object> get props => [features, fetchingData];
}
