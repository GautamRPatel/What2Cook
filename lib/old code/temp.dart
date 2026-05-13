// dynamic results() {
//   if (isLoadingResults) {
//     return const Center(
//       child: Padding(
//         padding: EdgeInsets.only(top: 50.0, bottom: 50.0),
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
//   if (finalData == null) {
//     return Text(
//       "No Data Available yet",
//       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//     );
//   } else if ((finalData!['predicted_objects'] as List).isEmpty) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.only(top: 20.0, bottom: 50),
//         child: Column(
//           children: [
//             Icon(Icons.block_flipped, size: 60, color: Colors.red),
//             SizedBox(height: 5),
//             Text(
//               textAlign: TextAlign.center,
//               "Please upload image relatable to vegetable\nPlease try again with other image",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//             ),
//           ],
//         ),
//       ),
//     );
//   } else if (finalData!['predicted_objects'] != null &&
//       finalData!['predicted_objects'] is List) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         for (var obj in finalData!['predicted_objects'])
//           Padding(
//             padding: const EdgeInsets.only(bottom: 6.0),
//             child: Text("* $obj", style: TextStyle(fontSize: 16)),
//           ),
//       ],
//     );
//   }
//   return "";
// }

// Text(
//   "Recommended Results",
//   style: TextStyle(
//     color: Colors.blue.shade800,
//     fontSize: 25,
//     fontWeight: FontWeight.w500,
//   ),
// ),
// SizedBox(height: 15),
//
// results(),
// Padding(
//   padding: const EdgeInsets.fromLTRB(40, 45, 40, 45),
//   child: ElevatedButton(
//     onPressed: () {
//       setState(() {
//         isButtonEnabled = !isButtonEnabled;
//       });
//     },
//     style: ElevatedButton.styleFrom(
//       backgroundColor: Colors.orange.shade600,
//     ),
//     child: Container(
//       margin: EdgeInsets.only(top: 20, bottom: 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.auto_awesome,
//             size: 25,
//             color: Colors.white,
//           ),
//           SizedBox(width: 15),
//           Text(
//             "Get Recommendations",
//             style: TextStyle(fontSize: 18, color: Colors.white),
//           ),
//         ],
//       ),
//     ),
//   ),
// ),
// SizedBox(height: 10,),
//
// SizedBox(height: 10,),
// for (var recipe in demoRecipes)
//   InkWell(
//     onTap: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => RecipeDetailPage(recipe: recipe),
//         ),
//       );
//     },
//     child: Card(
//       color: Colors.blue.shade600,
//       child: ListTile(
//         leading: Icon(
//           Icons.restaurant_menu,
//           color: Colors.white,
//         ),
//         title: Text(
//           recipe["recipe_name"]!,
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//     ),
//   ),
