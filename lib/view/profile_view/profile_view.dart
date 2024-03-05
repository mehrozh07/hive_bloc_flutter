import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tericce_animation/bloc_notifier/theme_bloc/theme_bloc.dart';
import 'package:tericce_animation/bloc_notifier/update_data_bloc/get_user_bloc.dart';
import 'package:tericce_animation/generated/assets.dart';
import 'package:tericce_animation/utils/components/form_field.dart';
import 'package:tericce_animation/utils/text_styles/text_styles.dart';
import 'package:tericce_animation/view/profile_view/update_profile_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with WidgetsBindingObserver {
  bool changeTheme = false;
  bool enableNotifications = false;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    BlocProvider.of<GetUserBloc>(context).add(GetUserData());
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    _checkNotificationPermission();
    super.initState();
  }

  Future<void> _checkNotificationPermission() async {
    bool? hasPermission = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.areNotificationsEnabled();
    if (hasPermission!) {
      setState(() => enableNotifications = true);
    } else {
      setState(() => enableNotifications = false);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkNotificationPermission();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Screen',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: BlocConsumer<GetUserBloc, GetUserState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetUserLoading) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }
              if (state is GetUserSuccess) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              Image.asset(Assets.assetsTerrace).image,
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Mark Adam',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 30,fontWeight: FontWeight.bold),
                            ),
                            Text('Developer',
                                style: Theme.of(context).textTheme.bodyMedium),
                            TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  visualDensity:
                                      const VisualDensity(horizontal: 2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const UpdateProfileView()));
                              },
                              child: Text('Edit Profile',
                                  style: AppTextStyles.instance.f16w400Black
                                      .copyWith(color: Colors.white)),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('Email',
                        style: AppTextStyles.instance.f16w400Black
                            .copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    CustomFormField(
                      readOnly: true,
                      enable: false,
                      controller: TextEditingController(text: state.userModel.email??'Email Id'),
                      textInputType: TextInputType.name,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Gender',
                                  style: AppTextStyles.instance.f16w400Black
                                      .copyWith(fontWeight: FontWeight.bold)),
                              CustomFormField(
                                readOnly: true,
                                enable: false,
                                controller: TextEditingController(
                                    text: state.userModel.gender??'Gender'),
                                textInputType: TextInputType.name,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Dob',
                                  style: AppTextStyles.instance.f16w400Black
                                      .copyWith(fontWeight: FontWeight.bold)),
                              CustomFormField(
                                readOnly: true,
                                enable: false,
                                controller: TextEditingController(
                                    text: state.userModel.dob ?? 'DOB'),
                                textInputType: TextInputType.name,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomListTile(
                      title: 'Account',
                      subtitle: !changeTheme ? 'Public' : 'Private',
                      value: changeTheme,
                      onChange: (value) {
                        setState(() {
                          changeTheme = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomListTile(
                      title: 'Notification',
                      value: enableNotifications,
                      onChange: (newValue) {
                        setState(() => enableNotifications = newValue);
                        AppSettings.openAppSettings(
                            type: AppSettingsType.notification);
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<ThemeBloc, ThemeData>(
                      builder: (context, state) {
                        return CustomListTile(
                          title: 'Switch Theme',
                          subtitle: 'Dark Mode',
                          value: state == ThemeData.dark(),
                          onChange: (value) {
                            BlocProvider.of<ThemeBloc>(context).add(ThemeSwitchEvent());
                          },
                        );
                      },
                    ),
                  ],
                );
              }
              if (state is GetUserError) {
                return Center(child: Text(state.error));
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function(dynamic)? onChange;
  final bool value;
  const CustomListTile({
    super.key,
    required this.title,
    this.subtitle = '',
    this.onChange,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      // tileColor: Colors.white,
      title: Row(
        children: [
          Text(title,
              style: Theme.of(context).textTheme.bodyLarge),
          const Spacer(),
          if (subtitle.isNotEmpty)
            Text(subtitle,
                style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
      trailing: CupertinoSwitch(
        value: value,
        onChanged: onChange,
      ),
    );
  }
}
