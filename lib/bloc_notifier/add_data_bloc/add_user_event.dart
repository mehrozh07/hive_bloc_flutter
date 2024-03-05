part of 'add_user_bloc.dart';

abstract class AddUserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddUserData extends AddUserEvent{
  final UserModel data;
  AddUserData(this.data);
  @override
  List<Object> get props => [data];
}
