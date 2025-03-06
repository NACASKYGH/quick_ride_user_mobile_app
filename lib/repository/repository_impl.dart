import 'package:dio/dio.dart';
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
}
