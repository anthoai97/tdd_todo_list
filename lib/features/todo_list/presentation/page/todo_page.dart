import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttd_todo_list/features/todo_list/data/models/todo_model.dart';
import 'package:ttd_todo_list/features/todo_list/presentation/bloc/todo_bloc.dart';
import 'package:ttd_todo_list/themes/styles.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key, required this.title, this.type}) : super(key: key);
  final String title;
  final bool? type;

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TodoBloc>(context).add(const InitialTodo());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.3),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Tasks',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
      if (state is TodoLoading) {
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        );
      }

      if (state is TodoLoaded) {
        var datas = state.todoList;
        if (widget.type != null) {
          datas = datas.where(((e) => e.status == widget.type!)).toList();
        }

        return datas.isEmpty
            ? const Center(
                child: Text("There is no task todo"),
              )
            : ListView.builder(
                itemCount: datas.length,
                padding: const EdgeInsets.symmetric(horizontal: 15)
                    .copyWith(top: 15),
                itemBuilder: (_, index) {
                  final item = datas[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 15, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset:
                              const Offset(-1, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Expanded(
                            child: Text(
                              item.content,
                              style: const TextStyle(fontSize: 14, height: 1.3),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            value: item.status,
                            onChanged: (bool? value) {
                              if (value != null && value != item.status) {
                                var updateTodo = TodoModel(
                                    content: item.content,
                                    id: item.id,
                                    status: value);
                                BlocProvider.of<TodoBloc>(context).add(
                                    UpdateTodoEvent(
                                        todo: updateTodo,
                                        todoList: state.todoList));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
      }

      return Container();
    });
  }

  @override
  bool get wantKeepAlive => true;
}
