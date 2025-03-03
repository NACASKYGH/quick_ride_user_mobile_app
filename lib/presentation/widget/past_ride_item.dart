import '../../routes.dart';
import 'package:gap/gap.dart';
import '/utils/extensions.dart';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import '/presentation/widget/image_loader.dart';

class PastRideItem extends StatelessWidget {
  const PastRideItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: InkWell(
        onTap: () {
          context.pushNamed(RouteConsts.rideDetail);
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: context.colors.tertiary,
            ),
          ),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Maps
                  Container(
                    height: 150,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: IgnorePointer(
                      child: FlutterMap(
                        options: MapOptions(
                          initialCenter: const LatLng(50.5, 30.51),
                          initialZoom: 16.0,
                          maxZoom: 18,
                          minZoom: 6,
                        ),
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
                  ),

                  /// Ride Info
                  const Gap(12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text(
                      'Monday 22 Feb, 1:23PM',
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const Gap(12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text(
                      'Honda Civic • MHC-8213',
                      style: context.textTheme.labelSmall?.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Gap(12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text(
                      '₵9.12',
                      style: context.textTheme.headlineLarge?.copyWith(
                        fontSize: 22,
                        color: context.colors.primary,
                      ),
                    ),
                  ),
                  const Gap(12),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18, right: 6),
                child: ImageLoader(
                  height: 60,
                  width: 60,
                  radius: 60,
                  imageUrl: 'https://d1flfk77wl2xk4.cloudfront.'
                      'net/Assets/00/814/l_p0122481400.jpg',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
