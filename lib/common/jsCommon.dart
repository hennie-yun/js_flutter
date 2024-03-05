import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';
import 'package:flutter_multi_platform/common/pageMap.dart';
import 'package:get/get.dart';


//페이지별 런타임 객체를 관리하기 위한 변수
List<JavascriptRuntime> jsRuntimeList = [];

//필수 JS 클래스 정의 및 JS, Dart간 채널 등록
Future<JavascriptRuntime> initJS() async{

  var jsRuntime = getJavascriptRuntime();

  String jsPath = 'assets/common/common.js';
  String jsString = await rootBundle.loadString(jsPath);

  String jsControlPath = 'assets/common/control.js';
  String jsControlString = await rootBundle.loadString(jsControlPath);

  //공통 부분 초기화
  jsRuntime.evaluate(jsString);
  jsRuntime.evaluate(jsControlString);


  /////////채널 등록/////////
  //화면이동
  jsRuntime.onMessage("moveScreen", (args) async {

    print("move to ${args["screenId"]}");
    
    if(args["screenId"] != null){

      String htmlPath = 'assets/document/${args["screenId"]}.html';
      String htmlString = await rootBundle.loadString(htmlPath);
      print(args["objData"]);
      //공통부분이 선언된 js런타임 객체 저장
      var js = await initJS();
      var page = getPage({"screenId":args["screenId"],"htmlString": htmlString, "jsRuntime": js});
      //화면 이동
      Get.to(() => page);
    }
    else{
      print("moveScreen(flutter): 존재하지 않는 스크린ID입니다");
    }
  });


  //화면 뒤로가기
  jsRuntime.onMessage("preHistory", (args) async {
    Get.back();
  });

  return jsRuntime;
}