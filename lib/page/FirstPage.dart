
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          SizedBox(height: 300),
          Center(
            child: ElevatedButton(
                onPressed: () async{

                  var htmlString = await getHtmlString();
                  Get.to(() => TestPage(htmlString: htmlString));
                },
                style: ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.all(30))),
                child: Text("화면이동")
            ),
          )
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class FirstPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: WebView(
//         initialUrl: Uri.encodeFull(
//             '''
//             <html>
//             <body>
//                 <button id="myButton" style="padding: 30px;">화면이동</button>
//                 <script>
//                     document.getElementById('myButton').onclick = window.open('assets/document/test3.html')
//
//                 </script>
//             </body>
//             </html>
//             '''),
//         javascriptMode: JavascriptMode.unrestricted,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//
// class FirstPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: InAppWebView(
//         initialData: InAppWebViewInitialData(
//         data: '''
//             <html>
//             <body>
//                 <button id="myButton" style="padding: 30px;">YouTube로 이동</button>
//                 <script>
//                     document.getElementById('myButton').onclick = function() {
//                         window.location.href = 'https://www.youtube.com';
//                     }
//                 </script>
//             </body>
//             </html>
//             '''),
//       ),
//     );
//   }
// }




