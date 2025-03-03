import 'di.dart';
import 'package:go_router/go_router.dart';
import 'presentation/screens/index_screen.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/screens/auth/otp_screen.dart';
import 'presentation/screens/onboarding_screen.dart';
import 'presentation/screens/auth/sign_up_name.dart';
import 'presentation/screens/_profile/promo_screen.dart';
import 'presentation/screens/_profile/referral_screen.dart';
import 'presentation/screens/auth/phone_number_screen.dart';
import 'presentation/screens/_rides/ride_detail_screen.dart';
import 'presentation/screens/_profile/save_places_screen.dart';
import 'presentation/screens/_profile/edit_profile_screen.dart';
import 'presentation/screens/_profile/add_location_screen.dart';
import 'presentation/screens/_profile/emergency_contact_screen.dart';
import 'presentation/screens/_profile/emergency_contact_manager.dart';
import 'presentation/screens/_profile/save_place_add_name_screen.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    debugLogDiagnostics: true,
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
          return const PhoneNumberScreen();
        },
      ),
      GoRoute(
        path: '/otp-screen',
        name: RouteConsts.otpScreen,
        builder: (context, state) {
          return const OTPScreen();
        },
      ),
      GoRoute(
        path: '/sign-up-name',
        name: RouteConsts.signUpName,
        builder: (context, state) {
          return const SignUpName();
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
        path: '/ride-detail',
        name: RouteConsts.rideDetail,
        builder: (context, state) {
          return const RideDetailScreen();
        },
      ),
      GoRoute(
        path: '/edit-profile',
        name: RouteConsts.editProfile,
        builder: (context, state) {
          return const EditProfileScreen();
        },
      ),
      GoRoute(
        path: '/add-location',
        name: RouteConsts.addLocation,
        builder: (context, state) {
          return AddLocationScreen(
            title: state.extra.toString(),
          );
        },
      ),
      GoRoute(
        path: '/saved-places',
        name: RouteConsts.savePlaces,
        builder: (context, state) {
          return SavePlacesScreen();
        },
      ),
      GoRoute(
        path: '/saved-place-add-name',
        name: RouteConsts.savePlaceAddName,
        builder: (context, state) {
          return SavePlaceAddNameScreen();
        },
      ),
      GoRoute(
        path: '/promo-screen',
        name: RouteConsts.promoScreen,
        builder: (context, state) {
          return PromoScreen();
        },
      ),
      GoRoute(
        path: '/referral-code-screen',
        name: RouteConsts.referralCodeScreen,
        builder: (context, state) {
          return ReferralScreen();
        },
      ),
      GoRoute(
        path: '/emergency-contacts-screen',
        name: RouteConsts.emergencyContacts,
        builder: (context, state) {
          return EmergencyContactScreen();
        },
      ),
      GoRoute(
        path: '/emergency-contacts-manager',
        name: RouteConsts.emergencyContactsManager,
        builder: (context, state) {
          return EmergencyContactManager();
        },
      ),
    ],
    initialLocation: '/',
    redirect: (context, state) async {
      String? token = await (getIt<AuthTokenGetter>())();
      return (token ?? '').isNotEmpty && state.uri == Uri.parse('/')
          ? '/index'
          : state.path;
    },
  );
}

class RouteConsts {
  static String splash = 'splash';
  static String walkThru = 'walk-through';
  static String phoneScreen = 'phone-screen';
  static String otpScreen = 'otp-screen';
  static String signUpName = 'sign-up-name';
  static String index = 'index';
  static String pickLocation = 'pick-location';
  static String rideDetail = 'ride-detail-screen';
  static String editProfile = 'edit-profile-screen';
  static String addLocation = 'add-location-screen';
  static String savePlaces = 'save-places-screen';
  static String savePlaceAddName = 'save-places-add-name-screen';
  static String promoScreen = 'promo-screen';
  static String referralCodeScreen = 'referral-code-screen';
  static String emergencyContacts = 'emergency-contacts-screen';
  static String emergencyContactsManager = 'emergency-contacts-manager';
}
