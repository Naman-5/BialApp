import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'helper/check_signin.dart';
import '../sign_up.dart';

// ignore: must_be_immutable
class FeedBackForm extends StatelessWidget {
  late var toggle = true;

  FeedBackForm({Key? key}) : super(key: key) {
    print("constructor");
    CheckSignIn check = CheckSignIn();
    check.check();
    if (MaintainPageStack.keyCheck == false) {
      print('Inside False');
      toggle = false;
    } else {
      print('inside true');
      toggle = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    return toggle ? _FeedBack() : const SignUP();
  }
}

class _FeedBack extends StatelessWidget {
  final feedbackController = TextEditingController();

  // FeedBack() {
  //   CheckSignIn c = CheckSignIn();
  //   selector = c.check();
  //   print(selector);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback & Comments"),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // experience
            const Text(
              "How would you rate your experience with BIAL-consierge App ?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
            // experience rating builder
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                FeedbackSupport.expeienceRating = rating;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            // security screening
            const Text(
              "How satisfied were you with Security Screening Process?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
            // security screening rating builder
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                FeedbackSupport.securityScreeningRating = rating;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            // processes
            const Text(
              "How satisfied were you with the Check-in, immigration and custom processes?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
            // processes rating builder
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                FeedbackSupport.processes = rating;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            // cleanliness
            const Text(
              "How satisfied were you with overall cleanliness of the Terminal Building?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
            // cleanliness rating builder
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                FeedbackSupport.cleanliness = rating;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            // comments
            const Text(
              "Any other comments or Feedback:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
            TextField(
              maxLines: 5,
              cursorColor: Colors.white,
              autocorrect: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (String text) {
                FeedbackSupport.feedback = text;
              },
              controller: feedbackController,
            ),
            TextButton(onPressed: () {}, child: const Text("Submit"))
          ],
        ),
      )),
    );
  }
}

class FeedbackSupport {
  static double expeienceRating = 0;
  static double securityScreeningRating = 0;
  static double processes = 0;
  static double cleanliness = 0;
  static String feedback = "";
}
