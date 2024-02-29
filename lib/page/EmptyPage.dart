import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base/BasePage.dart';
import '../common/jsCommon.dart';

class EmptyPage extends BasePage{


  EmptyPage({super.key, required super.tag, required super.htmlString, required super.jsRuntime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
            children: [
              const WidgetSpan(child: Icon(Icons.sentiment_very_dissatisfied, size: 100, color: Colors.indigo,)),
              const TextSpan(text: "\n\n페이지를 찾을 수 없습니다\n\n", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              WidgetSpan(child: ElevatedButton(
                  onPressed: (){
                    jsRuntimeList.removeLast();
                    Get.back();
                  },
                  child: const Text("뒤로이동", style: TextStyle(fontSize: 22, color:Colors.indigo),),
              )),
            ]
        )),
      ),
    );
  }

}