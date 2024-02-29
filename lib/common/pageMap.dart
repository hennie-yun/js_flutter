
import '../base/BasePage.dart';
import '../page/EmptyPage.dart';
import '../page/TestPage.dart';
import '../page/TestPage2.dart';
import '../page/TestPage3.dart';

BasePage getPage(Map<String, dynamic> args) {

  var screenId = args["screenId"];
  var htmlString = args["htmlString"];
  var jsRuntime = args["jsRuntime"];

  switch(args["screenId"]){

    case "test":
      return TestPage(tag: screenId, htmlString: htmlString, jsRuntime: jsRuntime);

    case "test2":
      return TestPage2(tag: screenId, htmlString: htmlString, jsRuntime: jsRuntime);

    case "test3":
      return TestPage3(tag: screenId, htmlString: htmlString, jsRuntime: jsRuntime);

    case "control2":
      return TestPage3(tag: screenId, htmlString: htmlString, jsRuntime: jsRuntime);

    case "dummy":
      return TestPage3(tag: screenId, htmlString: htmlString, jsRuntime: jsRuntime);
      
    default:
      return EmptyPage(tag: screenId, htmlString: htmlString, jsRuntime: jsRuntime);
  }
}