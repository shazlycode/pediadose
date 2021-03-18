import 'package:flutter/material.dart';
import 'package:pediatric_dosage/providers/dosage_provider.dart';
import 'package:pediatric_dosage/screens/details.dart';
import 'package:pediatric_dosage/screens/main_screen.dart';
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
        home: MainScreen(),
        theme: ThemeData(
            canvasColor: Color(0xff28527a),
            textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(color: Color(0xfffbeeac), fontSize: 20),
                bodyText2: TextStyle(color: Color(0xfffbeeac)))),
        routes: {
          Details.id: (context) => Details(),
        },
      ),
    );
  }
}
