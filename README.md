# App Feedback

[![Open Source Love](https://badges.frapsoft.com/os/v2/open-source.svg?v=103)](https://github.com/TheAlphamerc/app_feedback)
[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2FTheAlphamerc%2Fapp_feedback&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)
![GitHub last commit](https://img.shields.io/github/last-commit/TheAlphamerc/app_feedback)
[![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/TheAlphamerc/app_feedback.svg)](https://github.com/TheAlphamerc/app_feedback)
[![GitHub stars](https://img.shields.io/github/stars/Thealphamerc/app_feedback?style=social)](https://github.com/login?return_to=https://github.com/TheAlphamerc/app_feedback) 
![GitHub forks](https://img.shields.io/github/forks/TheAlphamerc/app_feedback?style=social)

[![pub package](https://img.shields.io/pub/v/app_feedback?color=blue)](https://pub.dev/packages/app_feedback) 
[![Likes](https://badges.bar/app_feedback/likes)](https://pub.dev/packages/app_feedback/score)
[![Popularity](https://badges.bar/app_feedback/popularity)](https://pub.dev/packages/app_feedback/score)
[![Pub points](https://badges.bar/app_feedback/pub%20points)](https://pub.dev/packages/app_feedback/score)

A Flutter package for getting app feedback from users. It provides the utility to display feedback form depending upon the requirement. 
Feedback form can be displayed instantly at any time or after certain period of time.

## Download Demo App ![GitHub All Releases](https://img.shields.io/github/downloads/Thealphamerc/app_feedback/total?color=green)
<a href="https://github.com/TheAlphamerc/app_feedback/releases/download/v0.0.1/app-release.apk"><img src="https://playerzon.com/asset/download.png" width="200"></img></a>

## How to use this package

#### 1. Add library to pubspec.yml
```yaml
dependencies:
  app_feedback: ^0.0.2
```

#### 2. Import library in dart file.

```dart
import 'package:app_feedback/app_feedback.dart';
```

#### 3. Create a instance of `AppFeedback`

```dart
AppFeedback feedbackForm = AppFeedback.instance;
```

#### 4. Initialize the app feedback (Ony if you want to ask user for his feedback periodically)

```dart
 @override
  void initState() {
    /// `duration` is set to 10 seconds for testing purpose.
    /// Change this duration on the basis of how often you want to ask user for his feedback.
    /// For example duration can be 15 days, 1 or 2 month etc.
    feedbackForm.init(FeedbackConfig(duration: Duration(seconds: 10)));
    super.initState();
  }
```

#### 5. Create a method which will launch the feedback form

```dart
 void tryDisplay() {
    feedbackForm.tryDisplay(context, onSubmit: (UserFeedback feedback) {
      print(feedback);
    });
  }
```

#### 6. Create a button to call `tryDisplay` method.

```dart
TextButton(
    onPressed: tryDisplay,
    child: Text("Try Display Form")
 ),
```

> **Note**
>
> 1. `feedbackForm` will only be displayed once provided duration in step 3 has passed.
> 2. Once `feedbackForm` is displayed then it won't be displayed until the next cycle of the duration is completed.
> 3. The `config` data provided in first time initialization of `feedbackForm` is stored in local cache and other initialization data will be ignored.

#### 7. Clear old configuration

Invoke `clearConfig` method only if there is a need to clear the old `config` values otherwise ignore this.

```dart
  void clearConfig() async {
    await feedbackForm.clearConfig();
 }
```

> **Note**
>
> 1. After clearing the configuration it won't be display the feedback form ever until new initialization.
> 2. Clear configuration form doesn't mean reset the duration cycle. It just removes the all configuration from the cache.
> 3. To reset duration and other configuration do call the `feedbackForm.init()` method with new `config` values.

### Display instant `feedbackForm`

If there is a need to display `feedbackForm` instantly on any time then invoke `feedbackForm.display` method.
By calling this method won't reset the duration cycle provided in above step 3.
To invoke below method there is no need to initialize the `feedbackForm`.

```dart
void launchAppFeedback() {
    feedbackForm.display(context,
        option: Option(
          maxRating: 10,
          ratingButtonTheme: RatingButtonThemeData.defaultTheme,
        ), onSubmit: (feedback) {
      print(feedback);
    });
  }
```


Feedback form |  Customised Rating button        |  Customised Rating button         
:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/app_feedback/blob/main/screenshots/screenshot-1.jpg?raw=true)|![](https://github.com/TheAlphamerc/app_feedback/blob/main/screenshots/screenshot-2.jpg?raw=true)|![](https://github.com/TheAlphamerc/app_feedback/blob/main/screenshots/screenshot-3.jpg?raw=true)

Hidden feedback field    |  Customised feedback form     |  Customised feedback form    
:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/TheAlphamerc/app_feedback/blob/main/screenshots/screenshot-4.jpg?raw=true)|![](https://github.com/TheAlphamerc/app_feedback/blob/main/screenshots/screenshot-6.jpg?raw=true)|![](https://github.com/TheAlphamerc/app_feedback/blob/main/screenshots/screenshot-5.jpg?raw=true)

## Other Flutter packages

| Name                                                                          | Stars                                                                                                                                                                                                          | Pub                                                                                                                   |
| :---------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| [Filter List](https://github.com/TheAlphamerc/flutter_plugin_filter_list)     | [![GitHub stars](https://img.shields.io/github/stars/Thealphamerc/flutter_plugin_filter_list?style=social)](https://github.com/login?return_to=https://github.com/TheAlphamerc/flutter_plugin_filter_list)     | [![pub package](https://img.shields.io/pub/v/empty_widget?color=blue)](https://pub.dev/packages/filter_list)          |
| [Empty widget](https://github.com/TheAlphamerc/empty_widget)                  | [![GitHub stars](https://img.shields.io/github/stars/Thealphamerc/empty_widget?style=social)](https://github.com/login?return_to=https://github.com/TheAlphamerc/empty_widget)                                 | [![pub package](https://img.shields.io/pub/v/empty_widget?color=blue)](https://pub.dev/packages/empty_widget)         |
| [Add Thumbnail](https://github.com/TheAlphamerc/flutter_plugin_add_thumbnail) | [![GitHub stars](https://img.shields.io/github/stars/Thealphamerc/flutter_plugin_add_thumbnail?style=social)](https://github.com/login?return_to=https://github.com/TheAlphamerc/flutter_plugin_add_thumbnail) | [![pub package](https://img.shields.io/pub/v/add_thumbnail?color=blue)](https://pub.dev/packages/add_thumbnail)       |
| [Country Provider](https://github.com/TheAlphamerc/country_provider)          | [![GitHub stars](https://img.shields.io/github/stars/Thealphamerc/country_provider?style=social)](https://github.com/login?return_to=https://github.com/TheAlphamerc/country_provider)                         | [![pub package](https://img.shields.io/pub/v/country_provider?color=blue)](https://pub.dev/packages/country_provider) |

## Pull Requests

I welcome and encourage all pull requests. It usually will take me within 24-48 hours to respond to any issue or request.

## Created & Maintained By

[Sonu Sharma](https://github.com/TheAlphamerc) ([Twitter](https://www.twitter.com/TheAlphamerc)) ([Youtube](https://www.youtube.com/user/sonusharma045sonu/))
([Insta](https://www.instagram.com/_sonu_sharma__)) ![Twitter Follow](https://img.shields.io/twitter/follow/thealphamerc?style=social)

> If you found this project helpful or you learned something from the source code and want to thank me, consider buying me a cup of :coffee:

> - <a href="https://www.buymeacoffee.com/thealphamerc"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" width="120"></a>
> - [PayPal](https://www.paypal.me/TheAlphamerc/)

## Visitors Count

<img align="left" src = "https://profile-counter.glitch.me/app_feedback/count.svg" alt ="Loading">
