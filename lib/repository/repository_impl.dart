import 'package:dio/dio.dart';
import '../entity/bus_seat_entity.dart';
import 'package:quick_ride_user/di.dart';
import 'package:quick_ride_user/entity/app_user.dart';
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

  ///
  @override
  Future<String> checkIfExistingUser({
    required String phone,
  }) async {
    try {
      final result = (await _dioInstance.post(
        '/Data/API_CheckMobileNo',
        data: {
          'MobileNo': phone,
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
      logger.d(result);

      if (result['success'] == true) {
        return result['MobileLoginInformations'][0]['Msg'];
      } else {
        throw result['Message'];
      }
    } on DioException catch (e) {
      throw e.formattedError;
    } catch (e) {
      throw e.toString();
    }
  }

  ///
  @override
  Future<AppUser> login({
    required String phone,
    required String password,
  }) async {
    try {
      final result = (await _dioInstance.post(
        '/Data2/API_LoginWithPassword',
        data: {
          'MobileNo': phone,
          'Password': password,
          'AppType': 'MOBAND',
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
        return AppUser.fromJson(result['UserLoginInformations'][0]);
      } else {
        throw result['Message'];
      }
    } on DioException catch (e) {
      throw e.formattedError;
    } catch (e) {
      throw e.toString();
    }
  }

  ///
  @override
  Future<AppUser> signup({required Map<String, dynamic> map}) async {
    try {
      final result = (await _dioInstance.post(
        '/Data/API_AddNewUser',
        data: map,
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
        return AppUser.fromJson(result['UserLoginInformations'][0]);
      } else {
        throw result['Message'];
      }
    } on DioException catch (e) {
      throw e.formattedError;
    } catch (e) {
      throw e.toString();
    }
  }

  ///
  @override
  Future<AppUser> getUser({
    required String id,
  }) async {
    AppUser? appuser = (await _getToken());
    if (appuser == null) throw 'Login required';
    try {
      final result = (await _dioInstance.post(
        '/Passenger/API_GetPassenger',
        data: {
          'PassID': id,
        },
        options: Options(
          headers: {
            'APITocken': appuser.token,
            'AppType': 'MOBAND',
            'Content-Type': 'application/json',
          },
        ),
      ))
          .data;

      if (result['success'] == true) {
        final map = result['UserLoginInformations'][0];
        return appuser.copyWith(
          name: map['Name'],
          email: map['EmailID'],
          phone: map['MobileNo'],
          gender: map['Gender'],
          dateOfBirth: map['DOB'],
          avatar: map['PhotoPic'],
        );
      } else {
        throw result['Message'];
      }
    } on DioException catch (e) {
      throw e.formattedError;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<AppUser> updateUser({
    required String name,
    required String email,
    required String gender,
    required String date,
  }) async {
    AppUser? appuser = (await _getToken());
    if (appuser == null) throw 'Login required';

    try {
      final result = (await _dioInstance.post(
        '/Passenger/API_UpdateProfile',
        data: {
          'ID': appuser.id,
          'Name': name,
          'DOB': date,
          'Gender': gender,
          'EmailID': email,
          'MobileNo': '',
        },
        options: Options(
          headers: {
            'APITocken': appuser.token,
            'AppType': 'MOBAND',
            'Content-Type': 'application/json',
          },
        ),
      ))
          .data;

      if (result['success'] == true) {
        return await getUser(id: appuser.id!);
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
