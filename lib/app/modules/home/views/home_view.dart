import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Speech to text"),
        actions: [
          GestureDetector(
            onTap: () {
              controller.requestCamera();
            },
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.camera),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Text('Language: '),
              SizedBox(
                width: 200,
                child: DropdownButton<String>(
                  isExpanded: true,
                  onChanged: (selectedVal) {
                    debugPrint("lang $selectedVal");
                    controller.switchLang(selectedVal);
                  },
                  value: controller.currentLocaleId,
                  items:
                      controller.localeNames
                          .map(
                            (localeName) => DropdownMenuItem(
                              value: localeName.localeId,
                              child: SizedBox(
                                width: 200,
                                child: Text(localeName.name),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: const Text(
              'Recognized words:',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          SizedBox(
            height: Get.height / 3.5,
            width: Get.width - 40,
            child: Expanded(
              child: TextField(
                controller: controller.textController,
                textAlign: TextAlign.left,
                minLines: 10,
                maxLines: 50,
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Row(
            children: [
              const Text('Translate to: '),
              SizedBox(
                width: 200,
                child: DropdownButton<String>(
                  isExpanded: true,
                  onChanged: (selectedVal) {
                    print("lang $selectedVal");
                    controller.translateLocaleId = selectedVal!;
                    controller.update();
                  },
                  value: controller.translateLocaleId,
                  items:
                      controller.localeNames
                          .map(
                            (localeName) => DropdownMenuItem(
                              value: localeName.localeId,
                              child: SizedBox(
                                width: 200,
                                child: Text(localeName.name),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
            ],
          ),
          Container(
            height: Get.height / 3.5,
            width: Get.width - 40,
            padding: const EdgeInsets.all(16),
            child: Text(controller.translateText),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed:
            // If not yet listening for speech start, otherwise stop
            controller.speechToText.isNotListening
                ? controller.startListening
                : controller.stopListening,
        tooltip: 'Listen',
        child: Icon(
          controller.speechToText.isNotListening ? Icons.mic_off : Icons.mic,
        ),
      ),
    );
  }
}
