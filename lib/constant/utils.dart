import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';

double ethToInr = 0;

bool connectedWithMetamask =
    false; //1->entered private key ; 2->connected with metamask

double width = 590;
bool isDesktop = false;
String privateKey = "";

ColorScheme customColorScheme = ColorScheme(
  primary: Color(0xFF2976c5),
  secondary: Color(0xFF205493),
  tertiary: Color(0xFF112E51),
  inversePrimary: Color(0x962d79c7),
  background: Color(0xFFFFFFFF),
  surface:Color(0xFF4AA564) ,
  error: Colors.redAccent,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onSurface: Colors.black,
  onBackground: Colors.black,
  onError: Colors.white,
  brightness: Brightness.light,
);

class LandInfo {
  final String area;
  final String landAddress;
  final String landPrice;
  //string allLongitude;
  final String propertyPID;
  final String physicalSurveyNumber;
  final String document;
  final bool isforSell;
  final String ownerAddress;
  final bool isLandVerified;

  LandInfo(
      this.area,
      this.landAddress,
      this.landPrice,
      this.propertyPID,
      this.physicalSurveyNumber,
      this.document,
      this.isforSell,
      this.ownerAddress,
      this.isLandVerified);
}

launchUrl(String url) async {
  url = url.replaceAll('.dweb.', '.nftstorage.');

  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    throw 'Could not launch $url';
  }
}

getEthToInr() async {
  try {
    String api =
        "https://api.nomics.com/v1/currencies/ticker?key=b081894c50331900a2c0e667a3c24c66482ebc8c&ids=ETH&interval=1h&convert=INR";
    var url = Uri.parse(api);
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    double priceInr = double.parse(data[0]['price']);
    ethToInr = double.parse(priceInr.toStringAsFixed(3));
    print("ETH to INR " + priceInr.toStringAsFixed(3));
  } catch (e) {
    print(e);
    ethToInr = 329172.649;
  }
}

Widget CustomButton(text, fun) => Container(
  constraints: const BoxConstraints(maxWidth: 450.0, minHeight: 80.0),
  margin: const EdgeInsets.only(top:80),
  child: ElevatedButton(
    onPressed: fun,
    style: ElevatedButton.styleFrom(
      primary: const Color.fromARGB(255, 22, 14, 2), // Change the background color here
    ),
    child: Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 35,
            color: Colors.white,
          ),
        ),
      ),
    ),
  ),
);

Widget CustomButton2(text, fun) => Container(
  // color: Color(0xFF8B4513),
      constraints: const BoxConstraints(maxWidth: 150.0, minHeight: 40.0),
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: customColorScheme.secondary, // foreground
        ),
        onPressed: fun,
        //color: Theme.of(context).accentColor,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
Widget CustomButton3(text, fun, color) => Container(
      constraints: const BoxConstraints(maxWidth: 210.0, minHeight: 100.0),
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: fun,
        style: ElevatedButton.styleFrom(primary: color),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            color: color,
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 30,
                color: color == Colors.white ? Colors.black : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );

class CustomAnimatedContainer extends StatefulWidget {
  final String text;
  final Function() fun;

  const CustomAnimatedContainer(this.text, this.fun);

  @override
  _CustomAnimatedContainerState createState() => _CustomAnimatedContainerState();
}

class _CustomAnimatedContainerState extends State<CustomAnimatedContainer> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
          });
        },
        child: GestureDetector(
          onTap: widget.fun,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 370,
            width: 350,
            decoration: BoxDecoration(
              color: isHovered ? Colors.grey.withOpacity(0.2) : Colors.white,
              border: Border.all(color: Colors.transparent, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(13)),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (widget.text == 'Govt Login')
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/contract_owner_icon.png',
                        width: 250.0,
                        height: 250.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                  if (widget.text == 'Land Inspector')
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/land_ins_icon2.png',
                        width: 250.0,
                        height: 250.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                  if (widget.text == 'User')
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/user_icon.png',
                        width: 250.0,
                        height: 250.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                  Text(
                    widget.text,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


Widget CustomTextFiled(text, label, size) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
  child: Row(
    children: [
      Text(
        "${label}: ",
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
      SizedBox(width: size),
      Container(
        padding: EdgeInsets.all(5),
        child: Text(
          text, // Increase the font size of the text parameter
          style: TextStyle(color: Colors.black, fontSize: 37), // Adjusted font size
        ),
        decoration: BoxDecoration(
          color: Color(0xfff5f0e1),
          borderRadius: BorderRadius.circular(2),
        ),
      )
    ],
  ),
);


Widget CustomTextFiled2(text, label) => Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        initialValue: text,
        style: const TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.all(12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
 // Increase the border radius
          ),
          labelText: label,
          labelStyle: const TextStyle(fontSize: 40),
          fillColor: const Color.fromARGB(141, 158, 158, 158),
          filled: true,
        ),

      ),
    );

class Menu {
  String title;
  IconData icon;
  double titleSize;
  double iconSize;

  Menu({
    required this.title,
    required this.icon,
    this.titleSize = 30, // Default title size
    this.iconSize = 30, // Default icon size
  });
}

void confirmDialog(
  msg,
  context,
  func,
) =>
    showCupertinoDialog(
  context: context,
  builder: (BuildContext ctx) {
    return CupertinoAlertDialog(
      title: Text('Please Confirm', style: TextStyle(fontSize: 28.0)),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Text(
          msg,
          style: TextStyle(
            fontSize: 28.0, // Adjust the font size as needed
          ),
        ),
      ),
      actions: [
        // The "Yes" button
        CupertinoDialogAction(
          onPressed: func,
          child: const Text('Yes',style: TextStyle(fontSize: 28),),
          isDefaultAction: true,
          isDestructiveAction: true,
        ),
        // The "No" button
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('No',style: TextStyle(fontSize: 28),),
          isDefaultAction: false,
          isDestructiveAction: false,
        )
      ],
    );
  }
);


pw.TableRow tableRow(text1, text2) =>
    pw.TableRow(children: [pw.Text(text1), pw.Text(text2)]);
pw.TableRow tableRowSizedBox() =>
    pw.TableRow(children: [pw.SizedBox(height: 14), pw.SizedBox(height: 14)]);
