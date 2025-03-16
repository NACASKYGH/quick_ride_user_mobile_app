import './entity/bus_info_entity.dart';
import 'package:go_router/go_router.dart';
import 'presentation/screens/index_screen.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/screens/auth/otp_screen.dart';
import 'presentation/screens/onboarding_screen.dart';
import 'presentation/screens/auth/sign_up_name.dart';
import 'presentation/screens/_home/seat_sel_screen.dart';
import 'presentation/screens/_profile/change_password.dart';
import 'presentation/screens/auth/phone_number_screen.dart';
import 'presentation/screens/_home/available_buses_screen.dart';
import 'package:quick_ride_user/presentation/screens/_home/enter_details_screen.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: RouteConsts.splash,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: '/walk-through',
        name: RouteConsts.walkThru,
        builder: (context, state) {
          return const OnboardingScreen();
        },
      ),
      GoRoute(
        path: '/phone-screen',
        name: RouteConsts.phoneScreen,
        builder: (context, state) {
          return PhoneNumberScreen(
            phoneNumber: state.extra as String? ?? '',
          );
        },
      ),
      GoRoute(
        path: '/otp-screen',
        name: RouteConsts.otpScreen,
        builder: (context, state) {
          final extra = state.extra as (String, String);
          return OTPScreen(
            phoneNumber: extra.$1,
            otpCode: extra.$2,
          );
        },
      ),
      GoRoute(
        path: '/sign-up-name',
        name: RouteConsts.signUpName,
        builder: (context, state) {
          final extra = state.extra as (String, String);

          return SignUpName(
            phoneNumber: extra.$1,
            otpCode: extra.$2,
          );
        },
      ),
      GoRoute(
        path: '/index',
        name: RouteConsts.index,
        builder: (context, state) {
          return const IndexScreen();
        },
      ),
      GoRoute(
        path: '/available-buses',
        name: RouteConsts.availableBuses,
        builder: (context, state) {
          final extras = state.extra as (String, String, String);
          return AvailableBusesScreen(
            from: extras.$1,
            to: extras.$2,
          );
        },
      ),
      GoRoute(
        path: '/bus-seat',
        name: RouteConsts.busSeat,
        builder: (context, state) {
          return SeatSelScreen(
            bus: state.extra as BusInfoEntity,
          );
        },
      ),
      GoRoute(
        path: '/enter-details',
        name: RouteConsts.enterDetails,
        builder: (context, state) {
          return EnterDetailsScreen(
            bus: state.extra as BusInfoEntity,
          );
        },
      ),
      GoRoute(
        path: '/change-pass',
        name: RouteConsts.changePassword,
        builder: (context, state) {
          return const ChangePassword();
        },
      ),
    ],
  );
}

class RouteConsts {
  static String splash = 'splash';
  static String walkThru = 'walk-through';
  static String phoneScreen = 'phone-screen';
  static String otpScreen = 'otp-screen';
  static String signUpName = 'sign-up-name';
  static String index = 'index';
  static String availableBuses = 'available-buses';
  static String busSeat = 'bus-seat';
  static String changePassword = 'change-password';
  static String enterDetails = 'enter-details';
}
