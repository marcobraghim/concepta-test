import 'package:concepta_test/app_config.dart';
import 'package:concepta_test/enums/status_type_enum.dart';
import 'package:concepta_test/pages/home_controller.dart';
import 'package:concepta_test/pages/widgets/result_items_widget/result_items_widget.dart';
import 'package:concepta_test/pages/widgets/suitup_observer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// In this particular case, I won't use any DI
  /// because there's only one page in the project
  final controller = HomeController();

  @override
  void initState() {
    super.initState();

    controller.formFieldFocus.addListener(controller.onChangeFocus);
  }

  @override
  void dispose() {
    super.dispose();

    controller.formFieldFocus.removeListener(controller.onChangeFocus);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: double.maxFinite,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppConfig.horizontalPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 150),
                SuitupObserver(
                  observables: [controller.searchExpanded, controller.status],
                  builder: (context) {
                    final expandedWidth = MediaQuery.of(context).size.width - (AppConfig.horizontalPadding * 2);

                    return GestureDetector(
                      onTap: controller.expandSearch,
                      child: AnimatedContainer(
                        key: controller.mainBoxKeyValue,
                        duration: const Duration(milliseconds: 200),
                        width: controller.searchExpanded.value ? expandedWidth : 54,
                        height: 54,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(54),
                          border: Border.all(
                            width: 2,
                            color: AppConfig.colorPrimary,
                          ),
                        ),
                        child: SizedBox(
                          child: !controller.searchExpanded.value
                              ? Icon(
                                  Icons.search,
                                  color: AppConfig.colorPrimary,
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        focusNode: controller.formFieldFocus,
                                        controller: controller.formFieldCtrl,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(horizontal: 25),
                                        ),
                                        cursorColor: AppConfig.colorPrimary,
                                        style: TextStyle(color: AppConfig.colorPrimary),
                                        onChanged: controller.search,
                                      ),
                                    ),
                                    if (controller.status.value.isEqual(StatusTypeEnum.loading))
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 25),
                                        child: CupertinoActivityIndicator(color: AppConfig.colorPrimary),
                                      ),
                                  ],
                                ),
                        ),
                      ),
                    );
                  },
                ),
                SuitupObserver(
                  observables: [
                    controller.searchExpanded,
                    controller.resultItems,
                  ],
                  builder: (context) {
                    if (controller.searchExpanded.value == false) {
                      return const SizedBox();
                    }

                    return ResultListItemsWidget(
                      items: controller.resultItems.value,
                      isRecentSearches: true,
                      onSelect: controller.selectItem,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
