import 'package:dio/dio.dart';
import 'package:quick_ride_user/di.dart';
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
        AppUrl.getListBusAll,
        data: {
          'SourceID': fromID,
          'DestinationID': toID,
          'TransportID': companyId,
          'TravelDate': travelDate,
        },
        options: Options(
          headers: {
            'APITocken': await _dynamicToken.call(),
            'AppType': 'POS',
            'Content-Type': 'application/json',
          },
        ),
      ))
          .data;

      if (result['success'] == true) {
        return (result['SearchDetail'] as Iterable)
            .map((e) => BusInfoEntity.fromJson(e))
            .toList();
      } else {
        throw result['Message'];
      }
    } on DioException catch (e) {
      throw e.formartedError;
    } catch (e) {
      throw e.toString();
    }
  }
}
