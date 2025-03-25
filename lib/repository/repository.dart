import '../entity/app_user.dart';
import '../entity/bus_info_entity.dart';
import '../entity/bus_seat_entity.dart';
import 'package:quick_ride_user/entity/ticket_entity.dart';

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

  Future<String> checkIfExistingUser({
    required String phone,
  });

  Future<AppUser> login({
    required String phone,
    required String password,
  });

  Future<AppUser> signup({
    required Map<String, dynamic> map,
  });

  Future<AppUser> getUser({
    required String id,
  });

  Future<AppUser> updateUser({
    required String name,
    required String email,
    required String gender,
    required String date,
  });
  Future<bool> changePass({
    required String oldPass,
    required String newPass,
  });
  Future<String> getNameFromPhone({
    required String phone,
  });

  Future<List<TicketEntity>> getTicketBookings();
  Future<bool> cancelTicket({required String ticketNumber});
}
