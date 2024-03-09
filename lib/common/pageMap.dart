
import '../base/BasePage.dart';
import '../page/EmptyPage.dart';
import '../page/TestPage.dart';
import '../page/TestPage2.dart';
import '../page/TestPage3.dart';
import '../page/TestPage4.dart';
import '../page/TestPage5.dart';

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

    case "cssTest":
      return TestPage4(tag: screenId, htmlString: htmlString, jsRuntime: jsRuntime);

    case "svg_content":
      return TestPage5(tag: screenId, htmlString: htmlString, jsRuntime: jsRuntime);

    case "iframe":
      return TestPage5(tag: screenId, htmlString: htmlString, jsRuntime: jsRuntime);

    default:
      return EmptyPage(tag: screenId, htmlString: htmlString, jsRuntime: jsRuntime);
  }
}