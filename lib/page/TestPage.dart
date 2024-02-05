import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html_v3/flutter_html.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;


import '../common/constants.dart';
import '../common/customControlByTag.dart';
import '../common/style.dart';


class TestPage extends StatelessWidget{

  Widget html2 = Container();
  String htmlString = '';



  TestPage({required String htmlString}){

    // var btn = querySelector("#btn_t");
    // var div1 = querySelector("#div_t");
    //
    // // a.text = "2";
    //
    // btn?.onClick.listen((event) {
    //   div1?.text = 'text change!';
    // });

    flutterJs.onMessage('someChannelName', (dynamic args) {
      print(args);
    });

    print("start");
    flutterJs.evaluate('''
      console.log(22);
      console.log(33);
      
      var x = 300;
      var y = 2764;
      
      console.log(x + y);
     
      // sendMessage('someChannelName', JSON.stringify([1,2,3]);
      console.log(44);
      
      
      var button = document.getElementById('btn_1');
        button.onclick = function() {
            window.location.href = 'www.naver.com';
      
   window.onload = function() {
        var button = document.getElementById('btn_1');
        button.onclick = function() {
            window.location.href = 'www.naver.com';
        };
    };

    ''');

    this.htmlString = htmlString;
    init();
  }

  void init(){

    //태그를 정의할 변수 선언
    // CustomRenderMatcher inputMatcher() => (context) => context.tree.element?.localName == 'input';

    dom.Document document = htmlparser.parse(htmlString);
    html2 = Html.fromDom(
      document: document,
      style: styleVal,
      customRenders: {
        btnMatcher(): btnMatcherWidget,
        backgroundImgMatcher(): backgroundImgMatcherWidget
        // inputMatcher(): CustomRender.widget(widget: (context, buildChildren) => SizedBox(width: context.tree.style.width?.value, height: context.tree.style.height?.value, child: TextField())),
      },
      tagsList: Html.tags..addAll(customTagList), //"input"
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: ListView (
              children:[
                html2
              ]
          )
      )
    );
  }

}