import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tericce_animation/bloc_notifier/theme_bloc/theme_bloc.dart';
import 'package:tericce_animation/bloc_notifier/update_data_bloc/get_user_bloc.dart';
import 'package:tericce_animation/generated/assets.dart';
import 'package:tericce_animation/models/user_model/user_model.dart';
import 'package:tericce_animation/view/create_time/screens/create_time_view.dart';
import 'package:tericce_animation/view/profile_view/profile_view.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'view/animation2/flip_terrace.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  if (directory != null) {
    Hive.init(directory.path);
    Hive.registerAdapter(UserModelAdapter());
    await Hive.openBox<UserModel>('me');
    runApp(MultiBlocProvider(providers: [
      BlocProvider(create: (_) => GetUserBloc()..add(GetUserData())),
      BlocProvider(create: (_) => ThemeBloc()..add(InitialThemeSetEvent())),
    ], child: const MyApp()));
  } else {
    print('Error: Unable to get application documents directory.');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeData>(
      builder: (context, state) {
        return MaterialApp(
          theme: state.copyWith(
              // textTheme: const TextTheme(
              //     titleLarge: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         color: Colors.black,
              //         fontSize: 20
              //     )
              // )
          ),
          title: 'Flutter Demo',
          darkTheme: state.copyWith(
            // textTheme: const TextTheme(
            //   titleLarge: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     color: Colors.white,
            //     fontSize: 20
            //   )
            // )
          ),
          debugShowCheckedModeBanner: false,
          home: const ProfileView(),
        );
      },
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: const Text('My Terrace Animation'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               const Text(
//                 'You have pushed the button this many times:',
//               ),
//               const SizedBox(height: 50),
//               TextButton(
//                   onPressed: (){
//                     showDialog(
//                         context: context,
//                         barrierDismissible: false,
//                         builder: (context){
//                           return const SnakeButton();
//                         },
//                     );
//                     // Navigator.push(context, MaterialPageRoute(builder: (_)=> SnakeButton()));
//                   },
//                   child: const Text('Snake button'),
//               ),
//               TextButton(
//                   onPressed: (){
//                     showDialog(
//                         context: context,
//                         barrierDismissible: false,
//                         builder: (context){
//                           return AnimatedContainerWidget();
//                         },
//                     );
//                     // Navigator.push(context, MaterialPageRoute(builder: (_)=> SnakeButton()));
//                   },
//                   child: const Text('Rotated button'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class SnakeButton extends StatefulWidget {
//   final Duration? duration;
//   final Widget? child;
//   const SnakeButton({super.key, this.duration, this.child});
//
//   @override
//   State<SnakeButton> createState() => _SnakeButtonState();
// }
//
// class _SnakeButtonState extends State<SnakeButton>
//     with SingleTickerProviderStateMixin {
//   AnimationController? _controller;
//
//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: widget.duration ?? const Duration(milliseconds: 1500),
//     );
//     _controller?.repeat();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: Colors.transparent,
//       shadowColor: Colors.transparent,
//       surfaceTintColor: Colors.transparent,
//       contentPadding: EdgeInsets.zero,
//       content: SingleChildScrollView(
//         child: Center(
//           child: Container(
//             width: 60,
//             height: 60,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12)
//             ),
//             child: CustomPaint(
//               painter: _SnakePainter(
//                 animation: _controller!,
//                 borderRadius: 15,
//                 snakeColor: const Color(0xff004DFF)
//               ),
//               child: Container(
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: Colors.transparent
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(7),
//                     child: Image.asset(Assets.assetsTerrace,
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _SnakePainter extends CustomPainter {
//   final Animation animation;
//   final Color snakeColor, borderColor;
//   final double borderWidth, borderRadius;
//
//   _SnakePainter({
//     required this.animation,
//     this.snakeColor = Colors.purple,
//     this.borderColor = Colors.transparent,
//     this.borderWidth = 4,
//     this.borderRadius = 12,
//   }) : super(repaint: animation);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final rect = Rect.fromPoints(Offset.zero, Offset(size.width, size.height));
//     final paint = Paint()
//       ..shader = SweepGradient(
//         colors: [
//           snakeColor,
//           Colors.transparent,
//         ],
//         stops: const [0.7, 1.0],
//         startAngle: 0,
//         endAngle: vector.radians(80),
//         transform: GradientRotation(vector.radians(360 * animation.value as double)),
//       ).createShader(rect);
//
//     final path = Path.combine(
//       PathOperation.xor,
//       Path()..addRect(rect),
//       Path()..addRect(rect.deflate(borderWidth)),
//     );
//
//     // Draw the border with border radius
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(rect.deflate(borderWidth / 2), Radius.circular(borderRadius)),
//       Paint()
//         ..color = borderColor
//         ..strokeWidth = borderWidth
//         ..style = PaintingStyle.stroke,
//     );
//     canvas.drawRRect(
//       RRect.fromRectAndRadius(rect.deflate(borderWidth / 2), Radius.circular(borderRadius)),
//       paint,
//     );
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
