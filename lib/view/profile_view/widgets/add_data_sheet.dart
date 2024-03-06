import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tericce_animation/bloc_notifier/add_data_bloc/add_user_bloc.dart';
import 'package:tericce_animation/bloc_notifier/update_data_bloc/get_user_bloc.dart';
import 'package:tericce_animation/models/user_model/user_model.dart';
import 'package:tericce_animation/utils/components/form_field.dart';
import 'package:tericce_animation/utils/text_styles/text_styles.dart';

class AddUserDataSheet extends StatefulWidget {
  const AddUserDataSheet({
    super.key,
  });

  @override
  State<AddUserDataSheet> createState() => _AddUserDataSheetState();
}

class _AddUserDataSheetState extends State<AddUserDataSheet> {
  final addUserBloc = AddUserBloc();
  final emailC = TextEditingController();
  final genderC = TextEditingController();
  final dobC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    addUserBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          const SizedBox(height: 8),
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
                          const SizedBox(height: 8),
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
                BlocListener<AddUserBloc, AddUserState>(
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
                        fixedSize: Size(MediaQuery.sizeOf(context).width, 48),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}