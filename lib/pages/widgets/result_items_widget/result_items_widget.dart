import 'package:concepta_test/app_config.dart';
import 'package:concepta_test/models/result_list_item_model.dart';
import 'package:concepta_test/pages/widgets/result_items_widget/result_items_widget_controller.dart';
import 'package:concepta_test/pages/widgets/suitup_observer_widget.dart';
import 'package:flutter/material.dart';

class ResultListItemsWidget extends StatefulWidget {
  final List<ResultListItemModel> items;
  final bool isRecentSearches;
  final Function(String value) onSelect;

  const ResultListItemsWidget({
    super.key,
    required this.items,
    required this.isRecentSearches,
    required this.onSelect,
  });

  @override
  State<ResultListItemsWidget> createState() => _ResultListItemsWidgetState();
}

class _ResultListItemsWidgetState extends State<ResultListItemsWidget> {
  final controller = ResultItemsWidgetController();

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox();

    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1, color: AppConfig.colorPrimary),
      ),
      margin: const EdgeInsets.only(top: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(widget.items.length, (index) {
          return SuitupObserver(
            observable: controller.hoverIndex,
            builder: (context) {
              final item = widget.items[index];
              final isFirst = index == 0;
              final isLast = index == widget.items.length - 1;

              return ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: isFirst ? const Radius.circular(15) : Radius.zero,
                  topRight: isFirst ? const Radius.circular(15) : Radius.zero,
                  bottomLeft: isLast ? const Radius.circular(15) : Radius.zero,
                  bottomRight: isLast ? const Radius.circular(15) : Radius.zero,
                ),
                child: InkWell(
                  onHover: (value) => controller.setHoverIndex(index),
                  onTap: () => item.isSelectable ? widget.onSelect(item.value) : null,
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 34),
                    decoration: BoxDecoration(
                      color: controller.hoverIndex.value == index ? AppConfig.colorPrimary : Colors.transparent,
                      border: isLast ? null : Border(bottom: BorderSide(width: 1, color: AppConfig.colorPrimary)),
                    ),
                    child: Text(
                      item.value,
                      style: TextStyle(
                        color: controller.hoverIndex.value == index ? AppConfig.colorContrast : AppConfig.colorPrimary,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
