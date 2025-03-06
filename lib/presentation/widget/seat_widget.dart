import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../notifiers/buses_notifier.dart';
import '../../entity/bus_seat_entity.dart';


class SeatWidget extends StatefulWidget {
  const SeatWidget({
    super.key,
    required this.seatEntity,
  });

  final BusSeatEntity seatEntity;

  @override
  State<SeatWidget> createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget> {
  (String, bool) showBusSeatIcon(BusSeatEntity seat) =>
      (seat.position ?? '').trim().isEmpty //Empty space / No seat
          ? ('', false)
          : seat.blockSeat == '1' //Second driver
              ? ('assets/svg/locked-seat.svg', false)
              : seat.blockSeat == '2' //Escort driver
                  ? ('assets/svg/locked-seat.svg', false)
                  : seat.blockSeat == '3' // Mate
                      ? ('assets/svg/locked-seat.svg', false)
                      : seat.bookStatus == '1'
                          ? ('assets/svg/booked-seat.svg', false)
                          : ('assets/svg/empty-seat.svg', true);

  @override
  Widget build(BuildContext context) {
    BusesNotifier busesNotifier = context.watch<BusesNotifier>();

    (String, bool) action = showBusSeatIcon(widget.seatEntity);
    bool isSpace = action.$1.isEmpty;
    bool isSel = busesNotifier.selectedSeats.contains(widget.seatEntity);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(3),
        onTap: !action.$2
            ? null
            : () {
                if (busesNotifier.selectedSeats.contains(widget.seatEntity)) {
                  busesNotifier.removeSeat = widget.seatEntity;
                } else {
                  busesNotifier.selectSeat = widget.seatEntity;
                }
                setState(() {});
              },
        child: Container(
          alignment: Alignment.center,
          height: 32,
          width: 30,
          margin: const EdgeInsets.only(bottom: 4),
          child: isSpace
              ? const SizedBox.shrink()
              : isSel
                  ? SvgPicture.asset('assets/svg/selected-seat.svg')
                  : SvgPicture.asset(action.$1),
        ),
      ),
    );
  }
}
