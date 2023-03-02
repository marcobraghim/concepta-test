import 'package:concepta_test/app_config.dart';
import 'package:concepta_test/pages/home_controller.dart';
import 'package:concepta_test/pages/widgets/suitup_observer.dart';
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
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 150),
              SuitupObserver(
                observable: controller.searchExpanded,
                builder: (context) {
                  return GestureDetector(
                    onTap: controller.expandSearch,
                    child: AnimatedContainer(
                      key: controller.mainBoxKeyValue,
                      duration: const Duration(milliseconds: 200),
                      width: controller.searchExpanded.value ? 240 : 54,
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
                            : TextFormField(
                                focusNode: controller.formFieldFocus,
                                controller: controller.formFieldCtrl,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 25),
                                ),
                                cursorColor: AppConfig.colorPrimary,
                                style: TextStyle(color: AppConfig.colorPrimary),
                              ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
