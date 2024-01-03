import 'dart:ui';

import 'package:barista/core/config/app_icons.dart';
import 'package:barista/featuers/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  late HomeProvider provider;

  @override
  void initState() {
    provider = Provider.of<HomeProvider>(context, listen: false);
    Future.wait([
      provider.getAllRecipes(),
    ]).then((value) {
      Future.delayed(
        const Duration(seconds: 2),
        () => provider.changeLoadingStatus(false),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/home_bakground.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () {},
          backgroundColor: theme.primaryColor,
          child: Icon(
            Icons.add,
            color: theme.colorScheme.onSecondary,
            size: 40,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        extendBody: true,
        body: provider.widgetList[provider.currentIndex],
        bottomNavigationBar: Consumer<HomeProvider>(
          builder: (context, vm, child) => ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: BottomAppBar(
                height: 70,
                elevation: 0,
                shape: const CircularNotchedRectangle(),
                notchMargin: 8.0,
                color: Colors.black45,
                padding: const EdgeInsets.only(top: 5, left: 0.0, right: 0.0),
                child: BottomNavigationBar(
                  currentIndex: vm.currentIndex,
                  onTap: (index) {
                    vm.changeIndex(index);
                    setState(() {});
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: vm.currentIndex == 0
                          ? SvgPicture.asset(AppIcons.selectedPrepareIcon)
                          : SvgPicture.asset(AppIcons.unSelectedPrepareIcon),
                      label: "Prepare",
                    ),
                    // BottomNavigationBarItem(
                    //   icon: SvgPicture.asset(AppIcons.coffeeIcon),
                    //   label: "Coffee",
                    // ),
                    // BottomNavigationBarItem(
                    //   icon: SvgPicture.asset(AppIcons.cartIcon),
                    //   label: "Cart",
                    // ),
                    BottomNavigationBarItem(
                      icon: vm.currentIndex == 1
                          ? SvgPicture.asset(AppIcons.selectedUserIcon)
                          : SvgPicture.asset(AppIcons.unSelectedUserIcon),
                      label: "Profile",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
