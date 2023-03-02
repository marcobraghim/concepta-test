import 'package:concepta_test/enums/status_type_enum.dart';
import 'package:flutter/material.dart';

class ItemDetailsWidgetController {
  final status = ValueNotifier<StatusTypeEnum>(StatusTypeEnum.idle);

  void setStatus(StatusTypeEnum val) => status.value = val;
}
