## Rotary Dial
A Widget that allows you to dial numbers by rotating the dial.

![demo1](https://user-images.githubusercontent.com/93796040/229567026-dce9ad77-e3ce-4f31-8f8e-d19a8758b95a.gif)

Click [**here**](https://github.com/flutterwtf/wtf_rotary_dial/blob/package/example/lib/main.dart) to view the full example.

Inspired by [this](https://github.com/mkobuolys/flutter-design-challenges/tree/master/flutter_rotary_passcode).

## Installing
Add it to your `pubspec.yaml` file:
```yml
dependencies:
  wtf_rotary_dial: ^0.1.0
```
Install packages from the command line
```
flutter pub get
```
If you like this package, consider supporting it by giving it a star on [**GitHub**](https://github.com/flutterwtf/wtf_rotary_dial) and a like on [**pub.dev**](https://pub.dev/) ❤️

## Usage

You can use the Rotary Dial widget in the following way:

```dart
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WTF Rotary Dial',
      home: Scaffold(
        body: Center(
          child: RotaryDial(
            onDigitSelected: (value) {
              // The value is entered number.
            },
            rotaryDialThemeData: RotaryDialThemeData(
              spinnerColor: const Color(0xFFFFFFFF),
              rotaryDialColor: const Color(0xFF1871F0),
              dialColor: const Color(0xFF529AFF),
              numberColor: const Color(0xFFFFFFFF),
              margin: null,
              dialBorderRadius: null,
            ),
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate,
          ),
        ),
      ),
    );
  }
```

### Result:

![demo1](https://user-images.githubusercontent.com/93796040/229563457-b4e24c29-5763-4ccd-b042-ec674cca075d.gif)

## Theme

You can customize the widget to your liking. There is a helper `RotaryDialThemeData` class for this.

| Parameter        | Description                                                                                                   |
|------------------|---------------------------------------------------------------------------------------------------------------|
| rotaryDialColor  | This parameter is responsible for assigning the color of the main circle.                                     |
| spinnerColor     | This parameter is responsible for assigning the color of the rotating part.                                   |
| dialColor        | This parameter is responsible for assigning the color of the circle inside which the number is located.       |
| numberColor      | This parameter is responsible for assigning the color of numbers.                                             |
| margin           | This parameter is responsible for setting the outer padding.                                                  |
| dialBorderRadius | This parameter is responsible for assigning the radius of the circle inside which the number is located.      |