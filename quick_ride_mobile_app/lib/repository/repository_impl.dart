import '../di.dart';
import 'package:dio/dio.dart';
import '../entity/app_user.dart';
import '../utils/extensions.dart';
import '../entity/ticket_entity.dart';
import '../repository/repository.dart';
import '../entity/bus_seat_entity.dart';
import '../entity/bus_info_entity.dart';
import '../entity/book_bus_ticket_entity.dart';
import '../entity/cancelled_ticket_entity.dart';

class RepositoryImpl implements Repository {
  final AuthTokenGetter _getToken;
  final Dio _dioInstance;

  RepositoryImpl(this._dioInstance, {required AuthTokenGetter token})
    : _getToken = token;

  @override
  Future<List<BusInfoEntity>> searchTravelResult({
    required String from,
    required String to,
    required String date,
  }) async {
    try {
      final result =
          (await _dioInstance.post(
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
          )).data;

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
      final result =
          (await _dioInstance.post(
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
          )).data;

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
  Future<String> checkIfExistingUser({required String phone}) async {
    try {
      final result =
          (await _dioInstance.post(
            '/Data/API_CheckMobileNo',
            data: {'MobileNo': phone},
            options: Options(
              headers: {
                'APITocken': '9D85A0FB-73E1-413C-BC2C-C95DDCD9CD89',
                'AppType': 'MOBAND',
                'Content-Type': 'application/json',
              },
            ),
          )).data;
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
      final result =
          (await _dioInstance.post(
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
          )).data;

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
      final result =
          (await _dioInstance.post(
            '/Data/API_AddNewUser',
            data: map,
            options: Options(
              headers: {
                'APITocken': '9D85A0FB-73E1-413C-BC2C-C95DDCD9CD89',
                'AppType': 'MOBAND',
                'Content-Type': 'application/json',
              },
            ),
          )).data;

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
  Future<AppUser> getUser() async {
    AppUser? appuser = (await _getToken());
    if (appuser == null) throw 'Login required';
    try {
      final result =
          (await _dioInstance.post(
            '/Passenger/API_GetPassenger',
            data: {'PassID': appuser.id},
            options: Options(
              headers: {
                'APITocken': appuser.token,
                'AppType': 'MOBAND',
                'Content-Type': 'application/json',
              },
            ),
          )).data;

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
  Future<AppUser> getUserAutoFills() async {
    AppUser? appuser = (await _getToken());
    if (appuser == null) throw 'Login required';
    try {
      final result =
          (await _dioInstance.post(
            '/Passenger/API_AutoFillInformations',
            data: {'PassID': appuser.id},
            options: Options(
              headers: {
                'APITocken': appuser.token,
                'AppType': 'MOB',
                'Content-Type': 'application/json',
              },
            ),
          )).data;

      if (result['success'] == true) {
        final map = result['UserLoginInformations'][0];
        return appuser.copyWith(
          idType: map['IDType'] ?? '0',
          idNumber: map['IDNo'] ?? '',
          citizenship: map['Citizenship'] ?? '0',
          gender: appuser.gender ?? map['Gender'],
          dateOfBirth: appuser.dateOfBirth ?? map['DOB'],
          kinName: map['Kname'],
          kinNumber: map['Kmob'],
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
      final result =
          (await _dioInstance.post(
            '/Passenger/API_UpdateProfile',
            data: {
              'ID': appuser.id,
              'Name': name,
              'DOB': date,
              'Gender': gender,
              'EmailID': email,
              'MobileNo': appuser.phone,
            },
            options: Options(
              headers: {
                'APITocken': appuser.token,
                'AppType': 'MOBAND',
                'Content-Type': 'application/json',
              },
            ),
          )).data;

      if (result['success'] == true) {
        return await getUser();
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
  Future<bool> changePass({
    required String oldPass,
    required String newPass,
  }) async {
    AppUser? appuser = (await _getToken());
    if (appuser == null) throw 'Login required';

    try {
      final result =
          (await _dioInstance.post(
            '/Passenger/API_ChangePassword',
            data: {
              'ID': appuser.id,
              'OldPassword': oldPass,
              'NewPassword': newPass,
            },
            options: Options(
              headers: {
                'APITocken': appuser.token,
                'AppType': 'MOBAND',
                'Content-Type': 'application/json',
              },
            ),
          )).data;

      if (result['success'] == true) {
        return true;
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
  Future<String> getNameFromPhone({required String phone}) async {
    try {
      final result =
          (await _dioInstance.get(
            'https://api.data.tapngogh.com/customer/kyc?phoneNumber=$phone',
            options: Options(
              headers: {
                'Authorization': '9605239da9ca606e463cfe7d17249de0f6dd1ae4',
                'Content-Type': 'application/json',
              },
            ),
          )).data;

      if (result['status'] == 200) {
        return result['payload']['name'];
      } else {
        throw 'An error occurred.';
      }
    } on DioException catch (e) {
      throw e.formattedError;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<TicketEntity>> getTicketBookings() async {
    AppUser? appuser = (await _getToken());
    if (appuser == null) throw 'Login required';
    try {
      final result =
          (await _dioInstance.post(
            '/Passenger/API_GetPassengerBookingHistory',
            data: {'UserID': appuser.id},
            options: Options(
              headers: {
                'APITocken': appuser.token,
                'AppType': 'MOBAND',
                'Content-Type': 'application/json',
              },
            ),
          )).data;

      if (result['success'] == true) {
        return (result['TravelHistory'] as Iterable)
            .map((e) => TicketEntity.fromJson(e))
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

  @override
  Future<bool> cancelTicket({required String ticketNumber}) async {
    AppUser? appuser = (await _getToken());
    if (appuser == null) throw 'Login required';
    try {
      final result =
          (await _dioInstance.post(
            '/Passenger/API_TicketCancel',
            data: {'TicketID': ticketNumber},
            options: Options(
              headers: {
                'APITocken': appuser.token,
                'AppType': 'MOB',
                'Content-Type': 'application/json',
              },
            ),
          )).data;

      logger.d(result);

      if (result['success'] == true) {
        return true;
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
  Future<List<CancelledTicketEntity>> getCancelledTicket(
    // {required DateTime dateFrom, required DateTime dateTo}
  ) async {
    AppUser? appuser = (await _getToken());
    if (appuser == null) throw 'Login required';
    try {
      final result =
          (await _dioInstance.post(
            '/Passenger/API_GetPassengerCancelgHistory',
            data: {
              'UserID': appuser.id,
              'DateFrom': DateTime.parse('2020-02-23 17:00:04').dateMMMonthYear,
              'DateTo': DateTime.now().dateMMMonthYear,
            },
            options: Options(
              headers: {
                'APITocken': appuser.token,
                'AppType': 'MOB',
                'Content-Type': 'application/json',
              },
            ),
          )).data;

      if (result['success'] == true) {
        return (result['CancelHistory'] as Iterable)
            .map((e) => CancelledTicketEntity.fromJson(e))
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

  @override
  Future<BookBusTicketEntity> bookBusTicket({
    required Map<String, dynamic> map,
  }) async {
    AppUser? appuser = (await _getToken());
    if (appuser == null) throw 'Login required';
    try {
      final result =
          (await _dioInstance.post(
            '/Passenger/API_TicketBookingNew',
            // 'http://67.222.135.24:8024/API/Passenger/API_TicketBookingNew',
            data: map,
            options: Options(
              headers: {
                'APITocken': appuser.token,
                'AppType': 'MOB',
                'Content-Type': 'application/json',
              },
            ),
          )).data;

      return BookBusTicketEntity.fromJson(result);
    } on DioException catch (e) {
      logger.d(e);
      throw e.formattedError;
    } catch (e) {
      throw e.toString();
    }
  }
}
