import 'package:barista/featuers/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';

import '../../../core/extensions/extensions.dart';
import '../../../core/widgets/border_rounded_button.dart';
import '../../../domain/entities/home/recipe_info_entity.dart';
import '../../../main.dart';
import 'dose_item_card.dart';

enum Person {
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
}

class EditCoffeeDoseWidget extends StatelessWidget {
  final RecipeInfoEntity doseData;
  bool isLocked = true;

  EditCoffeeDoseWidget({
    super.key,
    required this.doseData,
  });

  final Map<Person, String> pickList = {
    Person.one: "1: 1",
    Person.two: "1: 2",
    Person.three: "1: 3",
    Person.four: "1: 4",
    Person.five: "1: 5",
    Person.six: "1: 6",
    Person.seven: "1: 7",
    Person.eight: "1: 8",
    Person.nine: "1: 9",
  };

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);

    return Consumer<HomeProvider>(
      builder: (context, vm, child) => Container(
        height: mediaQuery.size.height * 0.65,
        width: mediaQuery.size.width,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: const BoxDecoration(
          // color: Colors.white,
          image: DecorationImage(
            image: AssetImage("assets/images/bottom_sheet_background.png"),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          // alignment: Alignment.topRight,
          children: [
            Positioned(
              top: -34,
              right: 22,
              child: GestureDetector(
                onTap: () {
                  navigatorKey.currentState!.pop();
                },
                child: const CircleAvatar(
                  backgroundColor: Color(0xFF922E25),
                  child: Icon(Icons.close),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cup Number",
                  style: theme.textTheme.bodyLarge,
                ),
                Text(
                  "Choose Number",
                  style: theme.textTheme.bodySmall,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 100,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              vm.decreaseCounter();
                              vm.calculateCoffee();
                              vm.calculateWater();
                            },
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor: theme.colorScheme.onSecondary,
                              child: Icon(
                                Icons.remove,
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            vm.counter.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              vm.increaseCounter();
                              vm.calculateCoffee();
                              vm.calculateWater();
                            },
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor: theme.colorScheme.onSecondary,
                              child: Icon(
                                Icons.add,
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // const SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              "Coffee (g)",
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(color: theme.primaryColor),
                            ),
                          ),
                          // if (isDropDown == false)
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: vm.coffeeController,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                                signed: true,
                              ),
                              textInputAction: TextInputAction.done,
                              onChanged: (value) {
                                if (vm.isLocked == true) {
                                  vm.changeCoffeeDose(
                                      double.tryParse(value) ?? 0);
                                  vm.calculateWater();
                                } else {
                                  vm.changeCoffeeWithUnLocked(
                                      double.tryParse(value) ?? 0);
                                }

                                // if (vm.isLocked == false) {
                                //   vm.changeCoffeeWithUnLocked(
                                //       double.tryParse(value) ?? 0);
                                // }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter value",
                                contentPadding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 15),
                                hintStyle: theme.textTheme.bodyMedium,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white60,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              "water (g)",
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(color: theme.primaryColor),
                            ),
                          ),
                          // if (isDropDown == false)
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: vm.waterController,
                              textAlign: TextAlign.center,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                                signed: true,
                              ),
                              textInputAction: TextInputAction.done,
                              style: theme.textTheme.bodyLarge,
                              onChanged: (value) {
                                if (vm.isLocked == true) {
                                  vm.changeWaterDose(
                                      double.tryParse(value) ?? 0);
                                  vm.calculateCoffee();
                                }

                                if (vm.isLocked == false) {
                                  vm.changeWaterDose(
                                      double.tryParse(value) ?? 0);
                                }
                              },
                              // initialValue: vm.water.toString(),
                              decoration: InputDecoration(
                                hintText: "Enter value",
                                contentPadding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 15),
                                hintStyle: theme.textTheme.bodyMedium,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white60,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DoseItemCard(
                              title: "Ratio",
                              isDropDown: true,
                              pickList: pickList,
                              value: doseData.ratio.toString(),
                            ),
                          ),
                          const SizedBox(width: 15.0),
                          SizedBox(
                            height: 30,
                            child: LiteRollingSwitch(
                              width: 100,
                              //initial value
                              onDoubleTap: () {},
                              value: true,
                              textOn: 'Lock',
                              textOff: ' UnLock',
                              colorOff: theme.primaryColor,
                              colorOn: Colors.grey.shade400,
                              iconOff: Icons.lock_open_outlined,
                              iconOn: Icons.lock_outline,
                              textSize: 12.0,
                              onChanged: (bool state) {
                                //Use it to manage the different states
                                print(
                                    'Current State of SWITCH IS: ${vm.isLocked}');
                                // isLocked = state;
                                vm.setLockedStatus(state);
                              },
                              onTap: () {},
                              onSwipe: () {},
                            ),
                          ),

                          // ToggleSwitch(
                          //   minWidth: 45.0,
                          //   minHeight: 35.0,
                          //   cornerRadius: 8.0,
                          //   activeBgColors: [
                          //     [theme.primaryColor],
                          //     [theme.primaryColor],
                          //   ],
                          //   curve: Curves.easeInQuad,
                          //   animationDuration: 250,
                          //   animate: true,
                          //   activeFgColor: theme.colorScheme.onSecondary,
                          //   inactiveBgColor: Colors.grey,
                          //   inactiveFgColor: Colors.white,
                          //   initialLabelIndex: 0,
                          //   totalSwitches: 2,
                          //   icons: const [
                          //     Icons.lock,
                          //     Icons.lock_open_outlined,
                          //   ],
                          //   iconSize: 40,
                          //   onToggle: (index) {
                          //     lockIndex = index!;
                          //     // vm.setLockedIndex(index!);
                          //     // vm.changeLockStatus(index);
                          //     // if (index == 0) {
                          //     //   isLocked = true;
                          //     // }
                          //     // if (index == 1) {
                          //     //   isLocked = false;
                          //     // }
                          //
                          //     // print('switched to: ${vm.isLocked}');
                          //   },
                          // ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white60,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              "Grinder Setting",
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(color: theme.primaryColor),
                            ),
                          ),
                          // if (isDropDown == false)
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: vm.grinderController,
                              textAlign: TextAlign.center,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                                signed: true,
                              ),
                              textInputAction: TextInputAction.done,
                              style: theme.textTheme.bodyLarge,
                              onChanged: (value) {
                                if (vm.isLocked == true) {
                                  vm.changeWaterDose(
                                      double.tryParse(value) ?? 0);
                                  vm.calculateCoffee();
                                }

                                if (vm.isLocked == false) {
                                  vm.changeWaterDose(
                                      double.tryParse(value) ?? 0);
                                }
                              },
                              // initialValue: vm.water.toString(),
                              decoration: InputDecoration(
                                hintText: "Enter value",
                                contentPadding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 15),
                                hintStyle: theme.textTheme.bodyMedium,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white60,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              "Brew Time",
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(color: theme.primaryColor),
                            ),
                          ),
                          // if (isDropDown == false)
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: vm.brewsTimeController,
                              textAlign: TextAlign.center,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                                signed: true,
                              ),
                              textInputAction: TextInputAction.done,
                              style: theme.textTheme.bodyLarge,
                              onChanged: (value) {
                                if (vm.isLocked == true) {
                                  vm.changeWaterDose(
                                      double.tryParse(value) ?? 0);
                                  vm.calculateCoffee();
                                }

                                if (vm.isLocked == false) {
                                  vm.changeWaterDose(
                                      double.tryParse(value) ?? 0);
                                }
                              },
                              // initialValue: vm.water.toString(),
                              decoration: InputDecoration(
                                hintText: "Enter value",
                                contentPadding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 15),
                                hintStyle: theme.textTheme.bodyMedium,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white60,
                      ),
                    ],
                  ),
                ),

                BorderRoundedButton(
                  onPressed: () {
                    print(vm.coffeeController);
                    print(vm.waterController);
                    // vm.calculateDoseAmounts(doseData);
                    // print("1:".length);
                    // String s = "1: 13";
                    // String result = s.substring(s.indexOf(':'));
                    // print(s.split(":").last);
                    // print(result);
                  },
                  // onPressed: () {
                  //   showCupertinoModalPopup(
                  //     context: context,
                  //     builder: (context) => StatefulBuilder(
                  //       builder: (context, setState) => Container(
                  //         height: mediaQuery.size.height * 0.3,
                  //         padding: const EdgeInsets.only(top: 6.0),
                  //         // The Bottom margin is provided to align the popup above the system navigation bar.
                  //         margin: EdgeInsets.only(
                  //           bottom: MediaQuery.of(context).viewInsets.bottom,
                  //         ),
                  //         decoration: BoxDecoration(color: Colors.grey.shade300),
                  //         child: CupertinoPicker(
                  //           magnification: 1.22,
                  //           squeeze: 1.2,
                  //           useMagnifier: true,
                  //           itemExtent: _kItemExtent,
                  //           // This sets the initial item.
                  //           scrollController: FixedExtentScrollController(
                  //             initialItem: _selectedFruit,
                  //           ),
                  //           // This is called when selected item is changed.
                  //           onSelectedItemChanged: (int selectedItem) {
                  //             setState(() {
                  //               _selectedFruit = selectedItem;
                  //               navigatorKey.currentState!.pop();
                  //             });
                  //           },
                  //           children: List<Widget>.generate(_fruitNames.length,
                  //               (int index) {
                  //             return Center(child: Text(_fruitNames[index]));
                  //           }),
                  //         ),
                  //       ),
                  //     ),
                  //   );
                  // },
                  title: "Save Changes",
                  icon: Icons.arrow_forward,
                  color: theme.colorScheme.onSecondary,
                ),
              ],
            ).setVerticalPadding(context, 0.05),
          ],
        ),
      ),
    );
  }
//
// int _selectedFruit = 0;
// double _kItemExtent = 32.0;
// List<String> _fruitNames = <String>[
//   'Apple',
//   'Mango',
//   'Banana',
//   'Orange',
//   'Pineapple',
//   'Strawberry',
// ];
}
