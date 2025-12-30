import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  LatLng _currentPosition = const LatLng(28.0339, 1.6596); // Default: Algeria Center
  bool _isLoading = false;

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);
    
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('خدمة الموقع غير مفعلة. الرجاء تفعيلها.'),
        ));
        setState(() => _isLoading = false);
      }
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
         if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('تم رفض إذن الموقع.'),
          ));
          setState(() => _isLoading = false);
        }
        return;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
       if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('إذن الموقع مرفوض بشكل دائم.'),
        ));
        setState(() => _isLoading = false);
      }
      return;
    } 

    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });
      _mapController.move(_currentPosition, 15.0);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('فشل تحديد الموقع: $e'),
        ));
         setState(() => _isLoading = false);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("خريطة الطوارئ"), // Emergency Map
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _getCurrentLocation,
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentPosition,
              initialZoom: 5.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.civil_defense_app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _currentPosition,
                    width: 80,
                    height: 80,
                    child: const Icon(
                      Icons.location_on,
                      color: Color(0xFFB71C1C),
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(
                    "تم إرسال البلاغ من الموقع:\\n${_currentPosition.latitude}, ${_currentPosition.longitude}"
                  )),
                );
              },
              icon: const Icon(Icons.send, size: 28),
              label: const Text("إرسال بلاغ", style: TextStyle(fontSize: 24)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB71C1C), // Red
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
