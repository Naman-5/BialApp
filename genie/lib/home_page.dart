import 'package:flutter/material.dart';
import 'package:genie/contact_info.dart';
import 'package:genie/lost_found.dart';
import 'package:genie/customs.dart';
import 'package:genie/feedback.dart';
import 'package:genie/home_spcl_ass.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePageIcons extends StatelessWidget {
  const HomePageIcons(
      {Key? key,
      required this.iconData,
      required this.label,
      required this.navigateTo})
      : super(key: key);

  final IconData iconData;
  final String label;
  final Widget navigateTo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (builder) => navigateTo));
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 30, 20, 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[100],
            ),
            child: Icon(
              iconData,
              color: Colors.grey,
              size: 35,
            ),
          ),
        ),
        SizedBox(
          width: 80,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<HomePageIcons> _homePageIcons = [
    const HomePageIcons(
        iconData: Icons.contact_page_rounded,
        label: 'Airline Info',
        navigateTo: AirlineContact()),
    const HomePageIcons(
        iconData: Icons.luggage_rounded,
        label: 'Lost&Found',
        navigateTo: LostFoundPage()),
    HomePageIcons(
        iconData: Icons.feedback_rounded,
        label: "Feedback",
        navigateTo: FeedBackForm()),
    const HomePageIcons(
        iconData: Icons.account_circle_rounded,
        label: 'Profile',
        navigateTo: Scaffold()),
    const HomePageIcons(
        iconData: Icons.wheelchair_pickup_rounded,
        label: 'Special Services',
        navigateTo: SpecialAssist()),
    HomePageIcons(
        iconData: Icons.file_copy_rounded,
        label: 'Customs Declaration',
        navigateTo: CustomsForm())
  ];

  final List<Map<String, String>> cardInfo = [
    {
      'imageUrl':
          'https://storageaccountbial8bd8.blob.core.windows.net/images/Highlights1.jpeg',
      'pageUrl':
          'https://www.bengaluruairport.com/travellers/at-the-airport/experience/retail-store/season-of-smiles-8-shopping-festival.html'
    },
    {
      'imageUrl':
          'https://storageaccountbial8bd8.blob.core.windows.net/images/Highlights2.jpeg',
      'pageUrl':
          'https://www.bengaluruairport.com/corporate/engage-with-us/tenders.html'
    },
    {
      'imageUrl':
          'https://storageaccountbial8bd8.blob.core.windows.net/images/Highlights3.jpeg',
      'pageUrl':
          'https://www.bengaluruairport.com/travellers/passenger-services/faqs-at-blr.html'
    },
    {
      'imageUrl':
          'https://storageaccountbial8bd8.blob.core.windows.net/images/Highlights4.jpg',
      'pageUrl':
          'https://www.bengaluruairport.com/travellers/passenger-services/covid-19_test.html'
    }
  ];

  Widget generateCards(String imageUrl, String pageUrl, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HighlightsWebView(
                          pageUrl: pageUrl,
                        )));
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.fitHeight,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Stack(
        children: [
          Container(
            height: height / 2.2,
            child: Image.asset(
              'assets/images/airport3.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: height / 2.4),
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 40),
                    child: Text(
                      'Highlights',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500]),
                    )),
                SizedBox(
                  height: 100,
                  width: width,
                  child: ListView(
                    children: List.generate(
                        cardInfo.length,
                        (index) => generateCards(
                            cardInfo[index]['imageUrl'] ?? "",
                            cardInfo[index]['pageUrl'] ?? "",
                            context)),
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        children: _homePageIcons),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class HighlightsWebView extends StatefulWidget {
  const HighlightsWebView({Key? key, required this.pageUrl}) : super(key: key);
  final String pageUrl;
  @override
  _HighlightsWebViewState createState() => _HighlightsWebViewState();
}

class _HighlightsWebViewState extends State<HighlightsWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl: widget.pageUrl,
      ),
    );
  }
}
