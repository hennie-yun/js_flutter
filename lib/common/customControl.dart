import 'package:flutter/material.dart';
import 'package:flutter_html_v3/custom_render.dart';
import 'package:flutter_html_v3/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;
import 'package:webviewx/webviewx.dart';

import '../util/Utils.dart';
import 'commonStyle.dart';
import 'constant.dart';
import 'jsCommon.dart';

// ****************** //
// **태그 커스텀 정의** //
// ***************** //

//**********정의할 태그**********
var customTagList = [
  "button",
  "select",
  "table",
  "input",
  "textarea",
  "iframe",
  "style"
];

//**********선언**********
//변경하고 싶은 태그의 조건 작성

//button
CustomRenderMatcher btnMatcher() =>
    (context) => (context.tree.element?.localName == 'button');

//div && background-image 속성이 존재하는 태그
CustomRenderMatcher backgroundImgMatcher() =>
    (context) => (context.tree.element?.localName == 'div' &&
        context.tree.element?.attributes["background-image"] != null);

//
CustomRenderMatcher div2Matcher() =>
    (context) => (context.tree.element?.localName == 'dfkeidk');

//tab 인지 확인해야댐
CustomRenderMatcher tabMatcher() =>
    (context) => (context.tree.element?.attributes['ctrltype'] == 'CT_TAB');

//table
CustomRenderMatcher tableMatcher() =>
    (context) => (context.tree.element?.attributes['ctrltype'] == 'CT_TABLE');

//grid (div 태그이면서 타입이 그리드인 태그)
CustomRenderMatcher gridMatcher() =>
    (context) => (context.tree.element?.localName == 'div' &&
        context.tree.element?.attributes['ctrltype'] == 'CT_GRID');

//grid checkbox
CustomRenderMatcher gridCheckBoxMatcher() => (context) =>
    (context.tree.element?.className.contains('CT_GRID_CHECK') ?? false);

//combobox
CustomRenderMatcher comboBoxMatcher() => (context) =>
    ((context.tree.element?.className.contains('CT_COMBO') ?? false) ||
        (context.tree.element?.className.contains('hi5_combo') ?? false));

//span tag
CustomRenderMatcher spanMatcher() =>
    (context) => (context.tree.element?.localName == 'span');

CustomRenderMatcher inputMatcher() =>
    (context) => (context.tree.element?.localName == 'input' ||
        context.tree.element?.localName == 'textarea');

CustomRenderMatcher iframeMatcher() =>
    (context) => (context.tree.element?.localName == 'iframe');

// CustomRenderMatcher formMatcher() =>
//     (context) => (context.tree.element?.id == 'form');

CustomRenderMatcher formMatcher() =>
        (context) => (context.tree.element?.attributes['ctrltype'] == 'CT_FORM');

//**********위젯정의**********

List<CustomRenderMatcher> styleMatchers = [
  (context) => (context.tree.element?.localName == 'style')
];

var formMatcherWidget = CustomRender.widget(widget: (context, buildChildren) {
  var divElement = context.tree.element;
  var heightValue;
  var widthValue;
  var style = divElement?.attributes['style'];

  if (style != null) {
    var styles = style.split(';');
    for (var item in styles) {
//높이 구하기
      if (item.trim().startsWith('height')) {
        heightValue =
            double.tryParse(item.split(':')[1].trim().replaceAll('px', ''));
        print(heightValue);
      }
      if (item.trim().startsWith('width')) {
        widthValue =
            double.tryParse(item.split(':')[1].trim().replaceAll('px', ''));
        print(widthValue);
      }
    }
  }
  dom.Document document = htmlparser.parse(context.tree.element?.innerHtml);

  return Container(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(0),
      height: heightValue,
      width: widthValue,
      decoration: BoxDecoration(
          border: Border.all()),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
          Utils().getWidgetFromDocument(document)
        ]),
      );
});

//tab태그
var tabMatcherWidget = CustomRender.widget(widget: (context, buildChildren) {
  var divElement = context.tree.element;

  //로딩 되자 마자 선택 되어있는 라벨 찾기
  var initialIndex = 0;
  var allTabs = divElement?.querySelectorAll('li.tabHeader');
  var selectedTab = divElement?.querySelector('li.tabHeader.selected');
  if (allTabs != null && selectedTab != null) {
    initialIndex = allTabs.indexOf(selectedTab);
  }

  //li의 개수로 탭의 개수를 설정
  var tabs = divElement?.querySelectorAll('li.tabHeader');
  var tabLength = tabs?.length ?? 1;

  //탭을 이루는 전체 높이 설정
  var heightValue;
  if (divElement?.attributes['ctrltype'] == 'CT_TAB') {
    var style = divElement?.attributes['style'];
    if (style != null) {
      var styles = style.split(';');
      for (var item in styles) {
        if (item.trim().startsWith('height')) {
          heightValue =
              double.tryParse(item.split(':')[1].trim().replaceAll('px', ''));
        }
      }
    }
  }

  List<Widget> tabWidgets = [];
  if (tabs != null) {
    tabWidgets = tabs.map((tab) {
      return Tab(
        text: tab.text,
        key: Key(tab.attributes['tabid']!),
      );
    }).toList();
  }

  List<Widget> tabViewWidget = [];

  var tabContents = divElement?.querySelectorAll('div.tab-content');

  //null 예외처리
  if (tabContents == null) {
    print("***(tabMatcherWidget) tab-content is null");
    return Container();
  }

  for (var tabContent in tabContents) {
    var content = tabContent.outerHtml;
    var widgets = <Widget>[];
    if (content != null) {
      var widget = Utils().getWidgetFromElement(tabContent);
      if (widget != null) {
        widgets.add(widget);
      } else {
        widgets.add(Html(data: content));
      }
    }
    tabViewWidget.addAll(widgets);
  }

  return Container(
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,

    height: heightValue,
    child: DefaultTabController(
        initialIndex: initialIndex,
        length: tabLength,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: defaultTabUnSelectedColor,
              child: TabBar(
                padding: EdgeInsets.zero,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: const BoxDecoration(color: defaultTabSelectedColor),
                labelColor: Colors.white,
                labelPadding: EdgeInsets.zero,
                unselectedLabelColor: Colors.black,
                tabs: tabWidgets,
              ),
            ),
            Expanded(
                child: Container(
                    color: defaultTabViewBackgroundColor,
                    child: TabBarView(children: tabViewWidget)))
          ],
        )),
  );
});

//button 태그
var btnMatcherWidget = CustomRender.widget(widget: (context, buildChildren) {
  var style = context.tree.style;
  var element = context.tree.element;

  var backgroundColor = style.backgroundColor == Color(0x00000000)
      ? defaultButtonColor
      : style.backgroundColor;

// Utils().hexToColor(element?.attributes["background-color"]);

  var borderRadius = element?.attributes["border-radius"];

  return Container(
      //사이즈가 지정되어있을 때 값이 할당됨
      //null일 경우 컨텐츠에 맞게 사이즈가 조절됨
      width: style.width?.value,
      height: style.height?.value,
      decoration: BoxDecoration(
          border: style.border ?? Border.all(color: defaultBorder1)),
      child: ElevatedButton(
          onPressed: () {
            jsRuntimeList.last.evaluate('${context.tree.elementId}.OnClick()');
          },
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 1.0), // 원하는 패딩 값 설정
              ),
              textStyle: MaterialStatePropertyAll(TextStyle(
                fontWeight: style.fontWeight,
                fontSize: style.fontSize?.value ?? 14,
              )),
              foregroundColor: MaterialStatePropertyAll(style.color),
              backgroundColor: MaterialStatePropertyAll(backgroundColor),
              overlayColor: MaterialStatePropertyAll(
                  style.backgroundColor?.withOpacity(0.1) ??
                      Colors.transparent),
              elevation: MaterialStatePropertyAll(0),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      Utils().pxToDouble(borderRadius))))),
          child: Text(element?.innerHtml.trim() ?? "", softWrap: false)));
});

// var backgroundImgMatcherWidget = CustomRender.widget(widget: (context, buildChildren) {
//   var imgSrc = context.tree.element?.attributes["background-image"]!;
//   var style = context.tree.style;
//   var element = context.tree.element;

//   if (imgSrc == null) {
//     return Container(
//         width: style.width?.value,
//         height: style.height?.value,
//         color: Colors.grey,
//         child: const Text("이미지가 존재하지 않습니다"));
//   }
// //네트워크 이미지인 경우
//   else if (imgSrc.contains("http")) {
//     return Image.network(
//       imgSrc,
//       width: style.width?.value, // 이미지의 너비
//       height: style.height?.value, // 이미지의 높이
//       fit: BoxFit.cover, // 이미지의 화면에 맞게 조절
//     );
//   }
// //로컬 이미지인 경우
//   else {
//     return Image(
//       image: AssetImage(imgSrc),
//       width: style.width?.value,
//       height: style.height?.value,
//       fit: BoxFit.cover, // 이미지의 화면에 맞게 조절
//     );
//   }
// });

//table 태그
var tableMatcherWidget = CustomRender.widget(widget: (context, buildChildren) {
  var element = context.tree.element;
  var tableStyle = context.tree.style;

//모든 row 요소 가져오기
  var rows = element?.querySelectorAll('tr');

  List<TableRow> tableRowWidgets = [];

// row 생성
  if (rows != null) {
    tableRowWidgets = rows.map((row) {
      //각 tr의 td요소 가져옴
      var tds = row.querySelectorAll('td');
      List<TableCell> tableCellWidgets = [];

      // 각 row의 td 생성
      tableCellWidgets = tds.map((td) {
        double? eachHeight;
        double? eachWidth;
        var tdStyle = td.attributes["style"] ?? "";

        //최소 높이 최대 높이 가져오기
        if (tdStyle != null) {
          var styles = tdStyle.split(';');
          for (var item in styles) {
            var trimmedItem = item.trim();
            if (trimmedItem.startsWith('min-width') ||
                trimmedItem.startsWith('min-height')) {
              var splitValue = trimmedItem.split(':');
              var property = splitValue[0].trim();
              var value =
                  double.tryParse(splitValue[1].trim().replaceAll('px', ""));

              if (property == 'min-width') {
                eachWidth = value;
              } else if (property == 'min-height') {
                eachHeight = value;
              }
            }
          }
        }

        return TableCell(
          child: Container(
              width: eachWidth,
              height: eachHeight,
              child: Text(td.text, textAlign: textAlign(tdStyle))),
        );
      }).toList();

      return TableRow(
        children: tableCellWidgets,
      );
    }).toList();
  }

  var tdCount = rows?.first.querySelectorAll('td')?.length;

  return Table(
    border: TableBorder.all(
      color: defaultBorder1,
    ),
    columnWidths: {
      for (int i = 0; i < tdCount!; i++) i: IntrinsicColumnWidth(),
    },
    children: tableRowWidgets,
  );
});

//첫번째 데이터(두번째행)의 style을 가져와 모든 셀에 동일한 크기를 적용함
var gridMatcherWidget = CustomRender.widget(widget: (context, buildChildren) {
//모든 행(row)의 style 사이즈 값(width height 등)을 저장하기 위한 변수
  List<String?> rowWidth,
      rowMinWidth,
      rowMaxWidth,
      rowHeight,
      rowMinHeight,
      rowMaxHeight;

  //첫번째 태그(타이틀)가 아닌 두번째 tr태그 속 셀들의 style 사이즈 값(width height 등) 저장하기 위한 변수
  List<String?> cellWidth,
      cellMinWidth,
      cellMaxWidth,
      cellHeight,
      cellMinHeight,
      cellMaxHeight;

//style값을 한번에 저장함
  [rowWidth, rowMinWidth, rowMaxWidth, rowHeight, rowMinHeight, rowMaxHeight] =
      _getRowSize(context);
  [
    cellWidth,
    cellMinWidth,
    cellMaxWidth,
    cellHeight,
    cellMinHeight,
    cellMaxHeight
  ] = _getCellSize(context);

//데이터가 있다고 가정함
  var gridData = ['0'];

  ///그리드의 width 총합을 저장
  var gridWidth = 0.0;
  for (String? num in cellWidth) {
    gridWidth += int.parse(num ?? "0.0");
  }

  //그리드의 모든 row를 가져옴
  var gridRows = context.tree.element?.querySelectorAll("tr");

  //데이터를 표시할 위젯 저장
  //첫번째 요소는 leftchild의 헤더이기 때문에 더미값을 할당
  List<Widget> titleWidget = [Container(child: Text(""))];
  List<Widget> bodyWidget = [];

  //타이틀 영역 위젯 생성
  titleWidget.addAll(List.generate(gridRows?[0].children.length ?? 0, (index) {
    return Container(
        decoration: BoxDecoration(
            //헤더 셀 테두리
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            //헤더 셀 배경색
            color: defaultGridHeaderCell),
        width: cellWidth[index] == null
            ? null
            : double.parse(cellWidth[index]!) *
                int.parse(
                    gridRows?[0].children[index].attributes["colspan"] ?? "1"),
        //높이는 행(row)의 높이를 따름
        height: rowHeight[0] == null
            ? null
            : double.parse(rowHeight[0] ?? "$gridHeight"),
        child: Text(
          gridRows?[0].children[index].innerHtml ?? "",
          textAlign: TextAlign.center,
        ));
  }));

  //데이터 영역 위젯 생성
  bodyWidget.addAll(
      List.generate(gridRows?.length == null ? 0 : gridRows!.length - 1, (i) {
    var index = i + 1;
    return Row(
      children: List.generate(gridRows?[index].children.length ?? 0, (j) {
        return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
              color: defaultBorder3,
            )),
            //사이즈가 지정되었을 때 사이즈 colspan 속성값만큼 곱한 값을 사용
            constraints: BoxConstraints(
                minWidth: cellMinWidth[j] == null
                    ? 0.0
                    : double.parse(cellMinWidth[j]!) *
                        int.parse(gridRows?[index].children[j].attributes["colspan"] ??
                            "1"),
                maxWidth: cellMaxWidth[j] == null
                    ? double.infinity
                    : double.parse(cellMaxWidth[j]!) *
                        int.parse(gridRows?[index].children[j].attributes["colspan"] ??
                            "1"),
                minHeight: cellMinHeight[j] == null
                    ? 0.0
                    : double.parse(cellMinHeight[j]!) *
                        int.parse(gridRows?[index].children[j].attributes["colspan"] ??
                            "1"),
                maxHeight: cellMaxHeight[j] == null
                    ? double.infinity
                    : double.parse(cellMaxHeight[j]!) *
                        int.parse(gridRows?[index].children[j].attributes["colspan"] ?? "1")),
            width: cellWidth[j] == null ? null : double.parse(cellWidth[j]!) * int.parse(gridRows?[index].attributes["colspan"] ?? "1"),
            height: cellHeight[j] == null ? gridHeight : double.parse(cellHeight[j]!),
            // * int.parse(gridRows?[index].attributes["colspan"] ?? "1"),
            // 태그가 있는 경우 태그 변환, 없는경우엔 Text를 출력
            child: Utils().getWidgetFromElement(gridRows?[index].children[j]) ?? Text(gridRows?[index].children[j].innerHtml ?? ""));
      }),
    );
  }));

  return SizedBox(
      width: gridWidth,
      //(행 높이 * 데이터 개수) + 타이틀 높이(지정값이 없으면 기본값을 할당)
      // todo. gridHeight자리는 css style값을 먼저 읽고 지정값이 없을 때 디폴트 행 높이를 가져오도록 수정해야 함
      height:
          (gridHeight * gridData.length) + double.parse(rowHeight[0] ?? "1"),
      child: HorizontalDataTable(
        //스크롤 끝에 도달했을 때 고무줄처럼 늘어나는 효과를 없앰
        scrollPhysics: const ClampingScrollPhysics(),
        horizontalScrollPhysics: const ClampingScrollPhysics(),
        //경계선 그림자 효과
        elevation: 0.0,
        //왼쪽 고정 행의 너비
        leftHandSideColumnWidth: 0,
        //데이터 행의 너비
        rightHandSideColumnWidth: gridWidth,
        //헤더 셀 고정 여부
        isFixedHeader: true,
        //헤더 셀에 들어갈 위젯
        headerWidgets: titleWidget,
        // isFixedFooter: true,
        // footerWidgets: [Text("footer1"),Text("footer2"),Text("footer3"), Text("footer4"), Text("footer5")],
        //고정된 왼쪽 열을 만드는 빌더
        leftSideItemBuilder: _generateFirstColumnRow,
        //행의 높이
        itemExtent: gridHeight,
        //데이터 셀에 들어갈 위젯
        rightSideChildren: bodyWidget,
        //데이터의 개수, ItemBuilder에 쓰임
        itemCount: gridData.length,
        //셀의 배경 색
        leftHandSideColBackgroundColor: const Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: const Color(0xFFFFFFFF),
      ));
});

Widget _generateFirstColumnRow(BuildContext context, int index) {
  return Container(
    height: gridHeight,
    decoration: BoxDecoration(border: Border.all(color: defaultBorder3)),
    // padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
    alignment: Alignment.centerLeft,
    child: Text("data_${index}"),
  );
}

//row 사이즈를 반환하는 함수
List<List<String?>> _getRowSize(context) {
  //각 행의 요소를 가져옴
  var rows = context.tree.element?.querySelectorAll("tr");
  List<String?> widthList = [];
  List<String?> minWidthList = [];
  List<String?> maxWidthList = [];

  List<String?> heightList = [];
  List<String?> minHeightList = [];
  List<String?> maxHeightList = [];

  RegExp regex = RegExp(
      r'(width|min-width|max-width|height|min-height|max-height):\s*(\d+)');

  rows.forEach((element) {
    var style = element.attributes['style'];
    var styleMap = {};

    for (RegExpMatch match in regex.allMatches(style)) {
      styleMap[match.group(1)!] = match.group(2);
    }

    widthList.add(styleMap["width"]);
    minWidthList.add(styleMap["min-width"]);
    maxWidthList.add(styleMap["max-width"]);

    heightList.add(styleMap["height"]);
    minHeightList.add(styleMap["height"]);
    maxHeightList.add(styleMap["height"]);
  });

  return [
    widthList,
    minWidthList,
    maxWidthList,
    heightList,
    minHeightList,
    maxHeightList
  ];
}

///그리드에서 타이틀 제외한 첫번째 데이터의 width, height style값을 추출해 반환하는 함수
List<List<String?>> _getCellSize(context) {
//타이틀을 제외한 첫번째 데이터의 Row
  var secondRow = context.tree.element?.querySelectorAll("tr")[1].children;
  List<String?> widthList = [];
  List<String?> minWidthList = [];
  List<String?> maxWidthList = [];

  List<String?> heightList = [];
  List<String?> minHeightList = [];
  List<String?> maxHeightList = [];

  RegExp regex = RegExp(
      r'(width|min-width|max-width|height|min-height|max-height):\s*(\d+)');

  secondRow.forEach((element) {
    var style = element.attributes['style'];
    var styleMap = {};

    for (RegExpMatch match in regex.allMatches(style)) {
      styleMap[match.group(1)!] = match.group(2);
    }

    widthList.add(styleMap["width"]);
    minWidthList.add(styleMap["min-width"]);
    maxWidthList.add(styleMap["max-width"]);

    heightList.add(styleMap["height"]);
    minHeightList.add(styleMap["height"]);
    maxHeightList.add(styleMap["height"]);
  });

  return [
    widthList,
    minWidthList,
    maxWidthList,
    heightList,
    minHeightList,
    maxHeightList
  ];
}

//grid- checkbox 위젯
//gridHeight만큼의 높이를 가짐
var gridCheckBoxMatcherWidget =
    CustomRender.widget(widget: (context, buildChildren) {
  var isCheck = false.obs;

  return Obx(
    () => SizedBox(
      height: gridHeight,
      child: Center(
          child: Transform.scale(
              scale: 0.8,
              child: Checkbox(
                //체크되었을 때
                activeColor: Colors.grey,
                //체크되지 않았을 때
                checkColor: Colors.white,
                value: isCheck.value,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onChanged: (bool? value) {
                  isCheck.value = value!;
                },
              ))),
    ),
  );
});

//콤보박스(select) 위젯
var comboBoxMatcherWidget =
    CustomRender.widget(widget: (context, buildChildren) {
  var divElement = context.tree.element;

  //선택 된 값 추출
  var selectedItem =
      divElement?.querySelector('option[selected="selected"]')?.text.obs;
  //선택 된 값
  void setSelected(String value) {
    selectedItem?.value = value;
  }

  //옵션에 태그 값 저장
  var selectElement = divElement?.querySelector('select');
  var optionTags = [].obs;

  if (selectElement != null) {
    var options = selectElement.getElementsByTagName('option');
    for (var option in options) {
      print(option.text);
      optionTags.add(option.text);
    }
  }

  return Obx(() => Container(
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//css style값을 따르거나 20의 높이를 가짐
      height: context.style.height?.value ?? 20,
//배경색 및 border 지정
      decoration: BoxDecoration(
        color: context.style.backgroundColor ?? Colors.white,
        border: Border.all(color: defaultBorder1),
      ),
      child: DropdownButton<String>(
//포커스 상태일때의 색 지정
//투명이 아니면 스크롤 영역을 벗어났을 때 해당 색상이 화면에 보이게 됨
        focusColor: Colors.transparent,
//기본 아이템 설정
        value: selectedItem?.value,
//오른쪽 아이콘은 높이의 80% 크기를 가짐
        iconSize: (context.style.height?.value ?? 20) / 1.2,
//옵션 아이템 (글자 크기는 높이의 75%)
        items: optionTags
            .map(
              (e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e,
                      style: TextStyle(
                          fontSize:
                              (context.style.height?.value ?? 20) / 1.5))),
            )
            .toList(),
        //이벤트
        onChanged: (value) {
          setSelected(value!);
        },
        //밑줄 제거
        underline: const SizedBox(),
        isExpanded: true,
      )));
});

//input + TextArea
var inputMatcherWidget = CustomRender.widget(widget: (context, buildChildren) {
  var divElement = context.tree.element;

  //labelText
  var placeholder = divElement?.attributes['placeholder'];

  // input 높이 구하기
  var heightValue;

  var borderRadius;
  var fontSize;

// // marigin & padding 값
//   var top;
//   var right;
//   var bottom;
//   var left;

  var marginValue = {};
  var paddingValue = {};

  var maxLength = divElement?.attributes['maxlength'] != null
      ? int.parse(divElement!.attributes['maxlength']!)
      : null;

  var style = divElement?.attributes['style'];
  if (style != null) {
    var styles = style.split(';');
    for (var item in styles) {
      //높이 구하기
      if (item.trim().startsWith('height')) {
        heightValue =
            double.tryParse(item.split(':')[1].trim().replaceAll('px', ''));
        print(heightValue);
      }
      // padding 구하기
      if (item.trim().startsWith('padding')) {
        var padding = item.split(':')[1].trim().split(' ');
        var top = padding[0].replaceAll('px', '');
        var right = padding[1].replaceAll('px', '');
        var bottom = padding[2].replaceAll('px', '');
        var left = padding[3].replaceAll('px', '');
        paddingValue = {
          'top': top,
          'right': right,
          'bottom': bottom,
          'left': left,
        };
      }
      // margin 구하기
      if (item.trim().startsWith('margin')) {
        var margin = item.split(':')[1].trim().split('  '); // 공백 두 개로 분할
        // margin.removeWhere((element) => element.isEmpty);
        var top = margin[0].replaceAll('px', '');
        var right = margin[1].replaceAll('px', '');
        var bottom = margin[2].replaceAll('px', '');
        var left = margin[3].replaceAll('px', '');
        marginValue = {
          'top': top,
          'right': right,
          'bottom': bottom,
          'left': left,
        };
      }
      //테두리
      if (item.trim().startsWith('border-radius')) {
        borderRadius =
            double.tryParse(item.split(':')[1].trim().replaceAll('px', ''));
      }
      //글씨 크기 -> flutter 고정값 20
      if (item.trim().startsWith('font-size')) {
        fontSize =
            double.tryParse(item.split(':')[1].trim().replaceAll('px', ''));
      }
    }
  }

  print('marginValue $marginValue');
  print(paddingValue);

  return Container(
      height: heightValue,
      // margin: EdgeInsets.fromLTRB(
      //   double.tryParse(marginValue['left'] ?? '0') ?? 0,
      //   double.tryParse(marginValue['top'] ?? '0') ?? 0,
      //   double.tryParse(marginValue['right'] ?? '0') ?? 0,
      //   double.tryParse(marginValue['bottom'] ?? '0') ?? 0,
      // ),
      child: TextField(
        keyboardType: TextInputType.multiline,
        textAlignVertical: maxLength != null ? TextAlignVertical.top : null,
        expands: true,
        minLines: null,
        maxLines: null,
        maxLength: maxLength != null ? maxLength : null,
        style: fontSize != null ? TextStyle(fontSize: fontSize) : null,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          border: OutlineInputBorder(
            borderRadius: borderRadius != null
                ? BorderRadius.circular(borderRadius)
                : BorderRadius.circular(0),
          ),
          hintText: placeholder,
          // labelText: placeholder,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: paddingValue != null
              ? EdgeInsets.fromLTRB(
                  double.tryParse(paddingValue['left'] ?? '0') ?? 12,
                  double.tryParse(paddingValue['top'] ?? '0') ?? 20,
                  double.tryParse(paddingValue['right'] ?? '0') ?? 12,
                  double.tryParse(paddingValue['bottom'] ?? '0') ?? 12,
                )
              : null,
        ),
      ));
});

//iframe
var iframeMatcherWidget = CustomRender.widget(widget: (context, buildChildren) {
  var divElement = context.tree.element;
  var iframe = divElement?.attributes["src"];

//html 인지 URL 인지 확인 해야함

  if (iframe != null) {
    return WebViewX(
      width: 1000,
      height: 800,
      initialContent: iframe,
      initialSourceType: SourceType.URL,
      onWebViewCreated: (controller) {
// 웹 뷰가 생성된 후에 수행할 작업
      },
    );
  } else {
// iframe이 없을 경우 처리할 내용
    return Container();
  }
});
