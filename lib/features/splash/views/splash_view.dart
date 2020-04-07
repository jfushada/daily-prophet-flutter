import 'package:daily_prophet_flutter/features/news/views/news_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key key}) : super(key: key);

  static const String routeName = '/';

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future<void>.delayed(const Duration(seconds: 1));

      Navigator.pushNamed(context, NewsListView.routeName);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'Daily Prophet Flutter',
            key: Key('SplashViewTitle'),
            style: TextStyle(
              fontFamily: 'HarryP',
              color: Colors.white,
              fontSize: 40.0,
            ),
          ),
        ),
      ),
    );
  }
}
