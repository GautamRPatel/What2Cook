import 'package:flutter/material.dart';


class SnackbarService{
  void showSnackBarMessage(String msg , BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: TextStyle(
            color: Colors.white,fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
        backgroundColor:  Color.fromARGB(229, 64, 89, 51),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
        ),
        margin: EdgeInsets.all(16),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }
}