import 'package:flutter_multi_platform/base/BasePage.dart';


//test2.html을 출력하는 페이지
class TestPage2 extends BasePage<TestPage2>{

  TestPage2({super.key, required super.tag, required super.htmlString, required super.jsRuntime}){

    flutterJs.evaluate('''  
      //***자동으로 생성되어야 함***//
      var btn_1 = new Button();
      //**********************//
      
      btn_1.OnClick=function(){
        menuManage.preHistory();
      };
    ''');
  }
}