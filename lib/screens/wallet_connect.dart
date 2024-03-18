import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:land_registration/providers/MetamaskProvider.dart';
import 'package:land_registration/constant/loadingScreen.dart';
import 'package:land_registration/screens/addLandInspector.dart';
import 'package:land_registration/screens/land_inspector_dashboard.dart';
import 'package:land_registration/screens/registerUser.dart';
import 'package:land_registration/screens/user_dashboard.dart';
import 'package:provider/provider.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import '../providers/LandRegisterModel.dart';
import '../constant/utils.dart';
import '../widget/header.dart';

class CheckPrivateKey extends StatefulWidget {
  final String val;
  const CheckPrivateKey({Key? key, required this.val}) : super(key: key);

  @override
  _CheckPrivateKeyState createState() => _CheckPrivateKeyState();
}

class _CheckPrivateKeyState extends State<CheckPrivateKey> {
  String privatekey = "";
  String errorMessage = "";
  bool isDesktop = false;
  double width = 590;
  bool _isObscure = true;
  double scrWidth = 0.0;
  double scrHeight = 0.0;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController keyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    scrWidth = MediaQuery.of(context).size.width;
    scrHeight = MediaQuery.of(context).size.height;
    var model = Provider.of<LandRegisterModel>(context);
    var model2 = Provider.of<MetaMaskProvider>(context);
    width = MediaQuery.of(context).size.width;

    if (width > 600) {
      isDesktop = true;
      width = 590;
    }
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          Stack(
            children: [
              const Material(
                elevation: 0,
                child: HeaderWidget(),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          if (widget.val == "UserLogin")
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("User Login",
                  style: TextStyle(
                      color: Color(0xFF333333),
                      fontFamily: 'AutourOne',
                      fontSize: 50,
                      fontWeight: FontWeight.w600)),
            )
          else if (widget.val == "LandInspector")
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Officials Login",
                  style: TextStyle(
                      color: Color(0xFF333333),
                      fontFamily: 'AutourOne',
                      fontSize: 50,
                      fontWeight: FontWeight.w600)),
            )
          else if (widget.val == "owner")
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Government Login",
                  style: TextStyle(
                      color: Color(0xFF333333),
                      fontFamily: 'AutourOne',
                      fontSize: 50,
                      fontWeight: FontWeight.w600)),
            ),
          SizedBox(
            height: 1,
          ),
          Container(
            //width: 500,
            padding: EdgeInsets.only(bottom:10),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  '/SSSS.png',
                  height: 1080.0,
                  width: 1020.0,
                ),
                SizedBox(
                  width: 0,
                ),
                Container(
                  padding : EdgeInsets.only(right:400),
                  color: Colors.black38,
                  width: 5,
                  height: 750,
                ),
                SizedBox(
                  width: 100,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        'You can enter private key of your wallet  "Or"  you connect Metamask wallet',
                        style: TextStyle(
                          fontSize: 35, // Adjust the font size as needed
                          fontWeight: FontWeight.bold, // Add font weight as needed
                          color: Colors.black87, // Add font color as needed
                          // fontFamily: 'YourFontFamily', // Uncomment and specify your custom font family if needed
                        ),
                      ),
                    SizedBox(
                        width: 1370,
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: keyController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter private key';
                                }
                                return null;
                              },
                              obscureText: _isObscure,
                              onChanged: (val) {
                                privatekey = val;
                              },
                              style: TextStyle(fontSize: 30), // Increase input text size
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 10), // Add padding only to the right
                                  child: MaterialButton(
                                    padding: const EdgeInsets.all(0),
                                    onPressed: () async {
                                      final clipPaste = await Clipboard.getData(Clipboard.kTextPlain);
                                          final pastedKey = clipPaste!.text!;
                                          setState(() {
                                            privatekey = pastedKey;
                                            keyController.text = pastedKey;
                                          });
                                      },
                                    child: const Text(
                                      "Paste",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 35,
                                      ),
                                    ),
                                  ),
                                ),
                                suffix: IconButton(
                                  iconSize: 40,
                                  constraints: const BoxConstraints.tightFor(height: 73, width: 85),
                                  padding: const EdgeInsets.all(0),
                                  icon: Icon(
                                    _isObscure ? Icons.visibility : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(),
                                labelText: 'Private Key',
                                hintText: 'Enter Your PrivateKey',
                                labelStyle: TextStyle(fontSize: 40), // Increase label text size
                                hintStyle: TextStyle(fontSize: 40), // Increase hint text size
                              ),
                            ),
                          ),
                        ),
                      ),

                    Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red,fontSize: 35),
                    ),
                    CustomButton(
                        'Continue',
                        isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  privateKey = privatekey;
                                  //print(privateKey);
                                  connectedWithMetamask = false;
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    await model.initiateSetup();

                                    if (widget.val == "owner") {
                                      bool temp = await model
                                          .isContractOwner(privatekey);
                                      if (temp == false) {
                                        setState(() {
                                          errorMessage =
                                              "You are not authrosied";
                                        });
                                      } else {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddLandInspector()));
                                      }
                                    } else if (widget.val == "RegisterUser") {
                                      bool temp =
                                          await model.isUserregistered();
                                      if (temp) {
                                        setState(() {
                                          errorMessage =
                                              "You already registered";
                                        });
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const RegisterUser()));
                                      }
                                    } else if (widget.val == "LandInspector") {
                                      bool temp = await model
                                          .isLandInspector(privatekey);
                                      if (temp == false) {
                                        setState(() {
                                          errorMessage =
                                              "You are not authrosied";
                                        });
                                      } else {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LandInspector()));
                                        // Navigator.of(context).pushNamed(
                                        //   '/landinspector',
                                        // );
                                      }
                                    } else if (widget.val == "UserLogin") {
                                      bool temp =
                                          await model.isUserregistered();
                                      if (temp == false) {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const RegisterUser()));
                                        // Navigator.of(context).pushNamed(
                                        //   '/registeruser',
                                        // );
                                      } else {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const UserDashBoard()));
                                        // Navigator.of(context).pushNamed(
                                        //   '/user',
                                        // );
                                      }
                                    }
                                  } catch (e) {
                                    print(e);
                                    showToast("Something Went Wrong",
                                        context: context,
                                        backgroundColor: Colors.red);
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              }
                            ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Or Click to connect Metamask',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              // Increase the font size here
                            ),
                          ),

                        Padding(
                          padding: const EdgeInsets.only(left: 20,top:5),
                          child: ElevatedButton(
                            onPressed: () async {
                              await model2.connect();
                              if (model2.isConnected && model2.isInOperatingChain) {
                                showToast("Connected",
                                    context: context, backgroundColor: Colors.green);

                                if (widget.val == "owner") {
                                  bool temp = await model2.isContractOwner();
                                  if (temp == false) {
                                    setState(() {
                                      errorMessage = "You are not authrosied";
                                    });
                                  } else {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AddLandInspector()));
                                  }
                                } else if (widget.val == "UserLogin") {
                                  bool temp = await model2.isUserRegistered();
                                  if (temp == false) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterUser()));
                                  } else {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const UserDashBoard()));
                                  }
                                } else if (widget.val == "LandInspector") {
                                  bool temp = await model2.isLandInspector();
                                  if (temp == false) {
                                    setState(() {
                                      errorMessage = "You are not authrosied";
                                    });
                                  } else {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LandInspector()));
                                  }
                                }
                                connectedWithMetamask = true;
                              } else if (model2.isConnected &&
                                  !model2.isInOperatingChain) {
                                showToast(
                                    "Wrong Netword connected,\nConnect Ropsten Testnet",
                                    context: context,
                                    backgroundColor: Colors.red);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 237, 164, 18)),
                            child: Image.network(
                                'https://i0.wp.com/kindalame.com/wp-content/uploads/2021/05/metamask-fox-wordmark-horizontal.png?fit=1549%2C480&ssl=1',
                                width: 550,
                                height: 180),
                          ),
                        ),
                        ],
                      ),
                    ),
                isLoading ? spinkitLoader : Container()
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
