import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tericce_animation/models/user_model/user_model.dart';
part 'add_user_event.dart';
part 'add_user_state.dart';

class AddUserBloc extends Bloc<AddUserEvent, AddUserState> {
  AddUserBloc() : super(AddUserInitial()) {
    on<AddUserData>(_addData);
  }

  Future<dynamic> _addData(AddUserData event, Emitter<AddUserState> emit) async{
    emit(AddUserLoading());
    try{
      final box = Hive.box<UserModel>('me');
      log('message===> ${box.isOpen}');
      await box.put('currentUser', event.data);
      emit(AddUserSuccess());
    }catch(e){
      emit(AddUserError(e.toString()));
    }
  }
}
