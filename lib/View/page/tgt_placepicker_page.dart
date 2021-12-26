import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:togetor/View/page/tgtaddpage.dart';
import '../../Model/PlacePicker/place.dart';
import '../../Controller/GoogleMapService/map_bloc.dart';
import '../../Controller/GoogleMapService/place_service.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MapBloc(),
      child: const MaterialApp(
        home: MapSample(),
      ),
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  _MapSampleState createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _mapController = Completer();
  late StreamSubscription locationSubscription;

  final placeService = PlaceService();
  final Set<Marker> _markers = Set();
  var place;

  @override
  void initState() async{
    final applicationBloc = Provider.of<MapBloc>(context, listen: false);

    locationSubscription =
        applicationBloc.selectedLocation.stream.listen((place) {
      _goToPlace(place);
    });
    super.initState();
  }

  @override
  void dispose() {
    final applicationBloc = Provider.of<MapBloc>(context, listen: false);
    applicationBloc.dispose();
    locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<MapBloc>(context);

    return GestureDetector(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: (applicationBloc.currentLocation == null)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, top: 20, right: 10, bottom: 10),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search Location',
                        suffixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) => applicationBloc.searchPlaces(value),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: (MediaQuery.of(context).size.height) * 0.6,
                        padding: const EdgeInsets.only(
                            top: 10, left: 13, right: 13, bottom: 10),
                        child: GoogleMap(
                          myLocationEnabled: true,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(
                                  applicationBloc.currentLocation!.latitude,
                                  applicationBloc.currentLocation!.longitude),
                              zoom: 14),
                          onMapCreated: (GoogleMapController controller) {
                            _mapController.complete(controller);
                          },
                          markers: _markers,
                        ),
                      ),
                      if (applicationBloc.searchResults != null &&
                          applicationBloc.searchResults!.isNotEmpty)
                        Container(
                          height: (MediaQuery.of(context).size.height) * 0.6,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              backgroundBlendMode: BlendMode.darken),
                        ),
                      if (applicationBloc.searchResults != null &&
                          applicationBloc.searchResults!.isNotEmpty)
                        SizedBox(
                          height: (MediaQuery.of(context).size.height) * 0.6,
                          child: ListView.builder(
                            itemCount: applicationBloc.searchResults!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  applicationBloc
                                      .searchResults![index].description,
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () async {
                                  place = await PlaceService().getPlace(
                                      applicationBloc
                                          .searchResults![index].placeId);
                                  moveToLocation();
                                  applicationBloc.searchResults = null;
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                              );
                            },
                          ),
                        )
                    ],
                  ),
                  Container(
                    child: (place == null)
                        ? Column(
                            children: const <Widget>[
                              Card(
                                child: ListTile(
                                  title: Text('주소'),
                                ),
                              ),
                              Card(
                                child: ListTile(
                                  title: Text('상세주소'),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: <Widget>[
                              Card(
                                child: ListTile(
                                  title: Text('${place!.name}'),
                                ),
                              ),
                              Card(
                                child: ListTile(
                                  title: Text('${place!.formattedAddress}'),
                                ),
                              ),
                            ],
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: (MediaQuery.of(context).size.height) * 0.02,
                        horizontal: (MediaQuery.of(context).size.width) * 0.3),
                    child: TextButton(
                      child: const Text('설정'),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blueAccent,
                        onSurface: Colors.grey,
                      ),
                      onPressed: () {
                        if (place == null) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("주의"),
                                  content: const Text("위치를 선택해주세요"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("Close"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                );
                              });
                        } else {
                          print(place!.formattedAddress);
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Add()));
                        }
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target:
            LatLng(place.geometry!.location.lat, place.geometry!.location.lng),
        zoom: 16.0)));
  }

  void moveToLocation() async {
    if (_markers.isNotEmpty) {
      setState(() {
        _markers.clear();
      });
    }
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(place!.placeId),
          position: LatLng(place!.lat, place!.lng),
          infoWindow: InfoWindow(
            title: place!.name,
            snippet: place!.formattedAddress,
          ),
        ),
      );
    });
    GoogleMapController controller = await _mapController.future;

    controller
        .animateCamera(CameraUpdate.newLatLng(LatLng(place!.lat, place!.lng)));
  }
}
