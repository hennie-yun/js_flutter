import '../base/BasePage.dart';

// test.hmtl을 출력하는 페이지
class TestPage extends BasePage<TestPage> {
  TestPage(
      {super.key,
      required super.tag,
      required super.htmlString,
      required super.jsRuntime}) {
    //test페이지의 js를 읽는 것으로 가정
    flutterJs.evaluate('''   
 
    //***자동으로 생성되어야 함***//
    var btn_1 = new Button();
    var btn_2 = new Button();
    var btn_3 = new Button();
    var btn_4 = new Button();
    //**********************//
    
    btn_1.OnClick=function(){
        menuManage.moveScreen("test2", {"arg1":"1"});
    };
    
    btn_2.OnClick=function(){
        menuManage.moveScreen("test3", {"arg1":"1"});
    };
    
    btn_3.OnClick=function(){
        menuManage.moveScreen("control2", {"arg1":"1"});
    };

    btn_4.OnClick=function(){
        menuManage.moveScreen("cssTest", {"arg1":"1"});
    };
    ''');
  }
}
