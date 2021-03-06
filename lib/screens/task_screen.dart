import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ignite_flutter_todo_list/controllers/home_controller.dart';

import '../shared/models/todo_item.dart';
import 'components/todo_item_list_tile.dart';

class TaskScreen extends StatefulWidget {
  final HomeController controller;

  const TaskScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _toDoItemTitleEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Observer(
          builder: (_) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 24),
                Text(
                  'Pendentes',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 24),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _toDoItemTitleEditingController,
                        ),
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.blue,
                          size: 24,
                        ),
                        onPressed: () {
                          if (_toDoItemTitleEditingController.text.isNotEmpty) {
                            widget.controller.onAddItem(
                                _toDoItemTitleEditingController.text);

                            _toDoItemTitleEditingController.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Flexible(child: Observer(
                  builder: (_) {
                    return ListView.builder(
                      itemCount: widget.controller.toDoItemList.length,
                      itemBuilder: (context, index) {
                        final item = widget.controller.toDoItemList[index];
                        return ToDoItemListTile(
                          item: item,
                          onRemoveItem: () =>
                              widget.controller.onRemoveItem(item),
                          onChangeItem: () =>
                              widget.controller.onCompleteItem(item),
                        );
                      },
                    );
                  },
                )),
              ],
            );
          },
        ));
  }
}
