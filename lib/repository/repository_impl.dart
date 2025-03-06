import 'package:dio/dio.dart';
import '../entity/bus_seat_entity.dart';
import 'package:quick_ride_user/di.dart';
import 'package:quick_ride_user/utils/extensions.dart';
import 'package:quick_ride_user/repository/repository.dart';
import 'package:quick_ride_user/entity/bus_info_entity.dart';

class RepositoryImpl implements Repository {
  final AuthTokenGetter _getToken;
  final Dio _dioInstance;

  RepositoryImpl(
    this._dioInstance, {
    required AuthTokenGetter token,
  }) : _getToken = token;

  @override
  Future<List<BusInfoEntity>> searchTravelResult({
    required String from,
    required String to,
    required String date,
  }) async {
    try {
      final result = (await _dioInstance.post(
        '/Data/API_GetListBusAllWebMobAppWild',
        data: {
          'SourceName': 'Acc',
          'DestinationName': 'Ku',
          'TravelDate': date,
        },
        options: Options(
          headers: {
            'APITocken': '9D85A0FB-73E1-413C-BC2C-C95DDCD9CD89',
            'AppType': 'MOBAND',
            'Content-Type': 'application/json',
          },
        ),
      ))
          .data;

      return (result as Iterable)
          .map((e) => BusInfoEntity.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw e.formattedError;
    } catch (e) {
      throw e.toString();
    }
  }

  ///
  @override
  Future<List<BusSeatEntity>> getBusSeats({
    required String fromId,
    required String toId,
    required num tripId,
    required String travelDate,
  }) async {
    try {
      final result = (await _dioInstance.post(
        '/Data2/API_SeatArragement',
        data: {
          'SourceID': fromId,
          'DestinationID': toId,
          'TripID': tripId,
          'TravelDate': travelDate,
        },
        options: Options(
          headers: {
            'APITocken': '9D85A0FB-73E1-413C-BC2C-C95DDCD9CD89',
            'AppType': 'MOBAND',
            'Content-Type': 'application/json',
          },
        ),
      ))
          .data;

      if (result['success'] == true) {
        return (result['SeatArragement'] as Iterable)
            .map((e) => BusSeatEntity.fromJson(e))
            .toList();
      } else {
        throw result['Message'];
      }
    } on DioException catch (e) {
      throw e.formattedError;
    } catch (e) {
      throw e.toString();
    }
  }
}
