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

class EditProfileWidget extends StatefulWidget {
  final UserModel userModel;
  const EditProfileWidget({super.key, required this.userModel});

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  final addUserBloc = AddUserBloc();
  final emailC = TextEditingController();
  final genderC = TextEditingController();
  final dobC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  UserModel get _userModel => widget.userModel;


  @override
  void initState() {
    emailC.text = _userModel.email.toString();
    genderC.text = _userModel.gender.toString();
    dobC.text = _userModel.dob.toString();
    super.initState();
  }

  @override
  void dispose() {
   addUserBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF3366FF).withOpacity(0.5),
                  const Color(0xFF00CCFF).withOpacity(0.6),
                ],
                begin: AlignmentDirectional.bottomCenter,
                end: AlignmentDirectional.topCenter,
                stops: const [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: Image.asset(Assets.assetsTerrace).image,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mark Adam',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text('Developer',
                        style:  Theme.of(context).textTheme.bodyMedium),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text('Email',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16,fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                CustomFormField(
                  controller: emailC,
                  validator: (value){
                    if(value.toString().isEmpty || emailC.text.isEmpty){
                      return 'Please enter email*';
                    }
                    return null;
                  },
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
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16,fontWeight: FontWeight.bold)),
                          CustomFormField(
                            controller: genderC,
                            validator: (value){
                              if(value.toString().isEmpty || genderC.text.isEmpty){
                                return 'Please enter gender*';
                              }
                              return null;
                            },
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
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16,fontWeight: FontWeight.bold)),
                          CustomFormField(
                            controller: dobC,
                            readOnly: true,
                            validator: (value){
                              if(value.toString().isEmpty || dobC.text.isEmpty){
                                return 'Please enter dob*';
                              }
                              return null;
                            },
                            onPressed: (){
                              showDatePicker(
                                context: context,
                                initialDate: DateTime(2000),
                                firstDate: DateTime(1900)
                                , lastDate: DateTime.now(),
                              ).then((value) {
                                if(value != null){
                                  setState(() => dobC.text = DateFormat('dd MMM yyyy').format(value));
                                }
                              });
                            },
                            textInputType: TextInputType.name,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                            visualDensity: const VisualDensity(vertical: 2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(color: Colors.blue))),
                        onPressed: () async{
                          Navigator.pop(context);
                        },
                        child: Text('Cancel',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 16,fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: BlocListener<AddUserBloc, AddUserState>(
                        bloc: addUserBloc,
                        listener: (context, state) {
                          if(state is AddUserLoading){
                            const Center(child: CircularProgressIndicator.adaptive());
                          }if(state is AddUserSuccess){
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User updated')));
                            BlocProvider.of<GetUserBloc>(context).add(GetUserData());
                          }if(state is AddUserError){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
                          }
                        },
                        child: TextButton(
                          style: TextButton.styleFrom(
                              visualDensity: const VisualDensity(vertical: 2),
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              )),
                          onPressed: () {
                            if(_formKey.currentState!.validate()) {
                              final user = UserModel(
                              title: 'David Richard',
                              bio: 'Flutter Developer',
                              email: emailC.text.trim(),
                              gender: genderC.text.trim(),
                              dob: dobC.text.trim(),
                              id: '1',
                              );
                              addUserBloc.add(AddUserData(user));
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill form')));
                            }
                          },
                          child: Text('Save',
                              style: AppTextStyles.instance.f16w400Black
                                  .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
