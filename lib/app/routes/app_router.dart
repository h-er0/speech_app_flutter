import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../core/errors/not_found.dart';
import '../features/camera/presentation/views/camera_view.dart';
import '../features/home/presentation/views/home_view.dart';
import '../shared/constants.dart';

part 'app_routes.dart';

class AppRouter {
  final GoRouter _router;

  AppRouter({required String initialLocation})
    : _router = GoRouter(
        initialLocation: initialLocation,
        routes: [
          GoRoute(
            path: _Paths.notFound,
            builder: (context, state) {
              return NotFoundPage(uri: state.extra as String? ?? '');
            },
          ),
          GoRoute(
            path: _Paths.home,
            builder: (context, state) {
              return HomeView(
                data:
                    (state.extra as Map<String, dynamic>?)?['text'] as String?,
              );
            },
          ),
          GoRoute(
            path: _Paths.camera,
            builder: (context, state) {
              return CameraView();
            },
          ),
        ],
        redirect: (BuildContext context, GoRouterState state) async {
          logger.i("Navigate to ${state.uri}");
          return null;
        },
        onException: (_, GoRouterState state, GoRouter router) {
          router.push(_Paths.notFound, extra: state.uri.toString());
        },
      );

  GoRouter get router => _router;
}
