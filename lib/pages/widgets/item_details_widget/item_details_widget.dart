import 'package:concepta_test/app_config.dart';
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
          Container(
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
                            '1423',
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
                            '130',
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
                            '99%',
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
                  child: const Text(
                    'A flutter implementation of React hooks. It adds a new kind of widget with enhanced code reuse.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
