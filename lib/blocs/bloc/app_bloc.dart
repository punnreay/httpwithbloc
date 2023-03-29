import 'package:bloc/bloc.dart';
import 'package:blochttpget/models/user_model.dart';
import 'package:blochttpget/repos/repositories.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final users = await UserRepository.getUsers();
        emit(UserLoadedState(users));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
    on<AddTask>(_onAddTask);
    on<DeleteTask>(_onDeleteTask);
    on<UpdateTask>(_onUpdateTask);
  }
  void _onAddTask(AddTask event, Emitter<UserState> emit) async {
    await UserRepository.postUser(event.task);
  }

  void _onDeleteTask(DeleteTask event, Emitter<UserState> emit) async {
    await UserRepository.deleteUser(event.id);
  }

  void _onUpdateTask(UpdateTask event, Emitter<UserState> emit) async {
    await UserRepository.updateUser(event.task);
  }
}
