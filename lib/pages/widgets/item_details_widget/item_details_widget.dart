import 'package:concepta_test/app_config.dart';
import 'package:concepta_test/pages/widgets/item_details_widget/item_details_widget_controller.dart';
import 'package:concepta_test/pages/widgets/suitup_observer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemDetailsWidget extends StatefulWidget {
  final String name;
  final Function() onBack;

  const ItemDetailsWidget({
    super.key,
    required this.name,
    required this.onBack,
  });

  @override
  State<ItemDetailsWidget> createState() => _ItemDetailsWidgetState();
}

class _ItemDetailsWidgetState extends State<ItemDetailsWidget> {
  final controller = ItemDetailsWidgetController();

  @override
  void initState() {
    super.initState();

    controller.loadPackageInformation(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: widget.onBack,
            child: Container(
              height: 54,
              width: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(54),
                border: Border.all(
                  width: 2,
                  color: AppConfig.colorPrimary,
                ),
              ),
              child: Icon(
                Icons.arrow_back,
                color: AppConfig.colorPrimary,
              ),
            ),
          ),
          SuitupObserver(
            observable: controller.itemDetails,
            builder: (context) {
              if (controller.itemDetails.value == null) {
                return Center(child: CupertinoActivityIndicator(color: AppConfig.colorPrimary));
              }

              return Container(
                width: double.maxFinite,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: AppConfig.colorPrimary,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 2, color: AppConfig.colorPrimary)),
                      ),
                      padding: const EdgeInsets.fromLTRB(22, 13, 22, 9),
                      child: Text(widget.name, style: TextStyle(color: AppConfig.colorPrimary)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.itemDetails.value!.likes.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppConfig.colorPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Text(
                                'LIKES',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.itemDetails.value!.points.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppConfig.colorPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Text(
                                'PUB POINTS',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${controller.itemDetails.value!.popularity}%',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppConfig.colorPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Text(
                                'POPULARITY',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(width: 2, color: AppConfig.colorPrimary)),
                      ),
                      padding: const EdgeInsets.fromLTRB(22, 13, 22, 9),
                      child: Text(
                        controller.itemDetails.value!.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
