import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_html_v3/flutter_html.dart';
import 'package:html/dom.dart' as dom;

import '../common/constant.dart';
import '../common/customControl.dart';

class Utils{

  ///'#FFC700' 형식의 String을  0xFFffffff형식의 int로 변환하여 반환
  Color hexToColor(String? hexString){

    //null일 경우 회색을 반환
    if(hexString == null){
      return defaultButtonColor;
    }

    //'#' 제거 후 16진수로 변환(0x00@@@@@@)
    int hexValue = int.parse(hexString.substring(1), radix: 16);
    //(0xFF@@@@@@)
    return Color(hexValue).withAlpha(0xFF);
  }


  double pxToDouble(String? str){

    if(str == null){
      return 0.0;
    }

    String formatedStr = str.substring(0, str.length - 2);
    return double.parse(formatedStr);
  }


  Widget getWidgetFromDocument(dom.Document document){

    return Html.fromDom(
      document: document,
      customRenders: customRenderMap,
      tagsList: Html.tags..addAll(customTagList),
    );

  }


  Widget? getWidgetFromElement(dom.Element? element){

    if(element?.children.isEmpty ?? true){
      return null;
    }

    return Html.fromElement(
      documentElement: element,
      customRenders: customRenderMap,
      tagsList: Html.tags..addAll(customTagList),
    );
  }
}