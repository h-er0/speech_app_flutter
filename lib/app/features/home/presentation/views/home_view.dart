import 'dart:async';

import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:speech_translate/app/config/theme/app_colors.dart';
import 'package:speech_translate/app/features/home/presentation/widgets/languages_picker.dart';

import '../notifiers/home_state_notifier.dart';

class HomeView extends HookConsumerWidget {
  final String? data;
  const HomeView({super.key, this.data});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(homeStateNotifierProvider.notifier);
    final state = ref.watch(homeStateNotifierProvider);

    final textController = useTextEditingController(text: state.text);
    final translatedTextController = useTextEditingController();

    final speechEnabled = useState(false);
    Timer? typingTimer;

    final isLoading = useState(false);

    void listener() {
      // Cancel the previous timer if it exists
      typingTimer?.cancel();

      // Start a new timer that triggers after 1 second of inactivity
      typingTimer = Timer(const Duration(seconds: 1), () async {
        if (textController.text.isNotEmpty) {
          // Execute your desired function here
          isLoading.value = true;
          await notifier.translate(textController, translatedTextController);
          isLoading.value = false;
        }
      });
    }

    useEffect(() {
      //_lastWords = widget.text ?? "";
      textController.addListener(listener);
      notifier.initSpeech(speechEnabled);
      if (data != null && data!.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("No text found on the picture")),
          );
        });
      }
      return () => textController.removeListener(listener);
    }, [textController, notifier.initSpeech, WidgetsBinding.instance]);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          "Language translator",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body:
          state.currentLocaleId.isEmpty || state.translateLocaleId.isEmpty
              ? Center(child: CircularProgressIndicator.adaptive())
              : SafeArea(
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 24,
                      ),
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 5,
                            color: Colors.grey.withValues(alpha: 0.3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final result = await languagesPicker(
                                context,
                                notifier.localeNames,
                                state.currentLocaleId,
                              );
                              if (result != null) {
                                notifier.switchLang(result);
                              }
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  CountryFlag.fromLanguageCode(
                                    height: 30,
                                    width: 30,
                                    state.currentLocaleId.split("_").first,
                                    shape: Circle(),
                                  ),
                                  Gap(6),
                                  Text(
                                    notifier.localeNames
                                        .firstWhere(
                                          (e) =>
                                              e.localeId ==
                                              state.currentLocaleId,
                                        )
                                        .name
                                        .split("(")
                                        .first
                                        .trim(),
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Icon(Icons.swap_horiz_rounded),
                          Row(
                            children: [
                              Text(
                                notifier.localeNames
                                    .firstWhere(
                                      (e) =>
                                          e.localeId == state.translateLocaleId,
                                    )
                                    .name
                                    .split("(")
                                    .first
                                    .trim(),
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Gap(6),
                              CountryFlag.fromLanguageCode(
                                height: 30,
                                width: 30,
                                state.translateLocaleId.split("_").first,
                                shape: Circle(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Gap(10),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 24,
                      ),
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 5,
                            color: Colors.grey.withValues(alpha: 0.3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final result = await languagesPicker(
                                context,
                                notifier.localeNames,
                                state.translateLocaleId,
                              );
                              if (result != null) {
                                notifier.switchTranslateLang(result);
                              }
                            },
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  Text(
                                    notifier.localeNames
                                        .firstWhere(
                                          (e) =>
                                              e.localeId ==
                                              state.currentLocaleId,
                                        )
                                        .name
                                        .split("(")
                                        .first
                                        .trim(),
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Gap(10),
                                  Icon(Icons.volume_down_rounded),
                                  Spacer(),
                                  if (textController.text.isNotEmpty)
                                    IconButton(
                                      icon: Icon(Icons.close_rounded),
                                      onPressed: () {
                                        translatedTextController.text = "";
                                        textController.text = "";
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Gap(10),
                          TextField(
                            controller: textController,
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.left,
                            minLines: 5,
                            maxLines: 8,
                            decoration: const InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "Write your text here",

                              hintStyle: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(20),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 24,
                      ),
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 5,
                            color: Colors.grey.withValues(alpha: 0.3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                notifier.localeNames
                                    .firstWhere(
                                      (e) =>
                                          e.localeId == state.translateLocaleId,
                                    )
                                    .name
                                    .split("(")
                                    .first
                                    .trim(),
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Gap(10),
                              Icon(Icons.volume_down_rounded),
                              Spacer(),
                              if (isLoading.value)
                                SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator.adaptive(
                                    strokeWidth: 2,
                                  ),
                                ),
                            ],
                          ),
                          Gap(10),
                          TextField(
                            controller: translatedTextController,
                            readOnly: true,
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.left,
                            minLines: 5,
                            maxLines: 8,
                            decoration: const InputDecoration(
                              isDense: true,
                              border: InputBorder.none,

                              hintStyle: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed:
            // If not yet listening for speech start, otherwise stop
            notifier.speechToText.isNotListening
                ? () {
                  notifier.startListening(textController);
                }
                : notifier.stopListening,
        tooltip: 'Listen',
        child: Icon(
          notifier.speechToText.isNotListening ? Icons.mic_off : Icons.mic,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          if (index == 1) {
            notifier.requestCamera(context);
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
            label: "Speech translate",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_rounded),
            label: "Camera",
          ),
        ],
      ),
    );
  }
}
