import '../base/BasePage.dart';


class TestPage4 extends BasePage<TestPage4> {
  TestPage4(
      {super.key,
      required super.tag,
      required super.htmlString,
      required super.jsRuntime}) {
    flutterJs.evaluate('''  
       var btn_1 = new Button();
       
        btn_1.OnClick=function(){
        menuManage.preHistory();
      };
       
    ''');
  }
}
