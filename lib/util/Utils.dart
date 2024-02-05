
import 'dart:ui';

class Utils{

  /// '#FFC700' 형식의 String을  0xFFffffff형식의 int로 변환하여 반환
  Color hexToColor(String hexString){

    //# 제거 후 16진수로 변환
    int hexValue = int.parse(hexString.substring(1), radix: 16);
    print(hexValue);
    print(hexValue);
    return Color(hexValue );
  }


  double pxToDouble(String str){

    String formatedStr = str.substring(0, str.length - 2);
    return double.parse(formatedStr);
  }


}