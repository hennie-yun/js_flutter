import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_v3/flutter_html.dart';
import 'package:flutter_js/javascript_runtime.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;

import 'package:csslib/visitor.dart' as css_visitor;
import '../common/customControl.dart';
import '../common/jsCommon.dart';

abstract class BasePage<T> extends StatelessWidget {
  ///페이지 이름을 식별하기 위한 값
  late final String _tag;

  ///위젯으로 변환된 html
  late Widget html;

  ///js 런타임 객체
  late JavascriptRuntime flutterJs;

  ///html을 String으로 변환한 값
  String htmlString = '';

  BasePage(
      {super.key,
        required String tag,
        required String htmlString,
        required JavascriptRuntime jsRuntime}) {
    this._tag = tag;
    this.htmlString = htmlString;
    this.flutterJs = jsRuntime;
    //전역변수에 런타임 객체 저장
    //페이지별 런타임 객체 관리를 위해 할당
    jsRuntimeList.add(this.flutterJs);
    _init();
  }

  get css_parser => null;

  /**
   * html String값을 html 위젯으로 변환하는 메서드
   */
  void _initHtml(htmlString) {
    dom.Document document = htmlparser.parse(htmlString);
    dom.Element? styleElement = document.querySelector('style');

    Map<String, Style> styles = {};

    if (styleElement != null) {
      var stylesheet = css_parser.parse(styleElement.innerHtml);
      stylesheet.topLevels.forEach((cssNode) {
        if (cssNode is css_visitor.RuleSet) {
          cssNode.selectorGroup?.selectors.forEach((selector) {
            String tagName = selector.simpleSelectorSequences.first.simpleSelector.toString();
            styles[tagName] = Style(); //
          });
        }
      });
      styles.forEach((key, value) {
        print('Tag: $key, Color: ${value.color}');
      });

    } else {
      print('스타일태그 없음');
    }


    this.html = Html.fromDom(
      document: document,
      customRenders: customRenderMap,
      tagsList: Html.tags..addAll(customTagList),
      // style: styles,
    );
  }


  void _init() {
    _initHtml(htmlString);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        onPopInvoked: (bool isBack) {
          //화면마다 JS런타임객체가 생성됨
          //화면이 닫힐 때 JS런타임 객체도 삭제되도록 함
          if (isBack) {jsRuntimeList.removeLast();}
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child : html,
          ),
        ));
  }
}
