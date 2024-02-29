import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/jsCommon.dart';
import 'TestPage.dart';

class FirstPage extends StatelessWidget {


  Future<String> getHtmlString() async{

    String htmlPath = 'assets/document/test.html';
    String htmlString = await rootBundle.loadString(htmlPath);
    return htmlString;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 300),
          Center(
            child: ElevatedButton(
                onPressed: () async{

                  //html 문서를 String으로 저장
                  var htmlString = await getHtmlString();
                  //공통부분이 선언된 js런타임 객체 저장
                  var js = await initJS();
                  Get.to(() => TestPage(tag:"test", htmlString: htmlString,jsRuntime: js));
                },
                style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.all(30))),
                child: const Text("화면이동")
            ),
          ),

          const SizedBox(height: 100),

          ElevatedButton(
            onPressed: (){
              // Get.to(() => tPage1());
            },
            child: const Text("테스트를 해보자"))
        ],
      ),
    );
  }
}