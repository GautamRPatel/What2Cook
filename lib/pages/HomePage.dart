import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:what2cook/models/Recipe.dart';
import 'package:what2cook/pages/RecipeDetailPage.dart';
import 'dart:io';
import 'package:what2cook/service/CameraService.dart';
import 'package:what2cook/service/SnackbarServie.dart';
import 'package:what2cook/service/UploadToServer.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  CameraService cameraService = CameraService();
  Uploadtoserver uploadToServer = Uploadtoserver();
  SnackbarService snackbarService = SnackbarService();
  File? _imageFile;
  dynamic finalData;
  bool isClickedOnImageUploadOrCapture = false;
  // String uploadError = "";
  // String dataError = "";
  bool isLoading = false;
  bool buttonState = true;
  List<String> recipeName = [];

  final primaryTextColor = Color.fromARGB(255, 45, 51, 42);
  final borderColor = Color.fromARGB(255, 133, 163, 118);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 242, 244, 230),
        scrolledUnderElevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "What2Cook",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                color: primaryTextColor,
              ),
            ),
            InkWell(
              onTap: FirebaseAuth.instance.signOut,
              child: Text('Logout',style: TextStyle(decoration: TextDecoration.underline),),
            )
          ],
        ),
        centerTitle: false,
      ),
      backgroundColor: Color.fromARGB(255, 242, 244, 230),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "WHAT'S IN YOUR\nFRIDGE?",
                  style: TextStyle(
                    letterSpacing: 2.5,
                    wordSpacing: 5,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: primaryTextColor,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 32),
                Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: borderColor, width: 3),
                      ),
                      child: Icon(
                        Icons.upload_sharp,
                        color: borderColor,
                        size: 28,
                      ),
                    ),
                    SizedBox(width: 18),
                    Text(
                      "Upload Vegetable Photo",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: primaryTextColor,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 251, 252, 248),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Center(
                    child:
                        _imageFile != null
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                _imageFile!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            )
                            : isClickedOnImageUploadOrCapture
                            ? const Center(child: CircularProgressIndicator())
                            : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image_outlined,
                                  size: 50,
                                  color: Color.fromARGB(255, 133, 163, 118),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "Preview will appear here after\ncapture/upload",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: primaryTextColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                  ),
                ),

                // if (uploadError.isNotEmpty) ...[
                //   SizedBox(height: 12),
                //   Text(uploadError, style: TextStyle(color: Colors.redAccent)),
                // ],

                SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 55,
                        child: OutlinedButton(
                          style: FilledButton.styleFrom(
                            overlayColor: Colors.blue.shade900,
                            backgroundColor: Color.fromARGB(255, 251, 252, 248),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(12),
                          ),
                          onPressed: () async {
                            try {
                              final image =
                                  await cameraService.pickFromGallery();
                              setState(() {
                                if (image != null) {
                                  _imageFile = image;
                                  // uploadError = "";
                                } else {
                                  // uploadError = "Failed to load image";
                                  snackbarService.showSnackBarMessage('Failed to load image',context);
                                }
                              });
                            } catch (e) {
                              setState(() {
                                // uploadError = "Failed to load image";
                                snackbarService.showSnackBarMessage('Failed to load image',context);
                              });
                            }
                          },
                          child: Center(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.image_search_outlined,
                                  color: borderColor,
                                  size: 30,
                                ),
                                Expanded(
                                  child: Text(
                                    "Gallery",
                                    style: TextStyle(color: primaryTextColor),
                                    overflow: TextOverflow.visible,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 55,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            overlayColor: primaryTextColor,
                            backgroundColor: Color.fromARGB(255, 251, 252, 248),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(12),
                          ),
                          onPressed: () async {
                            try {
                              final image =
                                  await cameraService.pickFromCamera();
                              setState(() {
                                if (image != null) {
                                  _imageFile = image;
                                  // uploadError = "";
                                } else {
                                  // uploadError = "Failed to capture image";
                                  snackbarService.showSnackBarMessage("Failed to capture image", context);
                                }
                              });
                            } catch (e) {
                              setState(() {
                                // uploadError = "Failed to capture image";
                                snackbarService.showSnackBarMessage("Failed to capture image", context);
                              });
                            }
                          },
                          child: Center(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  color: borderColor,
                                  size: 30,
                                ),
                                Expanded(
                                  child: Text(
                                    "Camera",
                                    style: TextStyle(color: primaryTextColor),
                                    overflow: TextOverflow.visible,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    SizedBox(
                      height: 55,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          overlayColor: primaryTextColor,
                          backgroundColor: Color.fromARGB(255, 251, 252, 248),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          try {
                            if (_imageFile != null &&
                                await _imageFile!.exists()) {
                              await _imageFile!.delete();
                            }
                            setState(() {
                              _imageFile = null;
                              finalData = null;
                              // uploadError = "";
                              isLoading = false;
                              // dataError = "";
                              recipeName = [];
                              buttonState = true;
                            });
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Icon(Icons.delete, color: borderColor, size: 28),
                      ),
                    ),
                  ],
                ),
                // if (dataError.isNotEmpty) ...[
                //   SizedBox(height: 32),
                //   Text(dataError, style: TextStyle(color: Colors.redAccent)),
                //
                // ],


                if (buttonState) ...[
                  SizedBox(height: 100,),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(12),
                        backgroundColor:  Color.fromARGB(229, 64, 89, 51),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        )

                      ),
                      onPressed: () async {
                        if (_imageFile != null) {
                          try {
                            setState(() {
                              buttonState = false;
                              isLoading = true;
                            });
                            final Map<String,dynamic> response = await uploadToServer.uploadToServer(_imageFile!);
                            // final response = await uploadToServer.fetchRecipes();
                            setState(() {
                              if (response['success'] == true) {
                                finalData = response['data'];
                                print(
                                  "inside homepage data : ${finalData!.detectedVegetables}",
                                );

                                for (Recipe rec
                                    in finalData!.topRecipes) {
                                  recipeName.add(rec.name.toString());
                                }
                              } else {
                                snackbarService.showSnackBarMessage(response['detail'].toString(), context);

                                  _imageFile = null;
                                  finalData = null;
                                  isLoading = false;
                                  recipeName = [];
                                  buttonState = true;
                                  return;
                              }
                              isLoading = false;
                              setState(() {
                                buttonState = false;
                              });
                            });
                          } catch (e) {
                            setState(() {
                              snackbarService.showSnackBarMessage(e.toString(), context);
                              buttonState = true;
                            });
                          }
                        } else {
                          snackbarService.showSnackBarMessage('Please upload/capture image for detection', context);
                        }

                      },

                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.auto_awesome,color:  Color.fromARGB(255, 251, 252, 248),size: 20,),
                          SizedBox(width: 12,),
                          Text("Generate",style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color:  Color.fromARGB(255, 251, 252, 248),
                          ),),
                        ],
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 32),
                if (isLoading)
                  Column(
                    children: [
                      SizedBox(height: 50),
                      Center(
                        child: CircularProgressIndicator(
                          color: borderColor,
                        ),
                      ),
                    ],
                  ),

                if (finalData != null) ...[
                  Text(
                    "Detected Ingredients",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: primaryTextColor,
                    ),
                  ),
                  SizedBox(height: 32),
                  Container(
                    color: Color.fromARGB(255, 251, 252, 248),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: finalData!.detectedVegetables.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 6, // adjust height ratio
                            ),
                        itemBuilder: (context, index) {
                          final vege = finalData!.detectedVegetables[index];
                          return Row(
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: borderColor,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  vege,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: primaryTextColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  Text(
                    "Recipes",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: primaryTextColor,
                    ),
                  ),

                  const SizedBox(height: 32),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: finalData!.topRecipes.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.85, // adjust height ratio
                        ),
                    itemBuilder: (context, index) {
                      final recipe = finalData!.topRecipes[index];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => RecipeDetailPage(recipe: recipe),
                            ),
                          );
                        },
                        // child: recipeCard(recipe.name),
                        child: Card(
                          color: Color.fromARGB(255, 251, 252, 248),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/ChatGPT Image Feb 28, 2026, 03_49_00 PM.png",
                                  height: 100,
                                ),
                                // SizedBox(height: 32,),
                                Text(
                                  recipe.name,
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () async {
      //     if (_imageFile != null) {
      //       try {
      //         setState(() {
      //           isLoading = true;
      //         });
      //         // final response = await uploadToServer.uploadToServer(_imageFile!);
      //         final response = await uploadToServer.fetchRecipes();
      //         setState(() {
      //           if (response != null) {
      //             finalData = response;
      //             print(
      //               "inside homepage data : ${finalData!.detectedVegetables}",
      //             );
      //
      //             // for (Recipe rec
      //             //     in finalData!.topRecipes) {
      //             //   recipeName.add(rec.name.toString());
      //             // }
      //           } else {
      //             dataError =
      //                 "No any recipes suggested for your uploaded image";
      //           }
      //           isLoading = false;
      //         });
      //       } catch (e) {
      //         setState(() {
      //           uploadError = e.toString();
      //         });
      //       }
      //     } else {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(
      //           content: Text("Please upload/capture image for detection"),
      //         ),
      //       );
      //     }
      //   },
      //   backgroundColor: Color.fromARGB(255, 118, 170, 89),
      //   label: Icon(
      //     Icons.auto_awesome,
      //     color: Color.fromARGB(255, 251, 252, 248),
      //   ),
      // ),
    );
  }
}
