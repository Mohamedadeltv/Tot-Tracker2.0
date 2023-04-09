// import 'package:concentric_transition/concentric_transition.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:tottracker/NEW_SCREENS/features_overview_screen.dart';

// final pages = [
//   const PageData(
//     icon: Icons.food_bank_outlined,
//     title: "Search for your favourite food",
//     bgColor: Color(0xff3b1791),
//     textColor: Colors.white,
//   ),
//   const PageData(
//     icon: Icons.shopping_bag_outlined,
//     title: "Add it to cart",
//     bgColor: Color(0xfffab800),
//     textColor: Color(0xff3b1790),
//   ),
//   const PageData(
//     icon: Icons.delivery_dining,
//     title: "Order and wait",
//     bgColor: Color(0xffffffff),
//     textColor: Color(0xff3b1790),
//   ),
// ];

// class ConcentricAnimationOnboarding extends StatefulWidget {
//   @override
//   _ConcentricAnimationOnboardingState createState() =>
//       _ConcentricAnimationOnboardingState();
// }

// class _ConcentricAnimationOnboardingState
//     extends State<ConcentricAnimationOnboarding> {
//   int _tapCount = 0;

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     return MaterialApp(
//       home: Scaffold(
//         body: PageView.builder(
//           itemCount: pages.length,
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTapDown: (details) {
//                 if (details.localPosition.dx > 0 &&
//                     details.localPosition.dx < screenWidth) {
//                   setState(() {
//                     if (index == 0) {
//                       // Search for your favourite food was tapped
//                       _tapCount++;
//                       index++;
//                       print("Tapped on index: $index, Tap count: $_tapCount");
//                     } else if (index == 1) {
//                       // Add it to cart was tapped
//                       if (_tapCount == 1) {
//                         _tapCount++;
//                         index++;
//                         print("Tapped on index: $index, Tap count: $_tapCount");
//                       }
//                     } else if (index == 2) {
//                       // Order and wait was tapped
//                       if (_tapCount == 2) {
//                         _tapCount++;
//                         print("Tapped on index: $index, Tap count: $_tapCount");
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => FeaturesOverviewScreen(),
//                           ),
//                         );
//                       }
//                     }
//                   });
//                 }
//               },
//               child: GestureDetector(
//                 onTapDown:
//                     (_) {print("Inner tap detected");}, // Prevent inner GestureDetector from consuming the tap
//                 child: ConcentricPageView(
//                   colors: pages.map((p) => p.bgColor).toList(),
//                   radius: screenWidth * 0.1,
//                   nextButtonBuilder: (context) => Padding(
//                     padding: const EdgeInsets.only(left: 3),
//                     child: Icon(
//                       Icons.navigate_next,
//                       size: screenWidth * 0.08,
//                     ),
//                   ),
//                   itemBuilder: (index) {
//                     final page = pages[index % pages.length];
//                     return SafeArea(
//                       child: _Page(page: page),
//                     );
//                   },
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class PageData {
//   final String? title;
//   final IconData? icon;
//   final Color bgColor;
//   final Color textColor;

//   const PageData({
//     this.title,
//     this.icon,
//     this.bgColor = Colors.white,
//     this.textColor = Colors.black,
//   });
// }

// class _Page extends StatelessWidget {
//   final PageData page;

//   const _Page({Key? key, required this.page}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           padding: const EdgeInsets.all(16.0),
//           margin: const EdgeInsets.all(16.0),
//           decoration:
//               BoxDecoration(shape: BoxShape.circle, color: page.textColor),
//           child: Icon(
//             page.icon,
//             size: screenHeight * 0.1,
//             color: page.bgColor,
//           ),
//         ),
//         Text(
//           page.title ?? "",
//           style: TextStyle(
//               color: page.textColor,
//               fontSize: screenHeight * 0.035,
//               fontWeight: FontWeight.bold),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }
// }
