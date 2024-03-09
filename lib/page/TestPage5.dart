import '../base/BasePage.dart';


class TestPage5 extends BasePage<TestPage5> {
  TestPage5(
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
