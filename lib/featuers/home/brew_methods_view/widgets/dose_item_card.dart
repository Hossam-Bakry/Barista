import 'package:barista/featuers/home/provider/home_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/widgets/cupertino_dropdown.dart';
import 'edit_coffee_dose_widget.dart';

class DoseItemCard extends StatelessWidget {
  final String title;
  final String value;
  final void Function()? onTap;
  Map<Person?, String>? pickList;
  bool isDropDown;
  bool isDropDownEnabled;
  TextEditingController? controller;

  DoseItemCard({
    super.key,
    required this.title,
    required this.value,
    this.controller,
    this.pickList,
    this.onTap,
    this.isDropDown = false,
    this.isDropDownEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    print("$value----------------value");

    return Consumer<HomeProvider>(
      builder: (context, vm, child) => Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  title,
                  style: theme.textTheme.bodyMedium!
                      .copyWith(color: theme.primaryColor),
                ),
              ),
              if (isDropDown == false)
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    onTap: onTap,
                    controller: controller,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge,
                    onChanged: (value) {},
                    // initialValue: value,
                    decoration: InputDecoration(
                      hintText: "Enter value",
                      contentPadding:
                          const EdgeInsets.only(left: 10, right: 10, top: 15),
                      hintStyle: theme.textTheme.bodyMedium,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              if (isDropDown == true)
                SizedBox(
                  width: 60,
                  child: DropDownCupertino<Person>(
                    enabled: isDropDownEnabled,
                    style: TextStyle(color: theme.primaryColor),
                    buttonStyle: TextButton.styleFrom(
                      textStyle: theme.textTheme.bodyLarge!.copyWith(
                        fontSize: 17, color: theme.primaryColor),
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: BorderSide.none,
                      ),
                    ),
                    initialText: value,
                    pickList: pickList ?? {},
                    height: 240,
                    onSelectedItemChanged: (v) {
                      var ratio = v?.split(":").last;
                      vm.serRatio(double.parse(ratio!));
                      vm.calculateWater();
                      controller?.text = ratio;

                      if (kDebugMode) {
                        print(controller?.text);
                      }
                    },
                  ),
                ),
            ],
          ),
          // const Divider(
          //   color: Colors.white60,
          // ),
        ],
      ).setVerticalPadding(context, 0.0),
    );
  }
}
