import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sizer/sizer.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'core/router/app_router.dart';
import 'data/services/preferences_service.dart';
import 'features/auth/bloc/auth_cubit.dart';
import 'features/devices/bloc/device_cubit.dart';
import 'features/rooms/bloc/room_cubit.dart';
import 'features/settings/bloc/member_cubit.dart';
import 'features/automation/bloc/scene_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefsService = PreferencesService();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit(prefsService)),
        BlocProvider(create: (_) => AuthCubit(prefsService)),
        BlocProvider(create: (_) => DeviceCubit()),
        BlocProvider(create: (_) => RoomCubit()),
        BlocProvider(create: (_) => MemberCubit()),
        BlocProvider(create: (_) => SceneCubit()),
      ],
      child: const NexaHomeApp(),
    ),
  );
}

class NexaHomeApp extends StatelessWidget {
  const NexaHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Sizer(
          builder: (context, orientation, deviceType) {
            final themeCubit = context.watch<ThemeCubit>();
            return MaterialApp.router(
              title: 'NexaHome',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeCubit.state,
              routerConfig: AppRouter.router,
              debugShowCheckedModeBanner: false,
            );
          },
        );
      },
    );
  }
}
