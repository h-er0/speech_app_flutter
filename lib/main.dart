import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:speech_translate/app/shared/constants.dart';

import 'app/routes/app_router.dart';

void main() async {
  cameras = await availableCameras();

  final AppRouter appRouter = AppRouter(initialLocation: Routes.home);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: ProviderScope(child: MyApp(appRouter: appRouter)),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: "Application",
      debugShowCheckedModeBanner: kDebugMode ? true : false,
      routerConfig: appRouter.router,
    );
  }
}
