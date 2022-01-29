import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttd_todo_list/features/todo_list/data/datasources/todo_local_data_source.dart';
import 'package:ttd_todo_list/features/todo_list/data/repositories/todo_repository_impl.dart';
import 'package:ttd_todo_list/features/todo_list/domain/repositories/todo_repository.dart';
import 'package:ttd_todo_list/features/todo_list/domain/usecases/create_todo_list.dart';
import 'package:ttd_todo_list/features/todo_list/domain/usecases/get_todo_list.dart';
import 'package:ttd_todo_list/features/todo_list/domain/usecases/update_todo.dart';
import 'package:ttd_todo_list/features/todo_list/presentation/bloc/todo_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Feature - Todos
  initFeature();
  //! Core

  //! External
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

void initFeature() {
  // Bloc
  sl.registerFactory(
      () => TodoBloc(getTodoList: sl(), createTodo: sl(), updateTodo: sl()));

  // Usecase
  sl.registerLazySingleton(() => GetTodoList(sl()));
  sl.registerLazySingleton(() => CreateTodo(sl()));
  sl.registerLazySingleton(() => UpdateTodo(sl()));

  // Repository
  sl.registerLazySingleton<TodoRepository>(
      () => TodoRepositoryImpl(localDataSource: sl()));

  // Data resource
  sl.registerLazySingleton<TodoLocalDataSource>(
      () => TodoLocalDataSourceImpl(sharedPreferences: sl()));
}
