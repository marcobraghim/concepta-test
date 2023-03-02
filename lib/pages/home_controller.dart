import 'package:flutter/material.dart';

class HomeController {
  final mainBoxKeyValue = UniqueKey();
  final formFieldCtrl = TextEditingController();
  final formFieldFocus = FocusNode();

  final searchExpanded = ValueNotifier<bool>(false);

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
}
