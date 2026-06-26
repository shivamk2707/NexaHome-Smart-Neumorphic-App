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
      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/ac_control/:id',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: AcControlScreen(deviceId: state.pathParameters['id'] ?? 'd1'),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),
      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/fan_control/:id',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: FanControlScreen(deviceId: state.pathParameters['id'] ?? 'd4'),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),
      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/light_control/:id',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: SmartLightControlScreen(deviceId: state.pathParameters['id'] ?? 'd2'),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),
      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/lock_control/:id',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: SmartLockScreen(deviceId: state.pathParameters['id'] ?? 'd3'),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),
      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/security_camera',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const SecurityCameraScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),
      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/add_device',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const AddNewDeviceScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),
      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/device_pairing',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const DevicePairingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),
      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/device_setup_form',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const DeviceSetupFormScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),

      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/room_details/:id',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: RoomDetailsScreen(roomId: state.pathParameters['id'] ?? 'r1'),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),

      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/scenes',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const ScenesScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),
      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/create_new_scene',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const CreateNewSceneScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),
      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/create_automation',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const CreateAutomationScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),
      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/automation_detail/:id',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: AutomationDetailScreen(sceneId: state.pathParameters['id'] ?? 's1'),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),

      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/energy',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const EnergyMonitoringScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),
      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/smart_home_overview',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const SmartHomeOverviewScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),

      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/settings',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const SettingsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),
      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/activity_history',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const ActivityHistoryScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),
      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/help_support',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const HelpSupportScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),
      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/home_members',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const HomeMembersScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),
      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/notifications',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const NotificationsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),
      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/security_settings',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const SecuritySettingsScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),
      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/subscription_plan',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const SubscriptionPlanScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),
      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/favorites',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const FavoritesScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),
      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/voice_control',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const VoiceControlScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),
      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/ai_smart_assistant',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const AiSmartAssistantScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),

      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/empty_state_devices',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const EmptyStateDevicesScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),
      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/error_state_connection',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const ErrorStateConnectionScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),
      GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/success_state_device_connected',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const SuccessStateDeviceConnectedScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            ),
          );
        },
      ),
    ),
    ],
  );
}
