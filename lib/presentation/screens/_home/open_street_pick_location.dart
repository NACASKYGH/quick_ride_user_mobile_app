import 'dart:async';
import 'package:dio/dio.dart';
import 'package:gap/gap.dart';
import '../../widget/app_button.dart';
import '../../../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../../../utils/app_colors.dart';
import '../../../entity/osm_entity.dart';
import 'package:go_router/go_router.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:x_ride_user/utils/utilities.dart';
import 'package:x_ride_user/utils/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:x_ride_user/presentation/notifiers/map_notifier.dart';
import 'package:x_ride_user/presentation/widget/circular_icon_btn.dart';

class OpenStreetPickLocation extends StatefulWidget {
  const OpenStreetPickLocation({
    super.key,
  });

  @override
  State<OpenStreetPickLocation> createState() => _OpenStreetPickLocationState();
}

class _OpenStreetPickLocationState extends State<OpenStreetPickLocation>
    with TickerProviderStateMixin {
  final String baseUri = 'https://nominatim.openstreetmap.org';
  PickedData? pickedData;

  MapController _mapController = MapController();
  Position? currentLocation;
  bool initialRun = true;

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _mapController = MapController();
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _mapController.mapEventStream.listen(
        (event) async {
          if (!mounted) return;
          if (event is MapEventMoveStart || event.isZoomStart) {
            if (!context.read<MapNotifier>().isMapMoving) {
              context.read<MapNotifier>().isMapMoving = true;
            }
          }
          if (event is MapEventMoveEnd || event.isZoomEnd) {
            if (context.read<MapNotifier>().isMapMoving) {
              context.read<MapNotifier>().isMapMoving = false;
            }
            pickData(
              center: LatLong(
                lat: event.camera.center.latitude,
                lon: event.camera.center.longitude,
              ),
            );
          }
        },
      );
    });
  }

  Future<PickedData?> pickData({LatLong? center, int? zoom}) async {
    context.read<MapNotifier>().isPickLocLoading = true;
    String url = '$baseUri/reverse?format=json&'
        'lat=${center?.lat ?? _mapController.camera.center.latitude}&'
        'lon=${center?.lon ?? _mapController.camera.center.longitude}&'
        'zoom=${zoom ?? _mapController.camera.zoom.toInt()}'
        '&addressdetails=1';
    var response = await Dio().get(url);
    pickedData = PickedData.fromJson(response.data);
    if (mounted) context.read<MapNotifier>().isPickLocLoading = false;
    return pickedData;
  }

  Future<Position?> getPosition() async {
    currentLocation = await Utils.getCurrentPosLatLong();
    if (currentLocation != null && initialRun) {
      initialRun = false;
      pickData(
        center: LatLong(
            lat: currentLocation!.latitude, lon: currentLocation!.longitude),
        zoom: 16,
      );
    }
    return currentLocation;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position?>(
      future: getPosition(),
      builder: (context, snapshot) {
        LatLng? mapCentre;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }
        if (snapshot.hasData && snapshot.data != null) {
          mapCentre = LatLng(snapshot.data!.latitude, snapshot.data!.longitude);
        }

        return Scaffold(
          body: SafeArea(
            top: false,
            child: Stack(
              children: [
                /// Flutter map view
                Positioned.fill(
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: mapCentre ?? const LatLng(50.5, 30.51),
                      initialZoom: 16.0,
                      maxZoom: 18,
                      minZoom: 6,
                    ),
                    mapController: _mapController,
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        tileBuilder: context.isDarkMode
                            ? (context, tileWidget, tile) {
                                return darkMapFilter(tileWidget);
                              }
                            : null,
                      ),
                    ],
                  ),
                ),

                /// Location picker pin
                Positioned.fill(
                  child: IgnorePointer(
                    child: Center(
                      child: Consumer<MapNotifier>(
                          builder: (context, notifier, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  notifier.isMapMoving
                                      ? BoxShadow(
                                          color: Colors.grey
                                              .withValues(alpha: 0.5),
                                          spreadRadius: 20,
                                          blurRadius: 20,
                                          offset: Offset(0, 8),
                                        )
                                      : BoxShadow(
                                          color: Colors.grey
                                              .withValues(alpha: 0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 5),
                                        ),
                                ],
                              ),
                              child: Icon(
                                Icons.circle,
                                color: AppColors.red,
                                size: 5,
                              ),
                            ),
                            // Pin leg
                            AnimatedPadding(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.linear,
                              padding: EdgeInsets.only(
                                bottom: notifier.isMapMoving ? 44 : 20,
                              ),
                              child: Container(
                                width: 2,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: context.colors.inverseSurface,
                                ),
                              ),
                            ),

                            /// Pin head
                            AnimatedPadding(
                              duration: const Duration(milliseconds: 320),
                              curve: Curves.bounceOut,
                              padding: EdgeInsets.only(
                                bottom: notifier.isMapMoving ? 90 : 60,
                              ),
                              child: Container(
                                height: 40,
                                width: 40,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: context.colors.inverseSurface,
                                    shape: BoxShape.circle,
                                  ),
                                  child: notifier.isPickLocLoading
                                      ? CircularProgressIndicator()
                                      : SizedBox.shrink(),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),

                /// Confirmation Button && Fab button
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      /// Current location fab
                      Padding(
                        padding: const EdgeInsets.only(right: 14.0, bottom: 14),
                        child: FloatingActionButton(
                          heroTag: 'pickMyLocation',
                          onPressed: () async {
                            Position? position =
                                await Utils.getCurrentPosLatLong();
                            if (position == null) return;

                            await Utils.animatedMapMove(
                              zoom: 16,
                              mapController: _mapController,
                              center: LatLng(
                                position.latitude,
                                position.longitude,
                              ),
                              vsync: this,
                            );
                            await pickData();
                          },
                          backgroundColor: context.scaffoldColor,
                          mini: true,
                          child: Icon(
                            Icons.gps_fixed,
                            color: context.colors.primary,
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 45),
                        decoration: BoxDecoration(
                          color: context.scaffoldColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: Consumer<MapNotifier>(
                          builder: (context, notifier, child) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Gap(18),
                                Text(
                                  pickedData?.findName ??
                                      'home.pickLocInstruction'.tr(),
                                  textAlign: TextAlign.center,
                                  style:
                                      context.textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                const Gap(18),
                                AppButton(
                                  title: 'home.confirmLocation',
                                  radius: 50,
                                  isLoading: notifier.isPickLocLoading,
                                  onTap: () async {
                                    final pickedData = await pickData();
                                    if (context.mounted) {
                                      context.pop(pickedData);
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  top: 52,
                  left: 14,
                  child: CircularIconBtn(
                    onTap: () => context.pop(),
                    bgColor: context.colors.surface,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
