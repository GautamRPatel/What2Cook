import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:what2cook/models/RecipeResponse.dart';

class Uploadtoserver{
  Future<Map<String,dynamic>> uploadToServer(File image) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        // Uri.parse("https://cookmate-2yk1.onrender.com/api/predict"),
        Uri.parse("http://10.0.2.2:8000/api/predict"),
      );

      request.files.add(
        await http.MultipartFile.fromPath('file', image.path),
      );
      var response = await request.send();

      if (response.statusCode == 200) {
        var respStr = await response.stream.bytesToString();
        var data = json.decode(respStr);
        print(data);
        data = RecipeResponse.fromJson(data);
        return {
          "success":true,
          "data": data,
        };
      } else {
        print("Upload failed ${response.statusCode}");
        var respStr = await response.stream.bytesToString();
        var data = json.decode(respStr);
        return {
          "success":false,
          "detail": data['detail'] ?? "Upload Failed"
        };
      }
    } catch (e) {
      print(e);
      print("inside upload server");
      throw Exception("Api Request failed,try again");
    }
  }
}