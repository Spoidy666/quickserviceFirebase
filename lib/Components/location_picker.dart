import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quickservice/Services/location_service.dart';
import 'package:geolocator/geolocator.dart';

class LocationPickerPage extends StatefulWidget {
  const LocationPickerPage({super.key});

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  late GoogleMapController mapController;
  LatLng _selectedLatLng = const LatLng(10.5276, 76.2144);
  String _address = "Loading...";
  String _city = "";
  String _pincode = "";

  @override
  void initState() {
    super.initState();
    _setInitialLocation();
  }

  Future<void> _setInitialLocation() async {
    try {
      final position = await LocationService.getCurrentLocation();
      final userLatLng = LatLng(position.latitude, position.longitude);

      setState(() {
        _selectedLatLng = userLatLng;
      });

      // Animate the map to the user's location
      mapController.animateCamera(CameraUpdate.newLatLngZoom(userLatLng, 16));

      await _updateAddress();
    } catch (e) {
      setState(() {
        _address = "Failed to load location: $e";
      });
    }
  }

  Future<void> _updateAddress() async {
    final position = Position(
        altitudeAccuracy: 0,
        headingAccuracy: 0,
        latitude: _selectedLatLng.latitude,
        longitude: _selectedLatLng.longitude,
        timestamp: DateTime.now(),
        accuracy: 1,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0);

    final data = await LocationService.reverseGeocode(position);
    setState(() {
      _address = data['address']!;
      _city = data['city']!;
      _pincode = data['pincode']!;
    });
  }

  void _onCameraIdle() {
    mapController
        .getLatLng(
      ScreenCoordinate(x: 200, y: 400),
    )
        .then((center) {
      setState(() {
        _selectedLatLng = center;
      });
      _updateAddress();
    });
  }

  void _confirmLocation() {
    Navigator.pop(context, {
      'lat': _selectedLatLng.latitude,
      'lng': _selectedLatLng.longitude,
      'address': _address,
      'city': _city,
      'pincode': _pincode,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Location")),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: _selectedLatLng, zoom: 16),
            onMapCreated: (controller) => mapController = controller,
            onCameraIdle: _onCameraIdle,
            onCameraMove: (position) => _selectedLatLng = position.target,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          const Center(
              child: Icon(Icons.location_pin, size: 40, color: Colors.red)),
          Positioned(
            bottom: 100,
            left: 20,
            right: 20,
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(_address, textAlign: TextAlign.center),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 40,
            right: 40,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.check),
              label: const Text("Confirm Location"),
              onPressed: _confirmLocation,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}
