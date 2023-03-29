part of 'app_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUserEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}

class AddTask extends UserEvent {
  final todo task;
  const AddTask({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}

//delete task
class DeleteTask extends UserEvent {
  // final todo task;
  final String id;
  const DeleteTask({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

//update task
class UpdateTask extends UserEvent {
  final todo task;

  const UpdateTask({
    required this.task,
  });

  @override
  List<Object> get props => [task];
}
