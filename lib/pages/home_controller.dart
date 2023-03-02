import 'package:concepta_test/enums/status_type_enum.dart';
import 'package:concepta_test/models/result_list_item_model.dart';
import 'package:concepta_test/utils/cancellable.dart';
import 'package:concepta_test/utils/list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:pub_api_client/pub_api_client.dart';

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

  void setStatus(StatusTypeEnum val) => status.value = val;

  /// When user touch the search icon in the screen
  void expandSearch() {
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
      if (value.length < 2) return resultItems.clear();

      setStatus(StatusTypeEnum.loading);

      resultItems.clear();

      final result = await pubClient.search(value);

      for (var item in result.packages.take(5)) {
        resultItems.add(ResultListItemModel(
          isSelectable: true,
          value: item.package,
        ));
      }

      if (resultItems.value.isEmpty) {
        resultItems.add(ResultListItemModel(
          isSelectable: false,
          value: 'Not found',
        ));
      }

      setStatus(StatusTypeEnum.idle);
    });
  }

  void selectItem(String value) {
    formFieldCtrl.text = value;
    resultItems.clear();

    selectedItem.value = value;
    formFieldCtrl.text = '';
  }

  void clearSelectedItem() {
    selectedItem.value = null;
  }
}
