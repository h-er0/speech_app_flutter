import 'package:camera/camera.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

late List<CameraDescription> cameras;
final container = ProviderContainer();
final Logger logger = Logger();
String defaultLocale = Intl.getCurrentLocale();
final currentLocalValueProvider = StateProvider<String>((ref) => defaultLocale);
