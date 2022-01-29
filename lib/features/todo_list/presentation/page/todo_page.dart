import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttd_todo_list/themes/styles.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
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

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 15),
      itemCount: 20,
      itemBuilder: (_, index) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(-1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: const Expanded(
                child: Text(
                  'coans dasd ad asd asd asd asd asd asd asd sadas das dasd as',
                  style: TextStyle(fontSize: 14, height: 1.3),
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: false,
                onChanged: (bool? value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
