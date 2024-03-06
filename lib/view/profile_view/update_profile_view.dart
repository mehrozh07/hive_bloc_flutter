import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:tericce_animation/bloc_notifier/add_data_bloc/add_user_bloc.dart';
import 'package:tericce_animation/bloc_notifier/update_data_bloc/get_user_bloc.dart';
import 'package:tericce_animation/generated/assets.dart';
import 'package:tericce_animation/models/user_model/user_model.dart';
import 'package:tericce_animation/utils/components/form_field.dart';
import 'package:tericce_animation/utils/text_styles/text_styles.dart';
import 'package:tericce_animation/view/profile_view/widgets/edit_profile_widget.dart';

class UpdateProfileView extends StatelessWidget {
  const UpdateProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit Screen',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<GetUserBloc, GetUserState>(
              builder: (context, state) {
                if(state is GetUserLoading){
                  return const Center(child: CircularProgressIndicator.adaptive());
                }if(state is GetUserError){
                  return Center(child: Text(state.error));
                }
                if(state is GetUserSuccess) {
                  return EditProfileWidget(userModel: state.userModel);
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
