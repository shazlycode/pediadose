import 'package:flutter/material.dart';
import 'package:pediatric_dosage/providers/dosage_provider.dart';
import 'package:pediatric_dosage/screens/contact_us.dart';
import 'package:pediatric_dosage/screens/details.dart';
import 'package:pediatric_dosage/screens/how_to_use.dart';
import 'package:pediatric_dosage/screens/main_screen.dart';
import 'package:pediatric_dosage/screens/resources.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(),
        ),
        ChangeNotifierProvider(create: (_) => AntipyreticProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
        theme: ThemeData(
            canvasColor: Color(0xffe4fbff),
            primaryColor: Color(0xff7868e6),
            textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(color: Color(0xff7868e6), fontSize: 20),
                bodyText2: TextStyle(color: Color(0xff222831)))),
        routes: {
          Details.id: (context) => Details(),
          HowToUse.id: (context) => HowToUse(),
          Resources.id: (context) => Resources(),
          ContactUs.id: (context) => ContactUs(),
        },
      ),
    );
  }
}
