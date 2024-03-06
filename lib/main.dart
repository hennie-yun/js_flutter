import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_flutter/page/FirstPage.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
        title: 'FlutterHTML',
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: true,
        home: Scaffold(
            backgroundColor: Colors.white,
            body: FirstPage()
        )
    );
  }

}
