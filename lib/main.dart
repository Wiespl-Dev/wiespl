import 'package:flutter/material.dart';
import 'package:wiespl/screen/splash.dart';
import 'package:wiespl/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

// ignore: library_prefixes
import 'package:wiespl/routes/router.dart' as RouterFile;

void main() async {
  await init();
  runApp(const MyApp());

  final systemTheme = SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: colorApp,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarColor: colorApp,
    statusBarIconBrightness: Brightness.light,
  );

  SystemChrome.setSystemUIOverlayStyle(systemTheme);
}

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  void initState() {
    // super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WIESPL',
      home: const Splash(),
      builder: EasyLoading.init(),
      getPages: RouterFile.Router.route,
      theme: ThemeData(
        primaryColor: colorBlack,
        brightness: Brightness.light,
        scaffoldBackgroundColor: colorWhite,
        dialogBackgroundColor: colorBlack,
        dividerColor: Colors.black12,
        cardColor: colorWhite,
        canvasColor: colorWhite,
        hintColor: colorGray,
        // accentColor: colorApp,
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.white),
        fontFamily: "Regular",
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 30,
              fontFamily: "Medium",
              color: colorWhite), // replaces headline4
          displayMedium: TextStyle(
              fontSize: 26,
              fontFamily: "Medium",
              color: colorApp), // replaces headline2
          displaySmall: TextStyle(
              fontSize: 20,
              fontFamily: "Medium",
              color: colorText), // replaces headline3
          headlineMedium: TextStyle(
              fontSize: 16,
              fontFamily: "Medium",
              color: colorText), // replaces headline1
          bodyLarge: TextStyle(
              fontSize: 16,
              fontFamily: "Medium",
              color: colorText), // replaces bodyText2
          bodyMedium: TextStyle(
              fontSize: 14,
              fontFamily: "Medium",
              color: colorApp), // replaces bodyText1
          titleMedium: TextStyle(
              fontSize: 14,
              fontFamily: "Medium",
              color: colorApp), // replaces subtitle1
          titleSmall: TextStyle(
              fontSize: 12,
              fontFamily: "Regular",
              color: colorText), // replaces subtitle2
          labelLarge: TextStyle(
              fontSize: 16,
              fontFamily: "Medium",
              color: colorWhite), // replaces button
          labelSmall: TextStyle(
              fontSize: 10, fontFamily: "Regular"), // replaces overline
        ),

        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
            .copyWith(secondary: colorWhite),
      ),
    );
  }
}
