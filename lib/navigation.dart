import 'dart:math';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:easy_localization/easy_localization.dart';

class NavigationService {
  final FlutterTts _tts = FlutterTts();
  final Dio _dio = Dio();
  final String _apiKey = 'e73070db-21c9-46aa-9b0c-efb5c564706d';

  Future<void> speakInstruction(String instruction) async {
    await _tts.speak(instruction);
  }

  Future<List<Map<String, dynamic>>> getRoutes(LatLng start, LatLng end) async {
    try {
      final response = await _dio.get(
        'https://graphhopper.com/api/1/route',
        queryParameters: {
          'point': [
            '${start.latitude},${start.longitude}',
            '${end.latitude},${end.longitude}'
          ],
          'vehicle': 'car',
          'locale': 'en',
          'points_encoded': 'false',
          'instructions': 'true',
          'algorithm': 'alternative_route',
          'alternative_route.max_paths': '3',
          'key': _apiKey,
        },
      );

      return (response.data['paths'] as List)
          .take(3)
          .map((path) => _parsePath(path))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch routes: ${e.toString()}');
    }
  }

  Map<String, dynamic> _parsePath(dynamic path) {
    return {
      'route': (path['points']['coordinates'] as List)
          .map((p) => LatLng(p[1] as double, p[0] as double))
          .toList(),
      'duration': (path['time'] / 60000).toStringAsFixed(1),
      'distance': (path['distance'] / 1000).toStringAsFixed(1),
      'instructions': path['instructions'] ?? [],
    };
  }
}

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final NavigationService _service = NavigationService();
  final MapController _mapController = MapController();
  final Random _random = Random();

  Position? _currentPosition;
  List<Map<String, dynamic>> _routes = [];
  int _activeRouteIndex = 0;
  bool _isNavigating = false;
  bool _isSimulating = false;
  bool _isFetching = false;
  double _currentSpeed = 0.0;
  DateTime? _eta;
  double _remainingDistance = 0.0;
  String _nextInstruction = '';
  double _nextTurnDistance = 0.0;
  final String _streetName = '';
  StreamSubscription<Position>? _positionSub;
  Timer? _simulationTimer;
  List<LatLng> _simulationPoints = [];
  int _lastSpokenInstructionIndex = -1;
  final double _simulationSpeed = 1.0;
  double _simulationProgress = 0.0;
  List<Map<String, dynamic>> _cachedRoutes = [];

  @override
  void initState() {
    super.initState();
    _initializePosition();
  }

  Future<void> _initializePosition() async {
    try {
      _currentPosition = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation,
        ),
      );
      setState(() {});
    } catch (e) {
      _service.speakInstruction('Enable location services to continue');
    }
  }

  Future<void> _fetchRoutes(LatLng destination) async {
    setState(() => _isFetching = true);
    try {
      final routes = await _service.getRoutes(
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        destination,
      );

      if (routes.isEmpty) {
        _service.speakInstruction('No routes found. Try different locations.');
        return;
      }

      setState(() {
        _routes = routes;
        _cachedRoutes = routes;
        _activeRouteIndex = 0;
        _fitBounds();
      });
    } catch (e) {
      _service.speakInstruction('Route update failed. Using cached routes.');
      _useCachedRoutes();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
    setState(() => _isFetching = false);
  }

  void _useCachedRoutes() {
    if (_cachedRoutes.isNotEmpty) {
      setState(() {
        _routes = _cachedRoutes;
        _activeRouteIndex = 0;
        _fitBounds();
      });
    }
  }

  void _startNavigation() {
    if (_routes.isEmpty) return;

    setState(() {
      _isNavigating = true;
      _remainingDistance =
          double.parse(_routes[_activeRouteIndex]['distance']) * 1000;
      _eta = DateTime.now().add(
          Duration(minutes: int.parse(_routes[_activeRouteIndex]['duration'])));
    });
    _positionSub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 5,
      ),
    ).listen(_updatePosition);
  }

  void _stopNavigation() {
    _positionSub?.cancel();
    _stopSimulation();
    setState(() {
      _isNavigating = false;
      _eta = null;
    });
  }

  void _toggleSimulation() {
    if (_routes.isEmpty || !_isNavigating) return;
    setState(() => _isSimulating = !_isSimulating);
    _isSimulating ? _startSimulation() : _stopSimulation();
  }

  void _startSimulation() {
    _simulationPoints = _routes[_activeRouteIndex]['route'].cast<LatLng>();
    _simulationProgress = 0.0;
    _positionSub?.cancel();

    final totalPoints = _simulationPoints.length;

    _simulationTimer =
        Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_simulationProgress >= totalPoints - 1) {
        _stopSimulation();
        return;
      }

      _simulationProgress += _simulationSpeed * 0.1;
      final index = _simulationProgress.floor();
      final fraction = _simulationProgress - index;

      if (index < _simulationPoints.length - 1) {
        final p1 = _simulationPoints[index];
        final p2 = _simulationPoints[index + 1];
        final lat = p1.latitude + (p2.latitude - p1.latitude) * fraction;
        final lng = p1.longitude + (p2.longitude - p1.longitude) * fraction;

        _updateSimulatedPosition(LatLng(lat, lng));
      }
    });
  }

  void _stopSimulation() {
    _simulationTimer?.cancel();
    setState(() => _isSimulating = false);
    if (_isNavigating) {
      _positionSub = Geolocator.getPositionStream().listen(_updatePosition);
    }
  }

  void _updatePosition(Position position) {
    if (!_isNavigating || _isSimulating) return;
    setState(() => _currentPosition = position);
    _updateNavigationData(position);
  }

  void _updateSimulatedPosition(LatLng point) {
    final pos = Position(
      latitude: point.latitude,
      longitude: point.longitude,
      timestamp: DateTime.now(),
      accuracy: 5,
      altitude: 0,
      heading: _random.nextDouble() * 360,
      speed: _simulationSpeed * 0.27778,
      speedAccuracy: 0,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );

    setState(() => _currentPosition = pos);
    _updateNavigationData(pos);

    final camera = _mapController.camera;
    final targetCenter = LatLng(pos.latitude, pos.longitude);
    final newCenter = LatLng(
      camera.center.latitude +
          (targetCenter.latitude - camera.center.latitude) * 0.3,
      camera.center.longitude +
          (targetCenter.longitude - camera.center.longitude) * 0.3,
    );

    _mapController.move(newCenter, camera.zoom);
  }

  void _updateNavigationData(Position position) {
    final route = _routes[_activeRouteIndex];
    final currentPoint = LatLng(position.latitude, position.longitude);

    int closestIndex = _findClosestPointIndex(currentPoint, route['route']);
    int currentInstrIndex =
        _findCurrentInstructionIndex(closestIndex, route['instructions']);

    if (currentInstrIndex != _lastSpokenInstructionIndex) {
      _handleNewInstruction(currentInstrIndex, route['instructions']);
    }

    _checkApproachingInstructions(currentPoint, route);
    _checkArrival(currentPoint, route['route'].last);

    setState(() {
      _currentSpeed = position.speed * 3.6;
      // _remainingDistance = _calculateDistance(
      //   route["route"].sublist(closestIndex)
      // );
    });
  }

  int _findClosestPointIndex(LatLng position, List<LatLng> routePoints) {
    int closestIndex = 0;
    double minDistance = double.maxFinite;
    for (int i = 0; i < routePoints.length; i++) {
      double distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        routePoints[i].latitude,
        routePoints[i].longitude,
      );
      if (distance < minDistance) {
        minDistance = distance;
        closestIndex = i;
      }
    }
    return closestIndex;
  }

  int _findCurrentInstructionIndex(
      int closestIndex, List<dynamic> instructions) {
    for (int i = 0; i < instructions.length; i++) {
      var instr = instructions[i];
      List<int> interval = List<int>.from(instr['interval']);
      if (closestIndex >= interval[0] && closestIndex <= interval[1]) {
        return i;
      }
    }
    return -1;
  }

  void _handleNewInstruction(int index, List<dynamic> instructions) {
    if (index == -1) return;

    setState(() => _lastSpokenInstructionIndex = index);
    _service.speakInstruction(instructions[index]['text']);

    if (index < instructions.length - 1) {
      _nextInstruction = instructions[index + 1]['text'];
      _nextTurnDistance = _calculateDistanceToNextInstruction(_currentPosition!,
          instructions[index + 1], _routes[_activeRouteIndex]['route']);
    }
  }

  double _calculateDistanceToNextInstruction(
      Position position, dynamic instruction, List<LatLng> route) {
    final interval = List<int>.from(instruction['interval']);
    final startPoint = route[interval[0]];
    return Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      startPoint.latitude,
      startPoint.longitude,
    );
  }

  void _checkApproachingInstructions(
      LatLng currentPoint, Map<String, dynamic> route) {
    final instructions = route['instructions'];
    final routePoints = route['route'];

    if (_lastSpokenInstructionIndex < instructions.length - 1) {
      var nextInstr = instructions[_lastSpokenInstructionIndex + 1];
      final interval = List<int>.from(nextInstr['interval']);
      final startPoint = routePoints[interval[0]];

      double distance = Geolocator.distanceBetween(
        currentPoint.latitude,
        currentPoint.longitude,
        startPoint.latitude,
        startPoint.longitude,
      );

      if (distance < 100) {
        _service.speakInstruction("Approaching ${nextInstr["text"]}");
      }
    }
  }

  void _checkArrival(LatLng currentPoint, LatLng destination) {
    double distance = Geolocator.distanceBetween(
      currentPoint.latitude,
      currentPoint.longitude,
      destination.latitude,
      destination.longitude,
    );

    if (distance < 50) {
      _service.speakInstruction('You have arrived at your destination');
      _stopNavigation();
    }
  }

  void _fitBounds() {
    if (_routes.isEmpty) return;
    final bounds = LatLngBounds.fromPoints(_routes[_activeRouteIndex]['route']);
    _mapController.fitCamera(
      CameraFit.bounds(
        bounds: bounds,
        padding: const EdgeInsets.all(100),
      ),
      // animation: const CameraAnimationOptions(
      //   duration: Duration(milliseconds: 500),
      //   curve: Curves.easeInOut,
      // ),
    );
  }

  @override
  void dispose() {
    _positionSub?.cancel();
    _simulationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildMap(),
          _buildTopBanner(),
          _buildControls(),
          _buildBottomPanel(),
          _buildSimulationToggle(),
          if (_isFetching) _buildLoading(),
        ],
      ),
      floatingActionButton: _buildFABs(),
    );
  }

  Widget _buildMap() {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: _currentPosition != null
            ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
            : const LatLng(0, 0),
        initialZoom: 16,
        onTap: (_, latLng) => _handleMapTap(latLng),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
        ),
        ..._routes.where((r) => _routes.indexOf(r) != _activeRouteIndex).map(
              (route) => GestureDetector(
                onTap: () => _setActiveRoute(_routes.indexOf(route)),
                child: PolylineLayer(
                  key: ValueKey('inactive_${_routes.indexOf(route)}'),
                  polylines: [
                    Polyline(
                      points: route['route'],
                      strokeWidth: 20,
                      color: Colors.transparent,
                    ),
                    Polyline(
                      points: route['route'],
                      strokeWidth: 4,
                      color: Colors.grey.withValues(alpha: .5),
                    ),
                  ],
                ),
              ),
            ),
        if (_routes.isNotEmpty)
          GestureDetector(
            onTap: () => _setActiveRoute(_activeRouteIndex),
            child: PolylineLayer(
              key: ValueKey('active_$_activeRouteIndex'),
              polylines: [
                Polyline(
                  points: _routes[_activeRouteIndex]['route'],
                  strokeWidth: 20,
                  color: Colors.transparent,
                ),
                Polyline(
                  points: _routes[_activeRouteIndex]['route'],
                  strokeWidth: 6,
                  color: Colors.blue,
                  strokeCap: StrokeCap.round,
                ),
              ],
            ),
          ),
        ..._routes.map(
            (route) => _buildDurationMarker(route, _routes.indexOf(route))),
        _buildCurrentMarker(),
        _buildStreetMarker(),
      ],
    );
  }

  void _handleMapTap(LatLng tappedPoint) {
    double minDistance = double.infinity;
    int closestIndex = -1;

    for (int i = 0; i < _routes.length; i++) {
      final routePoints = _routes[i]['route'] as List<LatLng>;
      double routeDistance = _calculateMinDistance(tappedPoint, routePoints);

      if (routeDistance < minDistance) {
        minDistance = routeDistance;
        closestIndex = i;
      }
    }

    if (closestIndex != -1 && minDistance < 50) {
      _setActiveRoute(closestIndex);
    }
  }

  double _calculateMinDistance(LatLng point, List<LatLng> route) {
    double minDistance = double.infinity;
    for (int i = 0; i < route.length - 1; i++) {
      final distance = _distanceToSegment(point, route[i], route[i + 1]);
      if (distance < minDistance) {
        minDistance = distance;
      }
    }
    return minDistance;
  }

  double _distanceToSegment(LatLng p, LatLng a, LatLng b) {
    final lat1 = a.latitude;
    final lon1 = a.longitude;
    final lat2 = b.latitude;
    final lon2 = b.longitude;
    final lat3 = p.latitude;
    final lon3 = p.longitude;

    final denominator = Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
    if (denominator == 0) {
      return Geolocator.distanceBetween(lat3, lon3, lat1, lon1);
    }

    final t = ((lat3 - lat1) * (lat2 - lat1) + (lon3 - lon1) * (lon2 - lon1)) /
        (pow(lat2 - lat1, 2) + pow(lon2 - lon1, 2));

    final clampedT = t.clamp(0.0, 1.0);
    final nearestLat = lat1 + clampedT * (lat2 - lat1);
    final nearestLon = lon1 + clampedT * (lon2 - lon1);

    return Geolocator.distanceBetween(lat3, lon3, nearestLat, nearestLon);
  }

  void _setActiveRoute(int index) {
    setState(() {
      _activeRouteIndex = index;
      if (_isNavigating) {
        _remainingDistance = double.parse(_routes[index]['distance']) * 1000;
        _eta = DateTime.now()
            .add(Duration(minutes: int.parse(_routes[index]['duration'])));
      }
    });

    final bounds = LatLngBounds.fromPoints(_routes[index]['route']);
    _mapController.fitCamera(
      CameraFit.bounds(
        bounds: bounds,
        padding: const EdgeInsets.all(100),
      ),
      // animation: const CameraAnimationOptions(
      //   duration: Duration(milliseconds: 500),
      //   curve: Curves.easeInOut,
      // ),
    );
  }

  Widget _buildDurationMarker(Map<String, dynamic> route, int index) {
    return MarkerLayer(
      key: ValueKey('duration_$index'),
      markers: [
        Marker(
          point: _getLabelPosition(route['route']),
          width: 80,
          height: 32,
          child: GestureDetector(
            onTap: () => _setActiveRoute(index),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: index == _activeRouteIndex
                    ? Colors.blue.shade900
                    : Colors.grey.shade700,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                "${route["duration"]} min",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LatLng _getLabelPosition(List<LatLng> route) {
    return route.length > 1 ? route[route.length ~/ 3] : route.first;
  }

  Widget _buildCurrentMarker() {
    return MarkerLayer(
      markers: [
        if (_currentPosition != null)
          Marker(
            point:
                LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
            width: 40,
            height: 40,
            child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
          ),
      ],
    );
  }

  Widget _buildStreetMarker() {
    return MarkerLayer(
      markers: [
        if (_streetName.isNotEmpty)
          Marker(
            point:
                LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
            width: 150,
            height: 40,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 8)
                ],
              ),
              child: Text(
                _streetName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTopBanner() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 20,
      left: 20,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _isNavigating && _nextInstruction.isNotEmpty
            ? Container(
                key: ValueKey(_nextInstruction),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 10)
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.directions, color: Colors.green, size: 28),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'In ${_nextTurnDistance.toStringAsFixed(0)}m',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          _nextInstruction,
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          _streetName,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  Widget _buildControls() {
    return Positioned(
      right: 20,
      bottom: 200,
      child: Column(
        children: [
          FloatingActionButton(
            mini: true,
            heroTag: 'recenter',
            onPressed: () => _mapController.move(
              LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
              _mapController.camera.zoom,
            ),
            child: const Icon(Icons.my_location),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              FloatingActionButton(
                mini: true,
                heroTag: 'zoom_in',
                onPressed: () => _mapController.move(
                  _mapController.camera.center,
                  _mapController.camera.zoom + 1,
                ),
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                mini: true,
                heroTag: 'zoom_out',
                onPressed: () => _mapController.move(
                  _mapController.camera.center,
                  _mapController.camera.zoom - 1,
                ),
                child: const Icon(Icons.remove),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPanel() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 15)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildInfoTile(Icons.timer, 'ETA',
                DateFormat('h:mm a').format(_eta ?? DateTime.now())),
            _buildInfoTile(Icons.speed, 'Speed',
                '${_currentSpeed.toStringAsFixed(0)} km/h'),
            _buildInfoTile(Icons.directions_car, 'Remaining',
                '${(_remainingDistance / 1000).toStringAsFixed(1)} km'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.blue, size: 28),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }

  Widget _buildSimulationToggle() {
    return Positioned(
      bottom: 150,
      left: 20,
      child: Row(
        children: [
          FloatingActionButton(
            mini: true,
            heroTag: 'simulation',
            onPressed: _isNavigating ? _toggleSimulation : null,
            backgroundColor: _isSimulating ? Colors.red : Colors.green,
            child: Icon(_isSimulating ? Icons.stop : Icons.directions_car),
          ),
          const SizedBox(width: 10),
          if (_isSimulating)
            Text(
              'Simulation: ${_currentSpeed.toStringAsFixed(1)} km/h',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.black, blurRadius: 3)],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildFABs() {
    return Stack(
      children: [
        Positioned(
          bottom: 20,
          right: 20,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                heroTag: 'fetch_routes',
                onPressed: () => _fetchRoutes(
                    const LatLng(5.6756723715960495, -0.19368805900030137)),
                backgroundColor: Colors.blue,
                child: const Icon(Icons.route),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                heroTag: 'navigation',
                onPressed: _routes.isNotEmpty
                    ? () =>
                        _isNavigating ? _stopNavigation() : _startNavigation()
                    : null,
                backgroundColor: _isNavigating ? Colors.red : Colors.green,
                child: Icon(_isNavigating ? Icons.stop : Icons.navigation),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

void main() => runApp(MaterialApp(home: NavigationScreen()));
