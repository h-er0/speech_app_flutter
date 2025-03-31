import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifiers/camera_state_notifier.dart';

class CameraView extends HookConsumerWidget {
  const CameraView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(cameraStateNotifierProvider.notifier);

    final deviceRatio =
        MediaQuery.sizeOf(context).width / MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(title: const Text("Camera")),
      body: FutureBuilder<bool>(
        future: notifier.initCameraController(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!
                ? Stack(
                  children: [
                    Transform.scale(
                      scale:
                          (notifier.cameraController!.value.aspectRatio /
                              deviceRatio) -
                          1.5,
                      child: CameraPreview(notifier.cameraController!),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: ElevatedButton(
                          onPressed: () async {
                            await notifier.scanImage(context);
                          },
                          child: const Text("SCAN TEXT"),
                        ),
                      ),
                    ),
                  ],
                )
                : Center(child: Text("An error occured"));
          } else {
            return SizedBox(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              child: const Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
