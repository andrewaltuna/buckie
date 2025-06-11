import 'package:flutter/material.dart';

class AppImages {
  const AppImages._();

  static Image _image(String path) => Image.asset(path);

  static Image get logo => _image('assets/img/logo.png');
}

extension ImageExtension on Image {
  Image copyWith({
    double? width,
    double? height,
    Color? color,
    BoxFit? fit,
  }) {
    return Image(
      image: image,
      width: width,
      height: height,
      color: color,
      fit: fit,
    );
  }
}
