import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FixedSizer extends Sizer {
  FixedSizer({required super.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizerUtil().setScreenSize2(constraints, orientation);
        return builder(context, orientation, SizerUtil.deviceType);
      });
    });
  }
}

extension FixedSizerUtil on SizerUtil {
    void setScreenSize2(
      BoxConstraints constraints, Orientation currentOrientation) {
    // Sets boxconstraints and orientation
    SizerUtil.boxConstraints = constraints;
    SizerUtil.orientation = currentOrientation;

    // Sets screen width and height
    // if (orientation == Orientation.portrait|| kIsWeb) {
    SizerUtil.width = SizerUtil.boxConstraints.maxWidth;
    SizerUtil.height = SizerUtil.boxConstraints.maxHeight;
    // } else {
    //   width = boxConstraints.maxHeight;
    //   height = boxConstraints.maxWidth;
    // }

    // Sets ScreenType
    if (kIsWeb) {
      SizerUtil.deviceType = DeviceType.web;
    } else if (Platform.isAndroid || Platform.isIOS) {
      if ((SizerUtil.orientation == Orientation.portrait && SizerUtil.width < 600) ||
          (SizerUtil.orientation == Orientation.landscape && SizerUtil.height < 600)) {
        SizerUtil.deviceType = DeviceType.mobile;
      } else {
        SizerUtil.deviceType = DeviceType.tablet;
      }
    } else if (Platform.isMacOS) {
      SizerUtil.deviceType = DeviceType.mac;
    } else if (Platform.isWindows) {
      SizerUtil.deviceType = DeviceType.windows;
    } else if (Platform.isLinux) {
      SizerUtil.deviceType = DeviceType.linux;
    } else {
      SizerUtil.deviceType = DeviceType.fuchsia;
    }
  }
}