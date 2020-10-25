import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:daily_prophet_flutter/features/news/widgets/headline.dart';

/// Unit tests can take you all the way up to the point where you want to render a widget and make some kind of assertion about a property of widget itself. 
/// So size, handling clicking and asserting that some kind of method is called when you click - that’s all widget tests.
/// But business logic, mapping or transformation, that’s all unit tests. They help to make sure that when you make small changes, you don’t break something else.

/// Instead of using the test package, we use the flutter_test package which provides additional utilities for testing widgets.
/// A good strategy for widget testing is that when you have widgets that are tied up to async functions, or an api service, that could be harder to test. 
/// So if you can abstract out the widget that just displays from the logic that interacts with that layer, and therefore you can pass props into that widget
/// because it’s stateless -so it’s way easier to write widget tests for those, and it’s much quicker to run. 

/// When when you pump a widget, and wait, and pump, that takes time. When you have complicated UIs, they might run long. 
/// So if you can make your store mockable, so you can just throw dummy data that runs really fast, or just make the widget stateless so you can run it like a function. 

/// The widget I’m testing is the headline widget, which is basically similar to the lerping unit test, but with an actual widget test. 
/// So we’re testing the colour and the title changes. Headline is an animated widget, you give it a colour and text, and it just shows that. 
/// But when you move to another index and text, it slowly, in 600 miliseconds, changes towards the other color. 
/// So everytime the parameter changes, the widget rebuilds, and that causes the animation to happen. 
/// It's good to have the constants available so that it's possible to import them in the test and make use of them for assertions. 

/// The function takes a Widget Tester, and the first thing you do is pump the widget you want to make an assertion on - in this case, our headline file. 
/// There are two parameters, test and index. So for an example, let’s do foo, and index 0. 
/// The test basically takes that widget, stages it, and the tester will refer to that widget. 
/// The widget it pumps is not actually the exact size, so try not to make size assertions here. 
/// If you want to care about the size, there are things called Golden widget tests, which checks your widget against an actual snapshot, or an image. 
/// Here we’re just testing the behaviour. 

/// So we have to figure out what it wants to say. We can use finder, where you find a particular widget, multiple ways to do that, and a matcher, which says what was found by the finder. 
/// In this case, what we can find is a text with colour. So you can use findByText (the flutter test docs has a lot of different functions, in the finder property). In this case, we find a widget with text 'Foo'.
/// The widget we’re testing is made into a local variable cause we’re using it multiple times. We need to tell the state is that if we change the headline foo to bar, we pump the widget, and it’ll change the text to bar. That’s why I wrapped it in a stateful builder.


void main() {
  testWidgets('headline animates and changes text correctly',
      (WidgetTester tester) async {
    String text = "Foo";
    int index = 0;
    Key buttonKey = GlobalKey();
    Key headlineKey = GlobalKey();

    Widget widget = StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: <Widget>[
              Headline(
                key: headlineKey,
                text: text,
                index: index,
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    text = 'Bar';
                    index = 1;
                  });
                },
                child: Text("Tap"),
                key: buttonKey,
              )
            ],
          ),
        );
      },
    );
    await tester.pumpWidget(
      widget,
    );

    expect(find.text('Foo'), findsOneWidget);

    await tester.pump();

    await tester.tap(find.byKey(buttonKey));

    await tester.pumpAndSettle(headlineAnimationDuration);

    expect(find.text('Bar'), findsOneWidget);
  });

  testWidgets('headline animates and changes text color correctly',
      (WidgetTester tester) async {
    String text = "Foo";
    int index = 0;
    Key buttonKey = GlobalKey();
    Key headlineKey = GlobalKey();
    Headline headline;

    Widget widget = StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        headline = Headline(
          key: headlineKey,
          text: text,
          index: index,
        );

        return Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: <Widget>[
              headline,
              FlatButton(
                onPressed: () {
                  setState(() {
                    text = 'Bar';
                    index = 1;
                  });
                },
                child: Text("Tap"),
                key: buttonKey,
              )
            ],
          ),
        );
      },
    );
    await tester.pumpWidget(
      widget,
    );

    expect(headline.targetColor, headlineTextColors[index]);

    await tester.pump();

    await tester.tap(find.byKey(buttonKey));

    await tester.pumpAndSettle(headlineAnimationDuration);

    expect(headline.targetColor, headlineTextColors[index]);
  });
}
