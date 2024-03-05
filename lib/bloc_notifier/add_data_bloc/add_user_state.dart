part of 'add_user_bloc.dart';

abstract class AddUserState extends Equatable {
  const AddUserState();
}

class AddUserInitial extends AddUserState {
  @override
  List<Object> get props => [];
}

class AddUserLoading extends AddUserState {
  @override
  List<Object> get props => [];
}

class AddUserSuccess extends AddUserState {
  @override
  List<Object> get props => [];
}

class AddUserError extends AddUserState {
  final String error;
  const AddUserError(this.error);
  @override
  List<Object> get props => [error];
}
