import 'package:blochttpget/blocs/bloc/app_bloc.dart';
import 'package:blochttpget/models/user_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'DetailScreen.dart';
import 'Theme/theme_data.dart';
import 'blocs/switch_bloc/switch_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
            create: (context) => UserBloc()..add(LoadUserEvent())),
        BlocProvider<SwitchBloc>(create: (context) => SwitchBloc()),
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
              title: 'Flutter Demo',
              //theme: Styles.themeData(state.switchValue, context),
              theme: state.switchValue
                  ? AppThemes.appThemeData[AppTheme.darkTheme]
                  : AppThemes.appThemeData[AppTheme.lightTheme],
              home: const Home());
          // home: RepositoryProvider(
          //   create: (context) => UserRepository(),
          //   child: Home(),
          // ));
        },
      ),
    );

    //
    // BlocProvider(
    //     create: (context) => UserBloc(),
    //     child: MaterialApp(
    //       title: 'Flutter Demo',
    //       theme: ThemeData(
    //         primarySwatch: Colors.blue,
    //       ),
    //       // home: RepositoryProvider(
    //       //   create: (context) => UserRepository(),
    //       //   child: Home(),
    //       // )),

    //       home: Home(),
    //     ));
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: (context) => UserBloc()..add(LoadUserEvent()),
    //   child: BlocBuilder<UserBloc, UserState>(
    //     builder: (context, state) {
    return Scaffold(
        appBar: AppBar(),
        drawer: mydrawer(),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UserLoadedState) {
              List<todo> userList = state.todos;
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<UserBloc>().add(LoadUserEvent());
                },
                child: ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (_, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) =>
                                  DetailScreen(e: userList[index])));
                        },
                        onLongPress: () {
                          // BlocProvider.of<UserBloc>(context).add(DeleteTask(
                          //     id: userList[index].sId.toString()));
                          context.read<UserBloc>().add(
                              DeleteTask(id: userList[index].sId.toString()));
                          toastMassage('Deleted successfully');
                          context.read<UserBloc>().add(LoadUserEvent());
                          print(userList[index].sId.toString());
                        },
                        child: Card(
                          elevation: 4,
                          margin: const EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                child: Text((index + 1).toString()),
                              ),
                              title: Text(
                                userList[index].title!,
                                style: TextStyle(fontSize: 20),
                              ),
                              subtitle: Text(
                                userList[index].description!,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    var editedTask = todo(
                                        sId: userList[index].sId,
                                        title: 'okok',
                                        description: 'jojo',
                                        isCompleted: true);
                                    context.read<UserBloc>().add(UpdateTask(
                                          task: editedTask,
                                        ));
                                    toastMassage('Edited successfully');
                                    context
                                        .read<UserBloc>()
                                        .add(LoadUserEvent());
                                  }),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            } else if (state is UserErrorState) {
              return const Center(
                child: Text('error'),
              );
            }
            return Container();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            var task = todo(
                title: 'gg',
                description: 'fgadfgafdgdafgsffgfd',
                isCompleted: false);

            BlocProvider.of<UserBloc>(context).add(AddTask(task: task));
            context.read<UserBloc>().add(LoadUserEvent());
          },
          child: const Icon(Icons.add),
        ));
  }
  //   ),
  // );
}
// }

class mydrawer extends StatelessWidget {
  const mydrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(child: Center(
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return SwitchListTile(
            title: Text('Dark Mode'),
            value: state.switchValue,
            onChanged: (value) {
              value
                  ? context.read<SwitchBloc>().add(SwitchOnEvent())
                  : context.read<SwitchBloc>().add(SwitchOffEvent());
            },
          );
        },
      ),
    ));
  }
}

void toastMassage(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Color.fromARGB(255, 147, 144, 143),
      textColor: Colors.white,
      fontSize: 16.0);
}
