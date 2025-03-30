import 'dart:io';

import 'package:camera/camera.dart' as cam;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:speech_app_flutter/app/routes/app_pages.dart';

class CameraController extends GetxController with WidgetsBindingObserver {

   cam.CameraController? cameraController;

  final textRecognizer = TextRecognizer();

  final deviceRatio = Get.width / Get.height;



  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  void didChangeAppLyfeCycleState(AppLifecycleState state){
    if(cameraController == null || cameraController!.value.isInitialized){
      return;
    }

    if(state == AppLifecycleState.inactive){
      stopCamera();
    }else if(state == AppLifecycleState.resumed && cameraController != null && cameraController!.value.isInitialized){
      startCamera();
    }
  }

  void initCameraController(List<cam.CameraDescription> cameras){
    if(cameraController != null){
      return;
    }

    //Select camera
   cam.CameraDescription? camera;
    for(int i = 0; i < cameras.length; i++){
      final cam.CameraDescription currentCamera = cameras[i];
      if(currentCamera.lensDirection == cam.CameraLensDirection.back){
        camera = currentCamera;
        break;
      }
    }

    if(camera != null){
      cameraSelected(camera);
    }
  }

  Future<void> cameraSelected(cam.CameraDescription camera) async{
    cameraController = cam.CameraController(camera, cam.ResolutionPreset.max);

    await cameraController?.initialize();
    update();

  }

  void startCamera() {
    if(cameraController != null){
      cameraSelected(cameraController!.description);
    }
  }

  void stopCamera(){
    if(cameraController != null){
      cameraController?.dispose();
    }
  }

  Future<void> scanImage() async {
    if(cameraController == null) return;

    try{
      final picture = await cameraController!.takePicture();

      final file = File(picture.path);
      final inputImage = InputImage.fromFile(file);
      final recognizedText = await textRecognizer.processImage(inputImage);

      await Get.offAllNamed(Routes.HOME, arguments: {"text": recognizedText.text});
    }catch(e){
      Get.snackbar("Error", "Can't scan the image");
    }
  }

}
