import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:land_registration/screens/terms.dart';
import 'package:land_registration/widget/footer.dart';
import 'package:sizer/sizer.dart';

import '../constant/utils.dart';
import '../screens/learn_more.dart';
import '../widget/header.dart';
import '../widget/homePageDesc.dart';
// import 'package:adaptive_navbar/adaptive_navbar.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  double scrWidth =0.0;
  double scrHeight =0.0;


  final ScrollController _scrollController = ScrollController();

  GlobalKey _componentKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    scrWidth = MediaQuery.of(context).size.width;
    scrHeight = MediaQuery.of(context).size.height;

    // final sw = MediaQuery.of(context).size.width;
    width = MediaQuery.of(context).size.width;
    if (kIsWeb){
      isDesktop = true;
    }

    if (scrWidth < 600) {
      isDesktop = false;
    }


    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Top Header
            const Material(
              elevation: 0,
              child: HeaderWidget(),
            ),

            // Expanded(
            //   child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: <Widget>[
            //     const LeftDescription(),
            //     Flexible(
            //       child: Container(
            //         width: width,
            //         height: height,
            //         child: SvgPicture.asset(
            //           'assets/in.svg',
            //           //color: Color.fromARGB(255, 255, 169, 98),
            //           height: 20.0,
            //           width: 20.0,
            //           allowDrawingOutsideViewBox: true,
            //         ),
            //       ),
            //     )
            //   ],
            // ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 200, top: 0, right: 0),
            //
            // ),
            getMiddleSizedBox(),
            // Card(
            //   shape:StadiumBorder()  ,
            //   color: Colors.white,
            //   child:Icon( Icons.keyboard_arrow_down_outlined, color:customColorScheme.tertiary),
            // ),
            SizedBox(
              child: Container(
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(10)),
                // ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFfafafa), Color(0xFF2976c5)],
                  ),
                ),
                child: Column (
                  children: [
                    Container(
                      padding: EdgeInsets.all(50),
                      width: scrWidth,
                      child:
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Login as',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(232, 0, 0, 0),
                            fontSize: isDesktop ? 45 : 35,
                          ),
                        ),
                      ),
                    ),
                   Container(
                      width: scrWidth,
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 400, // Adjust the width as needed
                            height: 400, // Adjust the height as needed
                            child: CustomAnimatedContainer('Govt Login', () {
                              Navigator.of(context).pushNamed(
                                '/login',
                                arguments: "owner",
                              );
                            }),
                          ),
                          SizedBox(width: 70), // Horizontal spacing between login tiles
                          SizedBox(
                            width: 400, // Adjust the width as needed
                            height: 400, // Adjust the height as needed
                            child: CustomAnimatedContainer('Land Inspector', () {
                              Navigator.of(context).pushNamed(
                                '/login',
                                arguments: "LandInspector",
                              );
                            }),
                          ),
                          SizedBox(width: 70), // Horizontal spacing between login tiles
                          SizedBox(
                            width: 400, // Adjust the width as needed
                            height: 400, // Adjust the height as needed
                            child: CustomAnimatedContainer('User', () {
                              Navigator.of(context).pushNamed(
                                '/login',
                                arguments: "UserLogin",
                              );
                            }),
                          ),
                        ],
                      ),
                    ),

                    FooterWidget(),
                  ],
                ),
              ),
            )

            // const SizedBox(
            //   height: 100,
            // ),
          ],
        ),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  getMiddleSizedBox() {
    return Container(
      height:scrHeight-200,
      child: Row(
        children: [
          Container(
            width: scrWidth * 0.5,
            height: scrWidth * 0.5,
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[


                // title
                const FittedBox(
                    child:
                    Padding(
                      padding: EdgeInsets.only(left: 100,bottom: 50),
                      child: Text(
                        'Land Registry Application',
                        style: TextStyle(
                          fontFamily: 'AutourOne',
                          fontWeight: FontWeight.bold,
                          fontSize: 65,
                          // letterSpacing: 1.627907,
                        ),
                      ),


                    )

                ),
                // Description

                // const SizedBox(
                //   height,
                // ),
                // const SizedBox(height: 26),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: <Widget>[
                    // button
                    InkWell(
                        onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LearnMorePage()),
                        );
                      },
                        child: Container(
                          alignment: Alignment.center,
                          width: scrWidth * 0.3,
                          height: 70,
                          child: Center(
                            child: Text(
                              "Learn More",
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: customColorScheme.secondary,
                            borderRadius: BorderRadius.circular(scrWidth / 20 * 0.2),
                          ),
                        ),
                      ),

                    //
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TermsPage()),
                        );
                      },
                      child: MouseRegion(
                        onHover: (PointerHoverEvent evt) {
                          LeftDescription.appContainer?.style.cursor = 'pointer';
                        },
                        onExit: (PointerExitEvent evt) {
                          LeftDescription.appContainer?.style.cursor = 'default';
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(" Terms and Conditions ",
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: 'Montserrat',
                                    color: customColorScheme.secondary,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: 1,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 100,
                // )
              ],
            ),
          ),
          Padding(
      padding: EdgeInsets.only(top: 150.0,left: 10), // Adjust the top padding as needed
      child: Container(
        width: scrWidth * 0.49,
        height: scrWidth * 0.89,
        child: SvgPicture.asset(
          'assets/result.svg',
          height: 30.0,
          width: 50.0,
          allowDrawingOutsideViewBox: true,
        ),
      ),
    )

        ],
      ),
    );
  }
}
