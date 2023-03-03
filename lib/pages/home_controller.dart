import 'package:concepta_test/enums/status_type_enum.dart';
import 'package:concepta_test/models/result_list_item_model.dart';
import 'package:concepta_test/utils/cancellable.dart';
import 'package:concepta_test/utils/list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:pub_api_client/pub_api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController {
  final mainBoxKeyValue = UniqueKey();
  final formFieldCtrl = TextEditingController();
  final formFieldFocus = FocusNode();

  final searchExpanded = ValueNotifier<bool>(false);
  final status = ValueNotifier<StatusTypeEnum>(StatusTypeEnum.idle);
  final resultItems = ListNotifier<ResultListItemModel>([]);

  final selectedItem = ValueNotifier<String?>(null);

  final pubClient = PubClient();
  final cancelable = Cancellable();

  final historyKey = 'history';
  late SharedPreferences prefs;

  /// Run by initState
  Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();

    // clear the list for test cases
    // await prefs.clear();

    formFieldFocus.addListener(onChangeFocus);
  }

  void setStatus(StatusTypeEnum val) => status.value = val;

  /// When user touch the search icon in the screen
  Future<void> expandSearch() async {
    await populateHistoryItems();

    if (!searchExpanded.value) {
      searchExpanded.value = true;

      /// Request focus to the TextFormField after the expand animation is done
      Future.delayed(const Duration(milliseconds: 300), () {
        formFieldFocus.requestFocus();
      });
    }
  }

  void collapseSearch() => searchExpanded.value = false;

  /// When the focus is no more in the search form field
  /// run the animation to return to the Icon state
  void onChangeFocus() {
    if (!formFieldFocus.hasFocus && formFieldCtrl.text.isEmpty) {
      collapseSearch();
    }
  }

  Future<void> search(String value) async {
    await cancelable.execute(() async {
      if (status.value.isEqual(StatusTypeEnum.loading)) return;
      if (value.length < 2) {
        await populateHistoryItems();
        return;
      }

      setStatus(StatusTypeEnum.loading);
      resultItems.clear();

      final result = await pubClient.search(value);

      for (var item in result.packages.take(5)) {
        resultItems.add(ResultListItemModel(isSelectable: true, value: item.package));
      }

      if (resultItems.value.isEmpty) {
        resultItems.add(ResultListItemModel(isSelectable: false, value: 'Not found'));
      }

      setStatus(StatusTypeEnum.idle);
    });
  }

  Future<void> selectItem(String value) async {
    await addHistoryItem(value);
    resultItems.clear();

    formFieldCtrl.text = '';
    selectedItem.value = value;
  }

  Future<void> clearSelectedItem() async {
    selectedItem.value = null;

    await populateHistoryItems();
  }

  Future<void> populateHistoryItems() async {
    resultItems.clear();

    // Start the list if doesn't exists
    if (!prefs.containsKey(historyKey)) await prefs.setStringList(historyKey, []);

    final items = prefs.getStringList(historyKey) ?? [];

    if (items.isNotEmpty) {
      resultItems.add(ResultListItemModel(isSelectable: false, value: 'Recent Searches'));
      for (var item in items) {
        resultItems.add(ResultListItemModel(isSelectable: true, value: item));
      }
    } else {
      resultItems.add(ResultListItemModel(isSelectable: false, value: 'No Recent Searches'));
    }
  }

  Future<void> addHistoryItem(String value) async {
    var items = prefs.getStringList(historyKey) ?? [];

    // Item is already on the list
    if (items.contains(value)) return;

    items.insert(0, value);
    if (items.length > 5) {
      items = items.getRange(0, 5).toList();
    }
    await prefs.setStringList(historyKey, items);
  }

  dispose() {
    formFieldFocus.removeListener(onChangeFocus);

    searchExpanded.dispose();
    status.dispose();
    resultItems.dispose();
    selectedItem.dispose();

    formFieldCtrl.dispose();
  }
}
