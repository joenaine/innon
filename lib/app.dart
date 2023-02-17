import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innon/generated/l10n.dart';
import 'package:innon/init_widget.dart';
import 'package:innon/pages/home/home_page.dart';
import 'package:innon/resources/themes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 732),
      builder: (context, child) {
        return InitWidget(
          child: MaterialApp(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: const Locale('en', 'EN'),
            debugShowCheckedModeBanner: false,
            theme: Themes.defaultTheme,
            home: const HomePage(),
          ),
        );
      },
    );
  }
}
