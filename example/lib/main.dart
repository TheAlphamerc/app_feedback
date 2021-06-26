import 'package:app_feedback/app_feedback.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback form Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AppFeedback feedbackForm = AppFeedback.instance;

  UserFeedback feedback;
  @override
  void initState() {
    feedbackForm.init(
      Option(
          duration: Duration(seconds: 10),
          displayLogs: true,
          defaultRating: 5,
          defaultReview: "Love this app ❤️"),
    );
    super.initState();
  }

  Widget get rating {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: !feedbackAvailable
          ? [SizedBox()]
          : [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "Rating:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${feedback.rating}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              if (feedback.review.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Review:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          "${feedback.review}",
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                )
            ],
    );
  }

  void launchAppFeedback() {
    feedbackForm.display(context,
        option: Option(defaultRating: 5, defaultReview: "Love this app ❤️"),
        onSubmit: (feedback) {
      this.feedback = feedback;
      setState(() {});
    });
  }

  void tryDisplay() {
    feedbackForm.tryDisplay(context, onSubmit: (feedback) {
      this.feedback = feedback;
      setState(() {});
    });
  }

  /// Clear saved user's feedback from cache
  void resetForm() async {
    await feedbackForm.reset();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Form reset successfully!!")));
    feedback = null;

    /// Initilise the feedback form form after reseting
    feedbackForm
        .init(Option(duration: Duration(seconds: 10), displayLogs: true));

    setState(() {});
  }

  void getAppSavedFeedback() async {
    final feed = await feedbackForm.savedFeedback;
    if (feed.rating != null) {
      this.feedback = feed;
    }
  }

  bool get feedbackAvailable => feedback != null && feedback.rating != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback Form Demo"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              rating,
              SizedBox(height: 20),
              MaterialButton(
                colorBrightness: Brightness.light,
                onPressed: launchAppFeedback,
                child: Text("Display Form"),
                textColor: Colors.white,
                color: Colors.blue[400],
                elevation: 0,
              ),
              SizedBox(height: 20),
              MaterialButton(
                colorBrightness: Brightness.light,
                onPressed: tryDisplay,
                child: Text("Try Display Form"),
                textColor: Colors.white,
                color: Colors.blue[400],
                elevation: 0,
              ),
              SizedBox(height: 20),
              MaterialButton(
                colorBrightness: Brightness.light,
                onPressed: resetForm,
                child: Text("Reset Form"),
                textColor: Colors.white,
                color: Colors.blue[400],
                elevation: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
