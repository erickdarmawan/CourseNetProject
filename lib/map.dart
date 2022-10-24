import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


const kGoogleApiKey = "AIzaSyAewObC4AwKmUWUzedixKm9C4912Wqj9uI";

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
// Prediction p =  PlacesAutocomplete.show(
//                           context: context,
//                           apiKey: kGoogleApiKey,
//                           mode: Mode.overlay, // Mode.fullscreen
//                           language: "fr",
//                           components: [new Component(Component.country, "fr")]);

    Set<Marker> pin = <Marker>{};

    pin.add(const Marker(
        markerId: MarkerId("MarkerSC"),
        position: LatLng(
          -6.2267195,
          106.795604,
        ),
        infoWindow: InfoWindow(title: "Senayan City")));

    pin.add(const Marker(
        markerId: MarkerId("MarkerPS"),
        position: LatLng(
          -6.2267195,
          106.795604,
        ),
        infoWindow: InfoWindow(title: "Plaza Senayan")));

    pin.add(const Marker(
        markerId: MarkerId("MarkerMTA"),
        position: LatLng(-6.1785778, 106.7900241),
        infoWindow: InfoWindow(title: "Mall Taman Anggrek")));

    pin.add(const Marker(
        markerId: MarkerId("MarkerPI"),
        position: LatLng(-6.1939206, 106.8200271),
        infoWindow: InfoWindow(title: "Plaza Indonesia")));

    return Scaffold(
        body: GoogleMap(
      markers: pin,
      mapType: MapType.normal,
      trafficEnabled: true,
      buildingsEnabled: true,
      zoomControlsEnabled: true,
      indoorViewEnabled: true,
      initialCameraPosition: const CameraPosition(
        zoom: 17,
        target: LatLng(-6.2267195, 106.795604),
      ),
    ));
  }
}
