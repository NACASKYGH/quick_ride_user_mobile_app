import 'dart:ui';
import 'dart:async';
import 'package:gap/gap.dart';
import 'package:x_ride_user/di.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:x_ride_user/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:x_ride_user/utils/app_colors.dart';
import 'package:x_ride_user/utils/extensions.dart';
import 'package:x_ride_user/entity/osm_entity.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:x_ride_user/presentation/notifiers/ui_notifier.dart';
import 'package:x_ride_user/presentation/widget/app_text_field.dart';
import 'package:x_ride_user/presentation/widget/home_map_widget.dart';
import 'package:x_ride_user/presentation/widget/home_panel_widget.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PanelController _panelController = PanelController();
  final double _initFabHeight = 264.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  final double _panelHeightClosed = 250.0;

  MapController _mapController = MapController();
  late final StreamController<double?> _alignPositionStreamController;

  late Future<Position?> latlongFuture;
  LatLng? mapCentre;
  double dragPosition = 0;

  @override
  void initState() {
    _mapController = MapController();
    _fabHeight = _initFabHeight;
    _alignPositionStreamController = StreamController<double?>();

    latlongFuture = Utils.getCurrentPosLatLong();
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UiNotifier uiNotifier = context.watch<UiNotifier>();
    _panelHeightOpen = MediaQuery.of(context).size.height * .80;

    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            controller: _panelController,
            color: context.scaffoldColor,
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
            body: HomeMapWidget(
              mapController: _mapController,
              latlongFuture: latlongFuture,
              alignPositionStreamController: _alignPositionStreamController,
              onPositionChanged: (camera, hasGesture) {
                if (hasGesture &&
                    uiNotifier.alignPositionOnUpdate != AlignOnUpdate.never) {
                  uiNotifier.alignPositionOnUpdate = AlignOnUpdate.never;
                }
              },
            ),
            panelBuilder: (sc) => HomePanelWidget(
              scrollController: sc,
              dragPosition: dragPosition,
              onWhereToTapped: () => _panelController.open(),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0),
              topRight: Radius.circular(18.0),
            ),
            onPanelClosed: () {},
            onPanelSlide: (double pos) => setState(() {
              _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                  _initFabHeight;
              dragPosition = pos;
            }),
          ),

          // the fab
          Positioned(
            right: 20.0,
            bottom: _fabHeight,
            child: FloatingActionButton(
              heroTag: 'myCurrentLocation',
              onPressed: () async {
                uiNotifier.alignPositionOnUpdate = AlignOnUpdate.always;
                _alignPositionStreamController.add(16);
              },
              backgroundColor: context.scaffoldColor,
              mini: true,
              child: Icon(
                Icons.gps_fixed,
                color: context.colors.primary,
              ),
            ),
          ),

          Positioned(
            top: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).padding.top,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(microseconds: 5),
            top: -(1 - dragPosition) * 220,
            child: Container(
              decoration: BoxDecoration(
                color: context.scaffoldColor,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.grey1.withValues(alpha: .2),
                  ),
                ),
              ),
              height: 220,
              width: context.width,
              child: Opacity(
                opacity: dragPosition * dragPosition,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const Gap(kToolbarHeight),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => _panelController.close(),
                            icon: Icon(Icons.close),
                          ),
                        ],
                      ),
                      AppTextField(
                        prefixWidget: Icon(Icons.circle_outlined, size: 18),
                        bgColor: AppColors.grey1.withValues(alpha: .1),
                        borderColor: AppColors.transparent,
                        focusBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: context.colors.primary),
                        ),
                      ),
                      const Gap(6),
                      AppTextField(
                        prefixWidget: Icon(Icons.search_rounded, size: 24),
                        bgColor: AppColors.grey1.withValues(alpha: .1),
                        borderColor: AppColors.transparent,
                        focusBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: context.colors.primary),
                        ),
                        suffixWidget: GestureDetector(
                          onTap: () async {
                            PickedData? firstDropOff = await context
                                .pushNamed(RouteConsts.pickLocation);
                            logger.d(firstDropOff?.toJson());
                          },
                          child: Container(
                            height: 14,
                            width: 14,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: SvgPicture.asset(
                              'assets/svg/map-svgrepo-com.svg',
                            ),
                          ),
                        ),
                      ),
                      const Gap(6),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
