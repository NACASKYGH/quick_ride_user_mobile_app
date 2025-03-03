import '../entity/bus_info_entity.dart';

abstract class Repository {
  Future<List<BusInfoEntity>> searchTravelResult({
    required String from,
    required String to,
    required String date,
  });
}
