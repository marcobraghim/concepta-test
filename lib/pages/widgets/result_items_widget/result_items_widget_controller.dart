import 'package:flutter/material.dart';

class ResultItemsWidgetController {
  final hoverIndex = ValueNotifier<int?>(null);

  setHoverIndex(int index) => hoverIndex.value = index;
}
