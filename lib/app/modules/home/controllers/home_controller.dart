import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_translate/app/routes/app_pages.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator/translator.dart';

class HomeController extends GetxController {
  SpeechToText speechToText = SpeechToText();

  FlutterTts flutterTts = FlutterTts();
  GoogleTranslator translator = GoogleTranslator();

  late final String text;
  String translateText = "";
  late final TextEditingController textController;

  bool speechEnabled = false;
  //String _lastWords = '';

  String lastError = '';
  String lastStatus = '';

  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;

  String currentLocaleId = '';
  bool logEvents = false;
  List<LocaleName> localeNames = [];

  String translateLocaleId = "en_US";

  bool hasSpeech = false;
  bool onDevice = false;

  @override
  void onInit() {
    text = Get.arguments["text"] ?? "";
    //_lastWords = widget.text ?? "";
    textController = TextEditingController(text: text)..addListener(() {
      speechEnabled
          ? textController.text.isEmpty
              ? 'Tap the microphone to start listening...'
              : textController.text
          : 'Speech not available';
    });
    _initSpeech();
    super.onInit();
  }

  //For debbuging
  void _logEvent(String eventDescription) {
    if (logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      print('$eventTime $eventDescription');
    }
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    try {
      speechEnabled = await speechToText.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: logEvents,
      );
      if (speechEnabled) {
        // Get the list of languages installed on the supporting platform so they
        // can be displayed in the UI for selection by the user.
        localeNames = await speechToText.locales();

        var systemLocale = await speechToText.systemLocale();
        currentLocaleId = systemLocale?.localeId ?? 'fr_FR';
      }
      hasSpeech = speechEnabled;
      update();
    } catch (e) {
      lastError = 'Speech recognition failed: ${e.toString()}';
      hasSpeech = false;
      update();
    }
  }

  //Error Listerner
  void errorListener(SpeechRecognitionError error) {
    _logEvent(
      'Received error status: $error, listening: ${speechToText.isListening}',
    );
    lastError = '${error.errorMsg} - ${error.permanent}';
    update();
  }

  //Status Listerner
  void statusListener(String status) {
    _logEvent(
      'Received listener status: $status, listening: ${speechToText.isListening}',
    );
    lastStatus = status;
    update();
  }

  /// Each time to start a speech recognition session
  void startListening() async {
    textController.text = "";
    await speechToText.listen(
      onResult: _onSpeechResult,
      localeId: currentLocaleId,
      onSoundLevelChange: soundLevelListener,
      cancelOnError: false,
      partialResults: true,
    );
    update();
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    this.level = level;
    update();
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void stopListening() async {
    _logEvent('stop');
    await speechToText.stop();
    level = 0.0;
    update();
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    textController.text = result.recognizedWords;
    update();
  }

  //Change speech lang
  void switchLang(selectedVal) {
    currentLocaleId = selectedVal;
    update();
    debugPrint(selectedVal);
  }

  Future<void> translate() async {
    await translator
        .translate(
          textController.text,
          from: currentLocaleId,
          to: translateLocaleId,
        )
        .then((value) => translateText = value.text);
    update();
  }

  bool recording = false;

  Future<void> requestCamera() async {
    final status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      //Go to camera screen
      Get.toNamed(Routes.CAMERA);
    } else {
      Get.snackbar("Error", "You can't use without camera permission");
    }
  }
}
