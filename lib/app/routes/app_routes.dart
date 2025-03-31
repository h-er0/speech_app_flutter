part of 'app_router.dart';

abstract class Routes {
  Routes._();
  static const homenotFound = _Paths.notFound;
  static const home = _Paths.home;
  static const camera = _Paths.camera;
}

abstract class _Paths {
  _Paths._();
  static const notFound = '/notFound';
  static const home = '/home';
  static const camera = '/camera';
}
