import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tericce_animation/bloc_notifier/theme_bloc/theme_bloc.dart';
import 'package:tericce_animation/bloc_notifier/update_data_bloc/get_user_bloc.dart';
import 'package:tericce_animation/generated/assets.dart';
import 'package:tericce_animation/models/user_model/user_model.dart';
import 'package:tericce_animation/utils/theme_helper.dart';
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
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeType>(
        builder: (context, state) {
          final ThemeData themeData = state == ThemeType.dark ?
          ThemeData.dark().copyWith(
            textTheme: darkTextTheme,
              listTileTheme: darkListTileThemeData,
            inputDecorationTheme: darkInputDecorationTheme,
          ) :
          ThemeData.light().copyWith(
            textTheme: lightTextTheme,
            scaffoldBackgroundColor: Colors.grey.shade200,
            inputDecorationTheme: lightInputDecorationTheme,
            listTileTheme: lightListTileThemeData
          );
          return MaterialApp(
            theme: themeData,
            title: 'Flutter Assessment',
            debugShowCheckedModeBanner: false,
            home: const ProfileView(),
          );
        },
      ),
    );
  }
}