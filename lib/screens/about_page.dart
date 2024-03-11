import 'package:flutter/material.dart';
import 'package:land_registration/widget/footer.dart';
import 'package:land_registration/widget/header_user.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double scrWidth = MediaQuery.of(context).size.width;
    double scrHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          // Header section
          SizedBox(
            height: scrHeight * 0.17,
            width: scrWidth,
            child: Material(
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(0),
                child: HeaderUserWidget(),
              ),
            ),
          ),
          // Image section
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            width: scrWidth * 0.29, // Adjust width as needed
            child: Image.asset(
              'assets/SSSS.png', // Provide your image asset path
              fit: BoxFit.cover, // Adjust the fit as needed
            ),
          ),
          // About section
          // Footer section
          Center(child: FooterWidget()),
        ],
      ),
    );
  }
}
