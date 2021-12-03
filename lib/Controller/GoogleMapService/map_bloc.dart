import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../Model/PlacePicker/place.dart';
import '../../Model/PlacePicker/place_search.dart';
import 'geolocator_service.dart';
import 'place_service.dart';

class MapBloc with ChangeNotifier {
  final geoLocatorService = GeolocatorService();
  final placeService = PlaceService();

  //Variables
  Position? currentLocation;
  List<PlaceSearch>? searchResults;
  StreamController<Place> selectedLocation = StreamController<Place>();

  MapBloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    searchResults = await placeService.getAutocomplete(searchTerm);
    notifyListeners();
  }

  @override
  void dispose() {
    selectedLocation.close();
    super.dispose();
  }
}