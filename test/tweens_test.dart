import 'package:daily_prophet_flutter/features/news/widgets/headline.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';


/// This unit test checks the simple tween used in the headline title - it's good for unit testing because it's basically just math.
/// GhostFadeTween basically has one minor piece of logic - at a certain point of the interpolation, the function switches dramatically
/// I’m testing that it transitions colors correctly. 

/// In the app, it transitions from blue, and then goes into white, and goes into the red.  
/// In the test, I’m  stating the desired behaviour: when I’m lerping at 0, I expect the color to be blue, when I’m lerping at half, i expect it to be white, and when I lerp it at 1, I expect the colour to be red. 

/// So if someone changes this code, I already have proof here that this is the intended behaviour, and if you want to change it, there has to be some intention behind it. 
/// If you want to go further, think of the values that could be passed into the function and see that how you’re going to handle that problem. 
/// In this example, the values for the lerp values come from the animation framework, so it’s pretty safe to assume that it’s not going to send null or something weird. 

/// I made the colors using Color.fromARGB instead of just Colors.white, because if I do that, it returns an error.
/// it expects a Material Color but the actual value is just Color, which is basically the same, but it doesn’t really know that. 
/// So, expect fiddly things when you’re writing tests, you’ll get to see a lot of Dart’s quirks. 


void main() {
  group('_GhostFadeTween', () {
    test('interpolates colors correctly', () {
      Color blue = Color.fromARGB(255, 0, 0, 255);
      Color red = Color.fromARGB(255, 255, 0, 0);
      Color white = Color.fromARGB(255, 255, 255, 255);
      GhostFadeTween tween = GhostFadeTween(
        begin: blue,
        end: red,
      );

      expect(tween.lerp(0.0), blue);
      expect(tween.lerp(0.5), white);
      expect(tween.lerp(1.0), red);
    });
  });
}
