import 'dart:async';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:x_ride_user/utils/extensions.dart';
import 'package:x_ride_user/presentation/notifiers/ui_notifier.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class HomeMapWidget extends StatefulWidget {
  const HomeMapWidget({
    super.key,
    required this.mapController,
    required this.latlongFuture,
    required this.onPositionChanged,
    required this.alignPositionStreamController,
  });

  final MapController mapController;
  final Future<Position?> latlongFuture;
  final Function(MapCamera, bool) onPositionChanged;

  final StreamController<double?> alignPositionStreamController;

  @override
  State<HomeMapWidget> createState() => _HomeMapWidgetState();
}

class _HomeMapWidgetState extends State<HomeMapWidget> {
  @override
  Widget build(BuildContext context) {
    UiNotifier uiNotifier = context.watch<UiNotifier>();
    return FutureBuilder<Position?>(
      future: widget.latlongFuture,
      builder: (context, snapshot) {
        LatLng? mapCentre;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Something went wrong',
              style: context.textTheme.labelMedium,
            ),
          );
        }

        if (snapshot.hasData && snapshot.data != null) {
          mapCentre = LatLng(snapshot.data!.latitude, snapshot.data!.longitude);
        }

        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: mapCentre ?? const LatLng(50.5, 30.51),
                    initialZoom: 17.0,
                    maxZoom: 18,
                    minZoom: 6,
                    onPositionChanged: widget.onPositionChanged,
                  ),
                  mapController: widget.mapController,
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      maxZoom: 19,
                      tileBuilder: context.isDarkMode
                          ? (context, tileWidget, tile) {
                              return darkMapFilter(tileWidget);
                            }
                          : null,
                    ),
                    CurrentLocationLayer(
                      alignPositionOnUpdate: uiNotifier.alignPositionOnUpdate,
                      alignPositionStream:
                          widget.alignPositionStreamController.stream,
                      alignPositionAnimationDuration:
                          const Duration(milliseconds: 1900),
                      moveAnimationDuration: const Duration(milliseconds: 2000),
                      alignDirectionAnimationDuration:
                          const Duration(milliseconds: 2000),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
