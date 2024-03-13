import 'package:flutter/material.dart';
import 'package:land_registration/screens/about_page.dart';
import '../widget/general_header.dart';


class LearnMorePage extends StatelessWidget {
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
                child: GeneralHeaderWidget(),
              ),
            ),
          ),
        Padding(
  padding: const EdgeInsets.only(top:50.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'Welcome to Land Registry using Blockchain',
        style: TextStyle(
          fontSize: 55,
          fontWeight: FontWeight.w900,
        ),
      ),
      SizedBox(height: 50),
      Container(
        width: 2000, // Use full width for the container
        child: Text(
          'Land registry systems worldwide are facing challenges related to security, transparency, and efficiency. Traditional paper-based systems are prone to fraud, errors, and delays. However, leveraging blockchain technology can revolutionize land registry processes.',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 37,fontWeight: FontWeight.w500,),
        ),
      ),
      SizedBox(height: 40),
      Container(
        width: 2000,
        child: Text(
          'Blockchain offers a decentralized, immutable ledger that ensures transparency and trust in land transactions. Each transaction is securely recorded and timestamped, preventing tampering and fraud. Smart contracts can automate processes such as property transfers, title deeds issuance, and payment settlements, streamlining operations and reducing costs.',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 37,fontWeight: FontWeight.w500,),
        ),
      ),
      SizedBox(height: 40),
      Container(
        width: 2000,
        child: Text(
          'Moreover, blockchain-based land registries enhance accessibility, allowing stakeholders to verify property ownership and history in real-time, thereby reducing disputes and litigation. Additionally, by eliminating intermediaries and reducing bureaucracy, blockchain can accelerate property transactions, benefiting buyers, sellers, and governments alike.',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 37,fontWeight: FontWeight.w500,),
        ),
      ),
      SizedBox(height: 40),
      Container(
        width: 2000,
        child: Text(
          'Implementing blockchain in land registries requires collaboration between governments, technology providers, legal experts, and other stakeholders. By embracing blockchain\'s transformative potential, countries can establish robust, efficient land registry systems that promote economic growth, investment, and social development.',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 37,fontWeight: FontWeight.w500,),
        ),
      ),

      SizedBox(height: 80),
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      ElevatedButton(
        onPressed: () {
          Navigator.pop(context); // Navigate back to the previous page
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.black, // Background color
          minimumSize: Size(400, 100), // Set button size
          shape: RoundedRectangleBorder( // Set button shape
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          'Home Page',
          style: TextStyle(
            color: Colors.white, // Text color
            fontSize: 35, // Text size
          ),
        ),
      ),

      ElevatedButton(
        onPressed: () {
           Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AboutPage()),
          ); // Navigate back to the previous page
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.black, // Background color
          minimumSize: Size(400, 100), // Set button size
          shape: RoundedRectangleBorder( // Set button shape
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          'About Page',
          style: TextStyle(
            color: Colors.white, // Text color
            fontSize: 35, // Text size
          ),
        ),
      ),
    ],
  ),


    ],
  ),
),

          
        ],
      ),
    );
  }
}
