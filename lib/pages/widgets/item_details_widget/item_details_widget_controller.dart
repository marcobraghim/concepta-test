import 'package:concepta_test/enums/status_type_enum.dart';
import 'package:concepta_test/models/item_details_model.dart';
import 'package:flutter/material.dart';
import 'package:pub_api_client/pub_api_client.dart';

class ItemDetailsWidgetController {
  final status = ValueNotifier<StatusTypeEnum>(StatusTypeEnum.loading);
  final itemDetails = ValueNotifier<ItemDetailsModel?>(null);

  void setStatus(StatusTypeEnum val) => status.value = val;

  Future<void> loadPackageInformation(String packagename) async {
    final client = PubClient();

    final info = await client.packageInfo(packagename);
    final score = await client.packageScore(packagename);

    itemDetails.value = ItemDetailsModel(
      likes: score.likeCount,
      points: score.grantedPoints ?? 0,
      popularity: ((score.popularityScore ?? 0.0) * 100).toInt(),
      description: info.description,
    );

    setStatus(StatusTypeEnum.finished);
  }
}
