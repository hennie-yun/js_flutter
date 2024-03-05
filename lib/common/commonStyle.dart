import 'package:flutter/material.dart';

/// sytle 요소의 text-align value 반환
TextAlign textAlign(String style) {
  var textAlign;
  var styleList = style.split(';');
  for (var stl in styleList) {
    var keyValue = stl.split(':');
    var key = keyValue[0].trim();
    if (key == 'text-align') {
      textAlign = keyValue[1].trim();
    }
  }

  TextAlign align = TextAlign.center; // 기본설정

  for (var temp in TextAlign.values) {
    if (textAlign == temp.toString().split('.').last) {
      align = temp;
      return align;
    }
  }
  return align;
}

BoxConstraints boxConstraints(String style) {
  double? maxHeight;
  double? minHeight;
  double? maxWidth;
  double? minWidth;

  var styleList = style.split(';');
  for (var stl in styleList) {
    var keyValue = stl.split(':');
    var key = keyValue[0].trim();

    if (key == 'max-height') {
      maxHeight =
          double.parse(keyValue[1].replaceAll(RegExp(r'[^0-9]'), '').trim());
    } else if (key == 'min-height') {
      minHeight =
          double.parse(keyValue[1].replaceAll(RegExp(r'[^0-9]'), '').trim());
    } else if (key == 'max-width') {
      maxWidth =
          double.parse(keyValue[1].replaceAll(RegExp(r'[^0-9]'), '').trim());
    } else if (key == 'min-width') {
      minWidth =
          double.parse(keyValue[1].replaceAll(RegExp(r'[^0-9]'), '').trim());
    }

  }




  return BoxConstraints(
      maxHeight: maxHeight ?? double.infinity,
      minHeight: minHeight ?? 0.0,
      maxWidth: maxWidth ?? double.infinity,
      minWidth: minWidth ?? 0.0);
}

