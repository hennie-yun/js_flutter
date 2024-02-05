import 'package:flutter/material.dart';
import 'package:flutter_html_v3/custom_render.dart';

import '../util/Utils.dart';
import 'constants.dart';

//정의할 태그//
var customTagList = ["button"];

//선언//
CustomRenderMatcher btnMatcher() =>
    (context) => (context.tree.element?.localName == 'button');

CustomRenderMatcher backgroundImgMatcher() =>
        (context) => (context.tree.element?.localName == 'div' && context.tree.element?.attributes["background-image"] != null);

// background-image


//정의//

//버튼태그 -> 버튼
var btnMatcherWidget = CustomRender.widget(
    widget: (context, buildChildren){

      var style = context.tree.style;
      var element = context.tree.element;

      var backgroundColor = Utils().hexToColor(element?.attributes["background-color"] ?? "0");
      print(backgroundColor);

      var borderRadius = element?.attributes["border-radius"] ?? "0";
      return ElevatedButton(
              onPressed: () {
                print("pressed!");

                flutterJs.evaluate('''
                  try{
                  
                  sendMessage('someChannelName', JSON.stringify([1,2,3]);
                  var a = '<html><div id='12'></div> </html>
                  var b = a.getElementById('12');
                  
                  
                  
                  }
                  catch(error){
                    console.log("error!");
                    console.error(error);
                    console.log(error);
                  }
                  
                ''');


              },
              style: ButtonStyle(
                  textStyle: MaterialStatePropertyAll(TextStyle(
                      fontWeight: style.fontWeight,
                      fontSize: style.fontSize?.value,
                      // color: style.color
                  )),
                  // backgroundColor: MaterialStatePropertyAll(Color()),
                  foregroundColor:MaterialStatePropertyAll(style.color),
                  backgroundColor: MaterialStatePropertyAll(Color(0xffffc700)),
                  overlayColor:MaterialStatePropertyAll(style.backgroundColor ?? Colors.transparent),
                  elevation:MaterialStatePropertyAll(0),
                  shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Utils().pxToDouble(borderRadius))
                      )
                  )
              ),
              child: Text(element?.innerHtml.trim() ?? ""));
    });

var backgroundImgMatcherWidget = CustomRender.widget(
      widget: (context, buildChildren){

        var imgSrc = context.tree.element?.attributes["background-image"]!;
        var style = context.tree.style;
        var element = context.tree.element;

        if(imgSrc == null){
          return Container(
            width: style?.width?.value,
            height:style?.height?.value,
            child: Text("이미지가 존재하지 않습니다")
          );
        }
        //네트워크 이미지
        else if(imgSrc.contains("http")){
          return Image.network(
            imgSrc,
            width: 300, // 이미지의 너비
            height: 200, // 이미지의 높이
            fit: BoxFit.cover, // 이미지의 화면에 맞게 조절
          );
        }
        //로컬 이미지
        else{
          return Image(
            image:AssetImage(imgSrc ?? ""),
            width:400,
            height:400
          );
        }
      }
);
