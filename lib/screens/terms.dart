import 'package:flutter/material.dart';
import 'package:land_registration/screens/about_page.dart';
import '../widget/general_header.dart';


class TermsPage extends StatelessWidget {
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
        'Terms and Conditions',
        style: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w900,
        ),
      ),
      SizedBox(height: 20),
      Text(
        'By accessing and using the land registry services provided by this platform, you agree to the following terms and conditions:',
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.w900,
        ),
      ),
      SizedBox(height: 50),
      Container(
        width: 2000, // Use full width for the container
        child: Text(
          '1. Security: You understand and acknowledge that blockchain technology is utilized to maintain the land registry records. This technology ensures the security and integrity of the data by creating an immutable and tamper-proof ledger.',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 37,fontWeight: FontWeight.w500,),
        ),
      ),
      SizedBox(height: 40),
      Container(
        width: 2000,
        child: Text(
          '2. Transparency: You acknowledge that transactions recorded on the blockchain are transparent and accessible to authorized parties. All transactions related to property ownership and transfers are publicly visible and cannot be altered.',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 37,fontWeight: FontWeight.w500,),
        ),
      ),
      SizedBox(height: 40),
      Container(
        width: 2000,
        child: Text(
          '3. Compliance: You agree to comply with all applicable laws and regulations regarding property transactions and land registry procedures. You understand that any unauthorized or fraudulent activity may result in legal consequences.',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 37,fontWeight: FontWeight.w500,),
        ),
      ),
      SizedBox(height: 40),
      Container(
        width: 2000,
        child: Text(
          '4. Data Privacy: You consent to the collection and processing of your personal data for the purpose of land registry services. Your data will be handled in accordance with applicable data protection laws and regulations.',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 37,fontWeight: FontWeight.w500,),
        ),
      ),
      SizedBox(height: 40),
      Container(
        width: 2000,
        child: Text(
          '5. Dispute Resolution: In the event of any dispute arising from the use of land registry services, you agree to resolve the dispute through arbitration or other alternative dispute resolution mechanisms as provided by the platform.',
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
//Hello 