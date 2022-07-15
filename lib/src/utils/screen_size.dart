import 'package:flutter/material.dart';


extension ScreenSize on num {
  static late MediaQueryData _mediaQueryData;
  static late double _pixelRatio,
      _screenWidth,
      _screenHeight,
      _widthInPx,
      _heightInPx;

  init(BuildContext context, {double? width, double? height}) {
    _mediaQueryData = MediaQuery.of(context);
    _pixelRatio = _mediaQueryData.devicePixelRatio;
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;
    _heightInPx = height ?? 1920;
    _widthInPx = width ?? 1080;
  }

  double h() => (this / _heightInPx) * _screenHeight;
  double w() => (this / _widthInPx) * _screenWidth;
  double defaultHeight() => _screenHeight * this;
  double defaultWeight() => _screenWidth * this;
}