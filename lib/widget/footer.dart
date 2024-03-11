import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:mahabhoomiweb/screens/home_page.dart';
// import 'package:mahabhoomiweb/constants/constants.dart';
import 'package:universal_html/html.dart' as html;
// import 'package:flutter_svg/flutter_svg.dart';
import '../constant/utils.dart';

class FooterWidget extends StatelessWidget {
  static final appContainer = kIsWeb
      ? html.window.document.querySelectorAll('flt-glass-pane')[0]
      : null;

  double scrHeight = 00.0;

  double scrWidth = 00.0;
  @override
  Widget build(BuildContext context) {
    scrWidth = MediaQuery.of(context).size.width;
    scrHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/landimg.jpg'),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
          color: Color(0xFF112E51),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Container(
          //       width: scrWidth/2-20,
          //       alignment: Alignment.topLeft,
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //       children: [
          //         Text('About Us :'),
          //         Text(' 1. Bhavesh Mahajan'),
          //         Text(' 2. Prashant Nane'),
          //         Text(' 3. Prof. Satish Kuchiwale'),
          //         // Text('About Us :'),
          //       ],
          //   ),
          //     ) ,
          //     Container(
          //       alignment: Alignment.topLeft,
          //       width: scrWidth/2-20,
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         Text('About Us :'),
          //         Text('About Us :'),
          //         Text('About Us :'),
          //         Text('About Us :'),
          //         Text('About Us :'),
          //       ],
          //   ),
          //     )
          //   ],
          // ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0, right: 1200),
                    child: SizedBox(
                      width: scrWidth / 3,
                      child: Flexible(
                        child: Text(
                          'About us',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 45.0,
                            fontWeight: FontWeight.w500,
                            color: customColorScheme.background,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0, right: 1200, bottom: 25),
                    child: SizedBox(
                      width: scrWidth / 3,
                      child: Flexible(
                        child: Text(
                          '    Land Registry is a blockchain-based solution for land registration developed by final year students, aiming to provide a secure, transparent, and efficient platform for land transactions. ',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 42.0,
                            color: customColorScheme.background,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //    Padding(
                  //      padding: const EdgeInsets.only(top:10.0),
                  //      child: Text(
                  //        ' 1. Bhavesh Mahajan',
                  //        style: TextStyle(
                  //          fontSize: 32.0,
                  //          color: Colors.grey[600],
                  //        ),
                  //      ),
                  //    ),
                  //    Text(
                  //        ' 2. Prashant Nane',
                  //        style: TextStyle(
                  //          fontSize: 32.0,
                  //          color: Colors.grey[600],
                  //        ),
                  //      ),
                  // Text(
                  //        ' 3. Prajyot Pawar',
                  //        style: TextStyle(
                  //          fontSize: 32.0,
                  //          color: Colors.grey[600],
                  //        ),
                  //      ),
                  //    Padding(
                  //      padding: const EdgeInsets.all(10.0),
                  //      child: Text(
                  //        ' Under Guidance of, \n \n 1. Prof. Satish Kuchiwale \n 2. Prof. Deepti Chandran',
                  //        style: TextStyle(
                  //          fontSize: 32.0,
                  //          color: Colors.grey[600],
                  //        ),
                  //      ),
                  //    ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Text(
                      'Contact Us :',
                      style: TextStyle(
                        fontSize: 45.0,
                        color: customColorScheme.background,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: InkWell(
                      onTap: () {
                        launchUrl("https://mail.google.com/mail/u/0/?view=cm&fs=1&tf=1&source=mailto&to=jerinnadar7@student.sfit.ac.in"); 
                      },
                      child: Text(
                        ' 1. Antony Jerin Nadar',
                        style: TextStyle(
                          fontSize: 37.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: InkWell(
                      onTap: () {
                        launchUrl("https://mail.google.com/mail/u/0/?view=cm&fs=1&tf=1&source=mailto&to=krunalpatel727602@student.sfit.ac.in"); 
                      },
                      child: Text(
                        ' 2. Krunal Patel',
                        style: TextStyle(
                          fontSize: 37.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: InkWell(
                      onTap: () {
                        launchUrl("https://mail.google.com/mail/u/0/?view=cm&fs=1&tf=1&source=mailto&to=singh.suraj1025@student.sfit.ac.in"); 
                      },
                      child: Text(
                        ' 3. Suryaprakash Singh',
                        style: TextStyle(
                          fontSize: 37.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: InkWell(
                      onTap: () {
                        launchUrl("https://mail.google.com/mail/u/0/?view=cm&fs=1&tf=1&source=mailto&to=adarshkay227@student.sfit.ac.in"); 
                      },
                      child: Text(
                        ' 4. Adarshkumar Vishwakarma',
                        style: TextStyle(
                          fontSize: 37.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                    child: InkWell(
                      onTap: () {
                        launchUrl("https://mail.google.com/mail/u/0/?view=cm&fs=1&tf=1&source=mailto&to=shamsuddinkhan@sfit.ac.in"); 
                      },
                      child: Text(
                        ' 5. Prof Shamsuddin Khan',
                        style: TextStyle(
                          fontSize: 37.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
