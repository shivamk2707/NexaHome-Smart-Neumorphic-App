import 'package:go_router/go_router.dart';

import '../../features/splash/screens/splash_screen.dart';
import '../../features/onboarding/screens/welcome_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/registration_screen.dart';
import '../../features/auth/screens/otp_verification_screen.dart';
import '../../features/dashboard/screens/home_dashboard_screen.dart';
import '../../features/dashboard/screens/smart_home_overview_screen.dart';
import '../../features/devices/screens/ac_control_screen.dart';
import '../../features/devices/screens/fan_control_screen.dart';
import '../../features/devices/screens/smart_light_control_screen.dart';
import '../../features/devices/screens/smart_lock_screen.dart';
import '../../features/automation/screens/automation_dashboard_screen.dart';
import '../../features/rooms/screens/room_selection_screen.dart';
import '../../features/rooms/screens/room_details_screen.dart';
import '../../features/energy/screens/energy_monitoring_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/settings/screens/user_profile_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/welcome', builder: (context, state) => const WelcomeScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/registration', builder: (context, state) => const RegistrationScreen()),
      GoRoute(path: '/otp', builder: (context, state) => const OtpVerificationScreen()),
      GoRoute(path: '/dashboard', builder: (context, state) => const HomeDashboardScreen()),
      GoRoute(path: '/smart_home_overview', builder: (context, state) => const SmartHomeOverviewScreen()),
      GoRoute(path: '/ac_control', builder: (context, state) => const AcControlScreen()),
      GoRoute(path: '/fan_control', builder: (context, state) => const FanControlScreen()),
      GoRoute(path: '/light_control', builder: (context, state) => const SmartLightControlScreen()),
      GoRoute(path: '/lock_control', builder: (context, state) => const SmartLockScreen()),
      GoRoute(path: '/automation', builder: (context, state) => const AutomationDashboardScreen()),
      GoRoute(path: '/room_selection', builder: (context, state) => const RoomSelectionScreen()),
      GoRoute(path: '/room_details', builder: (context, state) => const RoomDetailsScreen()),
      GoRoute(path: '/energy', builder: (context, state) => const EnergyMonitoringScreen()),
      GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
      GoRoute(path: '/user_profile', builder: (context, state) => const UserProfileScreen()),
    ],
  );
}
