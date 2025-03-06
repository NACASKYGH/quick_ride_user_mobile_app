import '../entity/bus_info_entity.dart';
import '../entity/bus_seat_entity.dart';

abstract class Repository {
  Future<List<BusInfoEntity>> searchTravelResult({
    required String from,
    required String to,
    required String date,
  });

  Future<List<BusSeatEntity>> getBusSeats({
    required String fromId,
    required String toId,
    required num tripId,
    required String travelDate,
  });
}
