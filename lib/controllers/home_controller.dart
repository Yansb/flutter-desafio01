import 'package:ignite_flutter_todo_list/shared/models/todo_item.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  ObservableList<ToDoItem> toDoItemList = ObservableList<ToDoItem>();

  @observable
  ObservableList<ToDoItem> doneItemList = ObservableList<ToDoItem>();

  @action
  void onAddItem(String itemTitle) {
    toDoItemList.add(ToDoItem(title: itemTitle));
  }

  @action
  void onRemoveItem(ToDoItem item) {
    toDoItemList.remove(item);
  }

  @action
  void onCompleteItem(ToDoItem item) {
    toDoItemList.remove(item);
    doneItemList.add(ToDoItem(title: item.title, isDone: true));
  }

  @action
  void onRemoveDoneItem(ToDoItem item) {
    doneItemList.remove(item);
  }

  @action
  void onResetItem(ToDoItem item) {
    doneItemList.remove(item);
    toDoItemList.add(ToDoItem(title: item.title, isDone: false));
  }
}
