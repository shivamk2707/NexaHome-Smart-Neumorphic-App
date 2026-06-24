import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/screens/splash_screen.dart';
import '../../features/onboarding/screens/welcome_screen.dart';
import '../../features/onboarding/screens/onboarding_connectivity_screen.dart';
import '../../features/onboarding/screens/onboarding_automation_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/registration_screen.dart';
import '../../features/auth/screens/otp_verification_screen.dart';

import '../../features/dashboard/screens/home_dashboard_screen.dart';
import '../../features/dashboard/screens/smart_home_overview_screen.dart';
import '../../features/dashboard/screens/empty_state_devices_screen.dart';
import '../../features/dashboard/screens/error_state_connection_screen.dart';
import '../../features/dashboard/screens/success_state_device_connected_screen.dart';

import '../../features/devices/screens/ac_control_screen.dart';
import '../../features/devices/screens/fan_control_screen.dart';
import '../../features/devices/screens/smart_light_control_screen.dart';
import '../../features/devices/screens/smart_lock_screen.dart';
import '../../features/devices/screens/device_list_screen.dart';
import '../../features/devices/screens/add_new_device_screen.dart';
import '../../features/devices/screens/device_setup_form_screen.dart';
import '../../features/devices/screens/device_pairing_screen.dart';
import '../../features/devices/screens/security_camera_screen.dart';

import '../../features/automation/screens/automation_dashboard_screen.dart';
import '../../features/automation/screens/scenes_screen.dart';
import '../../features/automation/screens/create_new_scene_screen.dart';
import '../../features/automation/screens/create_automation_screen.dart';
import '../../features/automation/screens/automation_detail_screen.dart';

import '../../features/rooms/screens/room_selection_screen.dart';
import '../../features/rooms/screens/room_details_screen.dart';

import '../../features/energy/screens/energy_monitoring_screen.dart';

import '../../features/settings/screens/settings_screen.dart';
import '../../features/settings/screens/user_profile_screen.dart';
import '../../features/settings/screens/activity_history_screen.dart';
import '../../features/settings/screens/help_support_screen.dart';
import '../../features/settings/screens/home_members_screen.dart';
import '../../features/settings/screens/notifications_screen.dart';
import '../../features/settings/screens/security_settings_screen.dart';
import '../../features/settings/screens/subscription_plan_screen.dart';
import '../../features/settings/screens/favorites_screen.dart';
import '../../features/settings/screens/voice_control_screen.dart';
import '../../features/settings/screens/ai_smart_assistant_screen.dart';

import '../widgets/main_scaffold_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      // Splash & Auth
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/welcome', builder: (context, state) => const WelcomeScreen()),
      GoRoute(path: '/onboarding_connectivity', builder: (context, state) => const OnboardingConnectivityScreen()),
      GoRoute(path: '/onboarding_automation', builder: (context, state) => const OnboardingAutomationScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/registration', builder: (context, state) => const RegistrationScreen()),
      GoRoute(path: '/otp', builder: (context, state) => const OtpVerificationScreen()),

      // Bottom Navigation Shell
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScaffoldScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/dashboard',
                builder: (context, state) => const HomeDashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/room_selection',
                builder: (context, state) => const RoomSelectionScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/device_list',
                builder: (context, state) => const DeviceListScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/automation',
                builder: (context, state) => const AutomationDashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/user_profile',
                builder: (context, state) => const UserProfileScreen(),
              ),
            ],
          ),
        ],
      ),

      // Other top-level routes
      GoRoute(path: '/ac_control/:id', builder: (context, state) => AcControlScreen(deviceId: state.pathParameters['id'] ?? 'd1')),
      GoRoute(path: '/fan_control/:id', builder: (context, state) => FanControlScreen(deviceId: state.pathParameters['id'] ?? 'd4')),
      GoRoute(path: '/light_control/:id', builder: (context, state) => SmartLightControlScreen(deviceId: state.pathParameters['id'] ?? 'd2')),
      GoRoute(path: '/lock_control/:id', builder: (context, state) => SmartLockScreen(deviceId: state.pathParameters['id'] ?? 'd3')),
      GoRoute(path: '/security_camera', builder: (context, state) => const SecurityCameraScreen()),
      GoRoute(path: '/add_device', builder: (context, state) => const AddNewDeviceScreen()),
      GoRoute(path: '/device_pairing', builder: (context, state) => const DevicePairingScreen()),
      GoRoute(path: '/device_setup_form', builder: (context, state) => const DeviceSetupFormScreen()),

      GoRoute(path: '/room_details', builder: (context, state) => const RoomDetailsScreen()),

      GoRoute(path: '/scenes', builder: (context, state) => const ScenesScreen()),
      GoRoute(path: '/create_new_scene', builder: (context, state) => const CreateNewSceneScreen()),
      GoRoute(path: '/create_automation', builder: (context, state) => const CreateAutomationScreen()),
      GoRoute(path: '/automation_detail', builder: (context, state) => const AutomationDetailScreen()),

      GoRoute(path: '/energy', builder: (context, state) => const EnergyMonitoringScreen()),
      GoRoute(path: '/smart_home_overview', builder: (context, state) => const SmartHomeOverviewScreen()),

      GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
      GoRoute(path: '/activity_history', builder: (context, state) => const ActivityHistoryScreen()),
      GoRoute(path: '/help_support', builder: (context, state) => const HelpSupportScreen()),
      GoRoute(path: '/home_members', builder: (context, state) => const HomeMembersScreen()),
      GoRoute(path: '/notifications', builder: (context, state) => const NotificationsScreen()),
      GoRoute(path: '/security_settings', builder: (context, state) => const SecuritySettingsScreen()),
      GoRoute(path: '/subscription_plan', builder: (context, state) => const SubscriptionPlanScreen()),
      GoRoute(path: '/favorites', builder: (context, state) => const FavoritesScreen()),
      GoRoute(path: '/voice_control', builder: (context, state) => const VoiceControlScreen()),
      GoRoute(path: '/ai_smart_assistant', builder: (context, state) => const AiSmartAssistantScreen()),

      GoRoute(path: '/empty_state_devices', builder: (context, state) => const EmptyStateDevicesScreen()),
      GoRoute(path: '/error_state_connection', builder: (context, state) => const ErrorStateConnectionScreen()),
      GoRoute(path: '/success_state_device_connected', builder: (context, state) => const SuccessStateDeviceConnectedScreen()),
    ],
  );
}
