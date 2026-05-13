// import 'dart:io';
//
// import 'package:what2cook/old%20code/ScanResult.dart';
// import 'package:what2cook/service/CameraService.dart';
// import 'package:what2cook/service/UploadToServer.dart';
//
// class HomeController{
//   final _cameraService = CameraService();
//   final _uploadToServerService = Uploadtoserver();
//
//   Future<ScanResult> captureAndUpload(String source) async{
//     File? image;
//     if(source == "camera"){
//       image =  await _cameraService.pickFromCamera();
//     }
//     else{
//       image = await _cameraService.pickFromGallery();
//     }
//
//     if(image == null){
//       return ScanResult(success: false,error: "No image");
//     }
//     final response = await _uploadToServerService.uploadToServer(image);
//
//     if(response == null){
//       return ScanResult(success: false,error: "Api request failed");
//     }
//     return ScanResult(success: true,image: image,data: response);
//   }
// }