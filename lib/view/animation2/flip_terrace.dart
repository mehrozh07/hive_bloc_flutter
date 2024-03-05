// import 'package:flutter/material.dart';
// import 'package:tericce_animation/generated/assets.dart';
//
// class AnimatedContainerWidget extends StatefulWidget {
//   @override
//   _AnimatedContainerWidgetState createState() => _AnimatedContainerWidgetState();
// }
//
// class _AnimatedContainerWidgetState extends State<AnimatedContainerWidget> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Initialize animation controller
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2), // Adjust duration as needed
//     );
//
//     // Define the animation curve
//     final curve = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
//
//     // Define tween for container movement from 0 to 180 degrees
//     _animation = Tween<double>(begin: 0, end: 180).animate(curve);
//
//     // Start animation
//     _controller.forward();
//
//     // Listen to animation status
//     _controller.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         _controller.reverse();
//       } else if (status == AnimationStatus.dismissed) {
//         _controller.forward();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         return Transform.rotate(
//           angle: _animation.value * 0.0174533, // Convert degrees to radians
//           child: Transform.scale(
//             scale: 0.15,
//             child: Image.asset(Assets.assetsTerrace),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
