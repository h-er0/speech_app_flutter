import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:speech_translate/app/features/camera/presentation/states/camera/camera_state.dart';
import 'package:speech_translate/app/routes/app_router.dart';
import 'package:speech_translate/app/shared/widgets/loading_dialog.dart';

import '../../../../shared/constants.dart';

final cameraStateNotifierProvider =
    StateNotifierProvider.autoDispose<CameraStateNotifier, CameraState>((ref) {
      return CameraStateNotifier();
    });

class CameraStateNotifier extends StateNotifier<CameraState> {
  CameraStateNotifier() : super(const CameraState());

  CameraController? cameraController;

  final textRecognizer = TextRecognizer();

  void didChangeAppLyfeCycleState(AppLifecycleState state) {
    if (cameraController == null || cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      stopCamera();
    } else if (state == AppLifecycleState.resumed &&
        cameraController != null &&
        cameraController!.value.isInitialized) {
      startCamera();
    }
  }

  Future<bool> initCameraController() async {
    if (cameraController != null || cameras.isEmpty) {
      return true;
    }

    //Select camera
    CameraDescription? camera;
    for (int i = 0; i < cameras.length; i++) {
      final CameraDescription currentCamera = cameras[i];
      if (currentCamera.lensDirection == CameraLensDirection.back) {
        camera = currentCamera;
        break;
      }
    }

    if (camera != null) {
      await cameraSelected(camera);
      return true;
    } else {
      return false;
    }
  }

  Future<void> cameraSelected(CameraDescription camera) async {
    cameraController = CameraController(camera, ResolutionPreset.max);

    await cameraController?.initialize();
  }

  void startCamera() {
    if (cameraController != null) {
      cameraSelected(cameraController!.description);
    }
  }

  void stopCamera() {
    if (cameraController != null) {
      cameraController?.dispose();
    }
  }

  Future<void> scanImage(BuildContext context) async {
    if (cameraController == null) return;

    if (!context.mounted) return;
    showLoadingDialog(context);

    try {
      final picture = await cameraController!.takePicture();

      final file = File(picture.path);
      final inputImage = InputImage.fromFile(file);
      final recognizedText = await textRecognizer.processImage(inputImage);
      if (!context.mounted) return;
      context.pushReplacement(
        Routes.home,
        extra: {"text": recognizedText.text},
      );
    } catch (e) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: Text("Error"),
            content: Text("Can't scan the image"),
          );
        },
      );
    }
  }
}
