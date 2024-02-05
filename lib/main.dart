import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:js_flutter/page/FirstPage.dart';

import 'common/constants.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  flutterJs.init();
  // String htmlPath = 'assets/document/flutter.html';
  // String htmlString =  await rootBundle.loadString(htmlPath);

  runApp(MyApp());

}



class MyApp extends StatelessWidget {


  MyApp({super.key}){

  }


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'FlutterHTML',
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: true,
        home: Scaffold(
            body: FirstPage()
        )
    );
    ///////////////////////////////
  }
}