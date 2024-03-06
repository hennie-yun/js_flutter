import '../base/BasePage.dart';

// control2.hmtl을 출력하는 페이지
class TestPage3 extends BasePage<TestPage3>{

  TestPage3({super.key, required super.tag, required super.htmlString, required super.jsRuntime}){

    //test페이지의 js를 읽는 것으로 가정
    flutterJs.evaluate('''   
 
    //***자동으로 생성되어야 함***//
    var btn_1 = new Button();
    var btn_2 = new Button();
    //**********************//
    
    
    ''');
  }
}