import 'package:flutter/material.dart';
import 'package:donor_app/constants.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class TrackLocation extends StatefulWidget {
  static const id = 'track_location';

  @override
  State<TrackLocation> createState() => _TrackLocationState();
}

class _TrackLocationState extends State<TrackLocation> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(33.6447, 72.9872);
  static const LatLng destination = LatLng(33.6436, 72.9911);

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon =
  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "images/source.png")
        .then(
          (icon) {
        sourceIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(5, 5)),
      "images/destination.png",
    ).then(
          (icon) {
        destinationIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(5, 5)), "images/current.png")
        .then(
          (icon) {
        currentLocationIcon = icon;
      },
    );
  }

  List<LatLng> polylineCoordinates = [];
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          google_api_key, // Your Google Map Key
          PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
          PointLatLng(destination.latitude, destination.longitude),
          travelMode: TravelMode.driving);
      print(result.status);
      print(result.points);
      print(result.errorMessage);
      if (result.points.isNotEmpty) {
        result.points.forEach(
              (PointLatLng point) => polylineCoordinates.add(
            LatLng(point.latitude, point.longitude),
          ),
        );
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  // Get Current Location
  LocationData? currentLocation;
  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then(
          (location) {
        currentLocation = location;
        print('Current Location: $currentLocation');
      },
    );
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen(
          (newLoc) {
        currentLocation = newLoc;
        print(currentLocation);
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 16,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              ),
            ),
          ),
        );
        // setState(() {});
      },
    ).onError((e) {
      print("No Permissions... $e");
    });
  }

  @override
  void initState() {
    getPolyPoints();
    getCurrentLocation();
    setCustomMarkerIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kAppBar("Track Location"),
      body: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
              currentLocation!.latitude!, currentLocation!.longitude!),
          zoom: 16,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("currentLocation"),
            icon: currentLocationIcon,
            position: LatLng(
                currentLocation!.latitude!, currentLocation!.longitude!),
          ),
          Marker(
            icon: sourceIcon,
            markerId: MarkerId("source"),
            position: sourceLocation,
          ),
          Marker(
            icon: destinationIcon,
            markerId: MarkerId("destination"),
            position: destination,
          ),
        },
        onMapCreated: (mapController) {
          _controller.complete(mapController);
        },
        polylines: {
          Polyline(
            polylineId: const PolylineId("route"),
            points: polylineCoordinates,
            color: const Color(0xFF7B61FF),
            width: 6,
          ),
        },
      ),
    );
  }
}
