import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tyba_app/models/feature.dart';
import 'package:tyba_app/models/lat_lng.dart';
import 'package:tyba_app/services/map_box_api/api_map_box_service.dart';

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  final ApiMapBox apiMapBox = ApiMapBox();
  PlacesBloc() : super(const PlacesState()) {
    on<StartFetchingPlaces>((event, emit) {
      emit(state.copyWith(fetchingData: true));
    });
    on<StopFetchingPlaces>((event, emit) {
      emit(state.copyWith(fetchingData: false, features: event.places));
    });
    on<ClearFeatures>((event, emit) {
      emit(state.copyWith(fetchingData: false, features: []));
    });
  }

  Future getPlaces({
    String? city,
    LatLng? proximity,
  }) async {
    add(StartFetchingPlaces());
    final places = await apiMapBox.getPlacesSuggestions(proximity, city);
    print(places);
    add(StopFetchingPlaces(places));
  }

  void clearFeature() {
    add(ClearFeatures());
  }
}
