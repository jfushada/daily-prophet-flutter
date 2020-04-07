import 'package:daily_prophet_flutter/features/news/views/news_list_view.dart';
import 'package:daily_prophet_flutter/features/splash/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/news/stores/news_store.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => NewsStore()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  static const primaryColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Prophet Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        canvasColor: Colors.black,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: primaryColor,
        textTheme: Theme.of(context).textTheme.copyWith(
              caption: TextStyle(color: Colors.white54),
              subhead: TextStyle(fontFamily: 'Garamond', fontSize: 10.0),
            ),
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => SplashView(),
            );
          case '/news-list-view':
            return MaterialPageRoute(
              builder: (context) => NewsListView(),
            );
          default:
            throw UnimplementedError('no route for $settings');
        }
      },
    );
  }
}
