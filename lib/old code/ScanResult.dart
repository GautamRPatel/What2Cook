import 'dart:io';
import 'package:what2cook/models/RecipeResponse.dart';

class ScanResult {
  final File? image;
  final RecipeResponse? data;
  final bool success;
  final String? error;

  ScanResult({
    this.image,
    this.data,
    required this.success,
    this.error
  });
}
