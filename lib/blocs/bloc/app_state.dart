part of 'app_bloc.dart';

abstract class UserState extends Equatable {}

//for data loading
class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadedState extends UserState {
  final List<todo> todos;
  UserLoadedState(this.todos);
  @override
  List<Object?> get props => [todos];
}

class UserErrorState extends UserState {
  final String error;
  UserErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
