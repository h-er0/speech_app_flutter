import 'package:camera/camera.dart' as cam;
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/camera_controller.dart';

class CameraView extends GetView<CameraController> {
  const CameraView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Camera",
        ),
      ),
      body: FutureBuilder<List<cam.CameraDescription>>(
          future: cam.availableCameras(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              controller.initCameraController(snapshot.data!);
              return Stack(
                children: [
                  Transform.scale(
                      scale: (controller.cameraController!.value.aspectRatio /
                              controller.deviceRatio) -
                          1.5,
                      child: cam.CameraPreview(controller.cameraController!)),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: ElevatedButton(
                        onPressed: () {
                          controller.scanImage();
                        },
                        child: const Text("SCAN TEXT"),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: const Center(child: CircularProgressIndicator()));
            }
          }),
    );
  }
}
