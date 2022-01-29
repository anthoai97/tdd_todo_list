import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ttd_todo_list/themes/styles.dart';

typedef SubmitFunctionCallback = void Function(String content);

class _CreateTaskDialog extends StatefulWidget {
  final SubmitFunctionCallback submitFunction;

  const _CreateTaskDialog({
    required this.submitFunction,
  });

  @override
  __CreateTaskDialogState createState() => __CreateTaskDialogState();
}

class __CreateTaskDialogState extends State<_CreateTaskDialog> {
  final double _radius = 7.0;
  final double _spacing = 15.0;
  final double _buttonHeight = 50;

  final TextEditingController _textAreaTextController =
      TextEditingController(text: '');
  final FocusNode _textAreaFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  void _submitDialog() {
    FocusScope.of(context).unfocus();
    String note = _textAreaTextController.text;
    if (note.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Content task must not empty',
        gravity: ToastGravity.CENTER,
      );
      return;
    }

    widget.submitFunction(_textAreaTextController.text);

    Navigator.pop(context);
  }

  Widget _renderTitle() {
    String title = 'Create Task';

    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(_spacing),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_radius),
          topRight: Radius.circular(_radius),
        ),
        color: const Color(0xFFF0F0F0),
      ),
      child: Text(
        title,
        textScaleFactor: 1.0,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _renderTextArea() {
    return Container(
      margin: EdgeInsets.only(
        top: _spacing,
        left: _spacing,
        right: _spacing,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Task content",
            textScaleFactor: 1.0,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 15,
            ),
          ),
          GestureDetector(
            onTap: () {
              SystemChannels.textInput.invokeMethod('TextInput.show');
              _textAreaFocusNode.requestFocus();
            },
            child: Container(
              // height: _buttonHeight * 1.5,
              width: double.infinity,
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 7.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(
                  width: 1.0,
                  color: Colors.grey,
                ),
              ),
              child: TextField(
                controller: _textAreaTextController,
                focusNode: _textAreaFocusNode,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                keyboardType: TextInputType.text,
                cursorColor: Colors.grey,
                maxLines: null,
                minLines: 3,
                decoration: const InputDecoration(
                  isDense: true,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintText: "Input task content",
                  contentPadding: EdgeInsets.only(bottom: 0),
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderButton() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: _buttonHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(_radius),
              ),
              color: Colors.white,
            ),
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(0.0),
                  textStyle: const TextStyle(color: Colors.black)),
              child: Text(
                "Cancel".toUpperCase(),
                textScaleFactor: 1.0,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 1,
          height: _buttonHeight,
          child: const VerticalDivider(
            color: Colors.grey,
            thickness: 1.0,
          ),
        ),
        Expanded(
          child: Container(
            height: _buttonHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(_radius),
              ),
              color: Colors.white,
            ),
            child: TextButton(
              onPressed: () => _submitDialog(),
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(0.0),
              ),
              child: Text(
                "Create".toUpperCase(),
                textScaleFactor: 1.0,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildElement = Container(
      constraints: BoxConstraints(maxWidth: 320),
      margin: EdgeInsets.only(
        left: _spacing,
        right: _spacing,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(_radius)),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Title
            _renderTitle(),
            // Reason
            _renderTextArea(),
            // Spacing
            const SizedBox(height: 15.0),
            // Horizontal divider
            const Divider(
              color: Color(0xFFABABAB),
              height: 1,
              thickness: 1.0,
            ),
            // Button
            _renderButton(),
          ],
        ),
      ),
    );

    return _buildElement;
  }
}

Future<T?> showCreateTaskDialog<T>(
  BuildContext context, {
  required SubmitFunctionCallback submitFunction,
}) async {
  return await showGeneralDialog(
    context: context,
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
        child: child,
      );
    },
    pageBuilder: (context, anim1, anim2) {
      return Material(
        type: MaterialType.transparency,
        child: Container(
          alignment: Alignment.center,
          margin: MediaQuery.of(context).viewInsets,
          child: _CreateTaskDialog(
            submitFunction: submitFunction,
          ),
        ),
      );
    },
  );
}
