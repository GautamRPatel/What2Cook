import 'dart:io';

import 'package:image_picker/image_picker.dart';

class CameraService{
  final ImagePicker _picker = ImagePicker();


  Future<dynamic> pickFromCamera() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 2048,
        maxHeight: 2048,
        imageQuality: 100,
      );
      if (picked != null) {
          return File(picked.path);
      }
      return null;
    } catch (e) {
      print(" Failed to load camera $e");
      throw Exception("Failed to load camera");
    }
  }

  Future<dynamic> pickFromGallery() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 2048,
        maxHeight: 3048,
        imageQuality: 100,
      );
      if (picked != null) {
          return File(picked.path);
      }
      return null;
    } catch (e) {
      print("Failed to load image from local-storage $e");
      throw Exception("Failed to load gallery");
    }
  }
}