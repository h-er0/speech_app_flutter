import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_translate/app/features/home/presentation/states/home/home_state.dart';
import 'package:speech_translate/app/routes/app_router.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator/translator.dart';

import '../../../../shared/constants.dart';

final homeStateNotifierProvider =
    StateNotifierProvider.autoDispose<HomeStateNotifier, HomeState>((ref) {
      return HomeStateNotifier();
    });

class HomeStateNotifier extends StateNotifier<HomeState> {
  HomeStateNotifier() : super(const HomeState(text: ""));

  SpeechToText speechToText = SpeechToText();

  FlutterTts flutterTts = FlutterTts();
  GoogleTranslator translator = GoogleTranslator();

  //String _lastWords = '';

  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;

  bool logEvents = false;
  List<LocaleName> localeNames = [];

  //For debbuging
  void _logEvent(String eventDescription) {
    if (logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      logger.d('$eventTime $eventDescription');
    }
  }

  /// This has to happen only once per app
  Future<void> initSpeech(ValueNotifier<bool> speechEnabled) async {
    try {
      speechEnabled.value = await speechToText.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: logEvents,
      );
      if (speechEnabled.value) {
        // Get the list of languages installed on the supporting platform so they
        // can be displayed in the UI for selection by the user.
        localeNames = await speechToText.locales();

        var systemLocale = await speechToText.systemLocale();

        LocaleName? localeName = localeNames.firstWhereOrNull(
          (e) => e.localeId == systemLocale?.localeId,
        );

        state = state.copyWith(
          currentLocaleId: localeName?.localeId ?? 'en_US',
          translateLocaleId:
              localeName?.localeId == 'en_US' ? 'fr_FR' : 'en_US',
        );
      }
      state = state.copyWith(hasSpeech: speechEnabled.value);
    } catch (e) {
      state = state.copyWith(
        lastError: 'Speech recognition failed: ${e.toString()}',
      );
      state = state.copyWith(hasSpeech: false);
    }
  }

  //Error Listerner
  void errorListener(SpeechRecognitionError error) {
    _logEvent(
      'Received error status: $error, listening: ${speechToText.isListening}',
    );
    state = state.copyWith(lastError: '${error.errorMsg} - ${error.permanent}');
  }

  //Status Listerner
  void statusListener(String status) {
    _logEvent(
      'Received listener status: $status, listening: ${speechToText.isListening}',
    );
    state = state.copyWith(lastStatus: status);
  }

  /// Each time to start a speech recognition session
  void startListening(TextEditingController textController) async {
    final options = SpeechListenOptions(
      onDevice: state.onDevice,
      listenMode: ListenMode.confirmation,
      cancelOnError: true,
      partialResults: true,
      autoPunctuation: true,
      enableHapticFeedback: true,
    );
    await speechToText.listen(
      onResult:
          (SpeechRecognitionResult result) =>
              _onSpeechResult(result, textController),
      localeId: state.currentLocaleId,
      onSoundLevelChange: soundLevelListener,
      listenOptions: options,
    );
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    this.level = level;
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void stopListening() async {
    _logEvent('stop');
    await speechToText.stop();
    level = 0.0;
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(
    SpeechRecognitionResult result,
    TextEditingController textController,
  ) {
    textController.text = result.recognizedWords;
  }

  //Change speech lang
  void switchLang(LocaleName selectedVal) {
    state = state.copyWith(currentLocaleId: selectedVal.localeId);

    logger.d("Selected value $selectedVal");
  }

  //Change translate lang
  void switchTranslateLang(LocaleName selectedVal) {
    state = state.copyWith(translateLocaleId: selectedVal.localeId);

    logger.d("Selected value $selectedVal");
  }

  Future<void> translate(
    TextEditingController textController,
    TextEditingController translatedTextController,
  ) async {
    try {
      await translator
          .translate(
            textController.text,
            from: state.currentLocaleId.split("_").first,
            to: state.translateLocaleId.split("_").first,
          )
          .then((value) {
            logger.d("Translated text: ${value.text}");
            state = state.copyWith(translateText: value.text);
            translatedTextController.text = value.text;
          });
    } catch (e) {
      logger.e("Error while translating the text $eß");
    }
  }

  bool recording = false;

  Future<void> requestCamera(BuildContext context) async {
    final status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      if (!context.mounted) return;
      //Go to camera screen
      context.push(Routes.camera);
    } else {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: Text("Permission denied"),
            content: Text("You can't use without camera permission"),
          );
        },
      );
    }
  }
}
