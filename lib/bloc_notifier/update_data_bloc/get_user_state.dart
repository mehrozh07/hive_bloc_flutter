part of 'get_user_bloc.dart';

abstract class GetUserState extends Equatable {
  const GetUserState();
  @override
  List<Object> get props => [];
}

class GetUserInitial extends GetUserState {
  @override
  List<Object> get props => [];
}

class GetUserLoading extends GetUserState {
  @override
  List<Object> get props => [];
}

class GetUserSuccess extends GetUserState {
  final UserModel userModel;
  const GetUserSuccess(this.userModel);
  @override
  List<Object> get props => [userModel];
}

class GetUserError extends GetUserState {
  final String error;
  const GetUserError(this.error);
  @override
  List<Object> get props => [error];
}
