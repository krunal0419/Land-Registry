import 'package:flutter/material.dart';

import '../constant/constants.dart';
import '../constant/utils.dart';


Widget landWid(isverified, area, address, price, isForSell, makeforSellFun) =>
    Container(
      padding: const EdgeInsets.all(15),
      width: 400,
      height: 400,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.white10,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
          color: Colors.white10,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 290,
            width: 450,
            color: Color.fromARGB(255, 89, 161, 255),
            child: Image.asset(
              'assets/landimg.jpg',
              fit: BoxFit.fill,
            ),
          ),
          // Image(
          //
          //   image: NetworkImage(
          //       'http://www.kerloguenursinghome.com/wp-content/uploads/2019/12/19038526ce9f8be4a8dba148da99ff77.jpg'),
          // ),
          const SizedBox(
            height: 25,
          ),
          Text(
            isverified ? 'Verified' : 'Not Yet Verified',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.blueAccent,fontSize: 35),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            area + ' Sq.Ft',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Location : ' + address,
            style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Price : ' + price,
            style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
          ),
          // Text(
          //   'Property Tax:' + propertytax(price).toString(),
          //   style:
          //       const TextStyle(fontSize: 10, color: Colors.deepOrangeAccent),
          // ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              isForSell
                  ? MaterialButton(
                      color: Colors.redAccent,
                      onPressed: null,
                      child: const Text(
                        'On Sell',
                         style:  TextStyle(fontSize: 30)
                        )
                    )  
                  : MaterialButton(
                    color: Colors.redAccent,
                    onPressed: isverified ? makeforSellFun : null,
                    child: isverified
                    ? const Text(
                        'Make it for Sell',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white, // Set text color to white
                          fontWeight: FontWeight.bold, // Make text bold
                        ),
                      )
                    : Container(), // Empty container when user is not verified
              ),

                    SizedBox(width: 90),
            
               MaterialButton(
                color: Colors.blueAccent,
                onPressed: () {},
                child: const Text(
                'View Details',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white, // Set text color to white
                  fontWeight: FontWeight.bold, // Make text bold
                ),
              ),
              )
              
            ],
          )
        ],
      ),
    );



Widget landWid2(isverified, area, address, price, isMyLand, isForSell,
        sendRequestFun, viewDetailsFun) =>
    Container(
      padding: const EdgeInsets.all(15),
      width: 400,
      height: 400,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.white10,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
          color: Colors.white10,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 290,
            width: 590,
            color: Color.fromARGB(255, 89, 175, 255),
            child: Image.asset(
              'assets/landimg.jpg',
              fit: BoxFit.fill,
            ),
          ),
          // Image(
          //
          //   image: NetworkImage(
          //       'http://www.kerloguenursinghome.com/wp-content/uploads/2019/12/19038526ce9f8be4a8dba148da99ff77.jpg'),
          // ),
          const SizedBox(
            height: 20,
          ),
          Text(
            isverified ? 'Verified' : 'Not Yet Verified',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.blueAccent,fontSize: 35),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            area + ' Sq.Ft',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Location : ' + address,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Price:' + price,
            style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
          ),
          // Text(
          //   'Property Tax:' + propertytax(price).toString(),
          //   style:
          //       const TextStyle(fontSize: 15, color: Colors.deepOrangeAccent),
          // ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              isMyLand
                  ? MaterialButton(
                      color: Colors.redAccent,
                      onPressed: null,
                      child: const Text(
                      'Send request to buy',
                      style: TextStyle(
                        fontSize: 28,
                        color: Color.fromARGB(255, 4, 0, 0), // Set text color to white
                        fontWeight: FontWeight.bold, // Make text bold
                      ),
                    ),
                    )
                  : MaterialButton(
                      color: Colors.redAccent,
                      onPressed: isForSell ? sendRequestFun : null,
                      child: isForSell
                          ? Text('Send Request To Buy',style: TextStyle(fontSize: 28.0))
                          : Text(
                              'Not for sell yet',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold, // Increase the font size here as desired
                              ),
                            ),
                    ),

                    SizedBox(width: 90),
              MaterialButton(
                color: Colors.blueAccent,
                onPressed: viewDetailsFun,
                child: const Text(
                'View Details',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white, // Set text color to white
                  fontWeight: FontWeight.bold, // Make text bold
                ),
              ),
              )
            ],
          )
        ],
      ),
    );

// double propertytax(price) {
//   double priced = double.parse(price);
//   double value = priced * rate;
//   return value;
// }

Widget landWid3(
        owneraddress, area, address, price, propertyPID, surveyNumber, docu) =>
    Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      width: width,
      height: 420,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color(0xfff5f0e1),
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
          color: Colors.white10,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Land Info",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
          const SizedBox(
            height: 13,
          ),
          Row(
            children: const [
              Text(
                'Verified',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 35),
              ),
              Icon(
                Icons.verified,
                color: Colors.green,
              )
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
              children: [
                Text(
                  'Owner Address :',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 38), // Adjust padding as needed
                Text(
                  '$owneraddress',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          // textCustom("", owneraddress),
          const SizedBox(
            height: 35,
          ),
         Row(
              children: [
                Text(
                  'Area :',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 225), // Adjust padding as needed
                Text(
                  '$area' + 'Sqft',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          const SizedBox(
            height: 35,
          ),
          Row(
              children: [
                Text(
                  'PID :',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width:247), // Adjust padding as needed
                Text(
                  '$propertyPID',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          const SizedBox(
            height: 35,
          ),
          Row(
              children: [
                Text(
                  'Survey No. :',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 112), // Adjust padding as needed
                Text(
                  '$surveyNumber',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          const SizedBox(
            height: 35,
          ),
          Row(
              children: [
                Text(
                  'Address :',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 150), // Adjust padding as needed
                Text(
                  '$address',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          const SizedBox(
            height: 35,
          ),
          Row(
              children: [
                Text(
                  'Price :',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 198), // Adjust padding as needed
                Text(
                  ' $price',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),

          // textCustom("Property Tax : ", propertytax(price)),
          const SizedBox(
            height: 43,
          ),

         Padding(
         padding: const EdgeInsets.only(right:100),
         child: TextButton(
            onPressed: () {
              launchUrl(docu.toString());
            },
            child: const Text(
              '  View Document',
              style: TextStyle(color: Colors.blue,fontSize: 40),
            ),
          ),
         ),
        ],
      ),
    );

Widget textCustom(text1, text2) => Row(children: [
      Text(
        text1,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Text(
        text2,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 20),
      ),
    ]);
