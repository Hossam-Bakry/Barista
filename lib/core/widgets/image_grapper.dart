import 'dart:io';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/widgets/pop_up_service.dart';
import '../Services/toast_service.dart';
import '../extensions/padding_ext.dart';
import 'border_rounded_button.dart';

void imageGrapper(
  BuildContext context, {
  void Function(XFile)? addToList,
}) {
  showDialog(
    // barrierDismissible: false,
    context: context,
    builder: (context) {
      var mediaQuery = MediaQuery.of(context);
      var theme = Theme.of(context);
      return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.all(16),
        content: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              alignment: Alignment.center,
              width: mediaQuery.size.width,
              height: mediaQuery.size.height * 0.335,
              padding: EdgeInsets.symmetric(
                vertical: mediaQuery.size.height * 0.034,
                horizontal: 2,
              ),
              decoration: BoxDecoration(
                color: Colors.white10,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                  )
                ],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Lottie.asset(
                    "assets/icons/search_image_icn.json",
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                    height: mediaQuery.size.height * 0.1,
                  ).setOnlyPadding(context, 0, 0.029, 0.0427, 0.0427),
                  SizedBox(
                    height: mediaQuery.size.height * 0.08,
                    child: Text(
                      'Take photo from camera or download it from the photo gallery',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyText1!.copyWith(),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BorderRoundedButton(
                        width: mediaQuery.size.width * 0.4,
                        height: mediaQuery.size.height * 0.054,
                        color: theme.colorScheme.onSecondary,
                        fontSize: 14,
                        title: "Open Camera",
                        onPressed: () {
                          takeImageFromCamera(context, addToList);
                        },
                      ),
                      BorderRoundedButton(
                        width: mediaQuery.size.width * 0.4,
                        height: mediaQuery.size.height * 0.054,
                        color: theme.colorScheme.onSecondary,
                        fontSize: 14,
                        title: "Choose from gallary",
                        onPressed: () {
                          takeImageFromGallary(context, addToList);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

takeImageFromGallary(
  BuildContext context,
  void Function(XFile)? addToList,
) async {
  XFile? image;
  try {
    EasyLoading.show();
    final ImagePicker picker = ImagePicker();
    // Pick an image
    image = await picker
        .pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    )
        .onError((error, stackTrace) {
      debugPrint("error is :$error");
      return null;
    });
    Navigator.of(context).pop();
    if (image == null) {
      ToastService.showErrorToast("grapper.image_type_error".tr());
    } else if (image.path.endsWith('.png') ||
        image.path.endsWith('.jpg') ||
        image.path.endsWith('.jpeg') ||
        image.path.endsWith('.jfif') ||
        image.path.endsWith('.gif')) {
      // print("here");
      if (addToList != null) addToList(image);
    }
    EasyLoading.dismiss();
  } catch (e) {
    EasyLoading.dismiss();
    if (Platform.isIOS &&
        (await Permission.photos.isDenied ||
            await Permission.storage.isDenied)) {
      // ignore: use_build_context_synchronously
      popUpsMaker(
        context,
        solidButtonTitle: 'permissions.go_to_settings'.tr(),
        borderedButtonTitle: 'permissions.back'.tr(),
        solidButtonOnPressed: openAppSettings,
        borderedButtonOnPressed: Navigator.of(context).pop,
        imagePath: 'assets/images/confirm@3x.png',
        // ignore: use_build_context_synchronously
        content: Text(
          'permissions.desc_image'.tr(),
          // ignore: use_build_context_synchronously
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
          textAlign: TextAlign.center,
        ).setHorizontalAndVerticalPadding(context, 0.05, 0.01),
      );
    } else if (await Permission.photos.isDenied) {
      // ignore: use_build_context_synchronously
      popUpsMaker(
        context,
        solidButtonTitle: 'permissions.go_to_settings'.tr(),
        borderedButtonTitle: 'permissions.back'.tr(),
        solidButtonOnPressed: openAppSettings,
        borderedButtonOnPressed: Navigator.of(context).pop,
        imagePath: 'assets/images/confirm@3x.png',
        // ignore: use_build_context_synchronously
        content: Text(
          'permissions.desc_image'.tr(),
          // ignore: use_build_context_synchronously
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
          textAlign: TextAlign.center,
        ).setHorizontalAndVerticalPadding(context, 0.05, 0.01),
      );
    }
  }
}

takeImageFromCamera(
  BuildContext context,
  void Function(XFile)? addToList,
) async {
  try {
    EasyLoading.show();
    final ImagePicker picker = ImagePicker();
    // Capture a photo
    final XFile? photo = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 100,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (addToList != null && photo != null) addToList(photo);
    EasyLoading.dismiss();
  } catch (e) {
    EasyLoading.dismiss();
    if (await Permission.camera.isDenied) {
      // ignore: use_build_context_synchronously
      popUpsMaker(
        context,
        solidButtonTitle: 'permissions.go_to_settings'.tr(),
        borderedButtonTitle: 'permissions.back'.tr(),
        solidButtonOnPressed: openAppSettings,
        borderedButtonOnPressed: () => Navigator.of(context).pop(),
        imagePath: 'assets/images/confirm@3x.png',
        // ignore: use_build_context_synchronously
        content: Text(
          'permissions.desc_camera'.tr(),
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
          textAlign: TextAlign.center,
        ).setHorizontalAndVerticalPadding(context, 0.05, 0.02),
      );
    }
  }
}
