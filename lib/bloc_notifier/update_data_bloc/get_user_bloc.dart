import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:tericce_animation/models/user_model/user_model.dart';

part 'get_user_event.dart';
part 'get_user_state.dart';

class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  GetUserBloc() : super(GetUserInitial()) {
    on<GetUserData>(_fetchUser);
  }

  Future<dynamic> _fetchUser(GetUserData event, Emitter<GetUserState> emit) async{
    emit(GetUserLoading());
    try{
      final box = Hive.box<UserModel>('me');
      emit(GetUserSuccess(box.values.first));
    }catch(e){
      emit(GetUserError(e.toString()));
    }
  }
}
