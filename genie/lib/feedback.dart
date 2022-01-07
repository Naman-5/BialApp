import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'helper/check_signin.dart';
import 'home_screen.dart';
import 'package:http/http.dart' as http;
import '../sign_up.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ignore: must_be_immutable
class FeedBackForm extends StatelessWidget {
  late var toggle = true;

  FeedBackForm({Key? key}) : super(key: key);
  // toggle ? _FeedBack() : const SignUP()
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == false) {
            return const SignUP();
          } else {
            return _FeedBack();
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
      future: CheckSignIn.check(),
    );
  }
}

class _FeedBack extends StatelessWidget {
  final feedbackController = TextEditingController();

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
            TextButton(
                onPressed: () async {
                  var url = Uri.parse(
                      'https://bialapp.azurewebsites.net/api/feedback?code=Veb2e7zPpaJzjO9d4vh3uE/3aTX7HDe6gUOIHvN5B5sN1ZXKFqU1IA==');
                  try {
                    const storage = FlutterSecureStorage();
                    var response = await http.post(url,
                        body: json.encode({
                          'token': await storage.read(key: "signInToken"),
                          'appExperience':
                              FeedbackSupport.expeienceRating.toString(),
                          'securityScreening': FeedbackSupport
                              .securityScreeningRating
                              .toString(),
                          'processes': FeedbackSupport.processes.toString(),
                          'cleanliness': FeedbackSupport.cleanliness.toString(),
                          'comments': FeedbackSupport.feedback
                        }));
                    print("response -> ${json.decode(response.body)}");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  } on Exception {
                    print('failed');
                  }
                },
                child: const Text("Submit"))
          ],
        ),
      )),
    );
  }
}

class FeedbackSupport {
  static double expeienceRating = 3;
  static double securityScreeningRating = 3;
  static double processes = 3;
  static double cleanliness = 3;
  static String feedback = "";
}
