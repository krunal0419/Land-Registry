import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:land_registration/constant/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import '../providers/LandRegisterModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mapbox_search/mapbox_search.dart';
import '../constant/utils.dart';
import '../providers/MetamaskProvider.dart';
import '../widget/header_user.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  late String name, age, city, aadharNumber, panNumber, document, email;

  double width = 590;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false, isAdded = false;
  String docuName = "";
  late PlatformFile documentFile;
  String cid = "", docUrl = "";

  double scrWidth = 0.0;
  double scrHeight = 0.0;

  List<MapBoxPlace> predictions = [];
  late PlacesSearch placesSearch;
  final FocusNode _focusNode = FocusNode();
  late OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  TextEditingController addressController = TextEditingController();

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
        builder: (context) => Positioned(
              width: 540,
              child: CompositedTransformFollower(
                link: this._layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, 40 + 5.0),
                child: Material(
                  elevation: 4.0,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: List.generate(
                        predictions.length,
                        (index) => ListTile(
                              title:
                                  Text(predictions[index].placeName.toString()),
                              onTap: () {
                                addressController.text =
                                    predictions[index].placeName.toString();

                                setState(() {});
                                _overlayEntry.remove();
                                _overlayEntry.dispose();
                              },
                            )),
                  ),
                ),
              ),
            ));
  }

  Future<void> autocomplete(value) async {
    List<MapBoxPlace>? res = await placesSearch.getPlaces(value);
    if (res != null) predictions = res;
    setState(() {});
    // print(res);
    // print(res![0].placeName);
    // print(res![0].geometry!.coordinates);
    // print(res![0]);
  }

  @override
  void initState() {
    placesSearch = PlacesSearch(
      apiKey: mapBoxApiKey,
      limit: 10,
    );

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = this._createOverlayEntry();
        Overlay.of(context)!.insert(_overlayEntry);
      } else {
        _overlayEntry.remove();
      }
    });
    super.initState();
  }

  pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf'],
    );

    if (result != null) {
      docuName = result.files.single.name;
      documentFile = result.files.first;
    }
    setState(() {});
  }

  Future<bool> uploadDocument() async {
    String url = "https://api.nft.storage/upload";
    var header = {"Authorization": "Bearer $nftStorageApiKey"};

    if (docuName != "") {
      try {
        final response = await http.post(Uri.parse(url),
            headers: header, body: documentFile.bytes);
        var data = jsonDecode(response.body);
        //print(data);
        if (data['ok']) {
          cid = data["value"]["cid"];
          docUrl = "https://" + cid + ".ipfs.dweb.link";
          print(docUrl);
          return true;
        }
      } catch (e) {
        print(e);
        showToast("Something went wrong,while document uploading",
            context: context, backgroundColor: Colors.red);
      }
    } else {
      showToast("Choose Document",
          context: context, backgroundColor: Colors.red);
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    scrWidth = MediaQuery.of(context).size.width;
    scrHeight = MediaQuery.of(context).size.height;
    var model = Provider.of<LandRegisterModel>(context);
    var model2 = Provider.of<MetaMaskProvider>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 196, 129),
      body: Stack(
        children: [
          Positioned(
            width: scrWidth,
            top: scrHeight * 0.18,
            height: 1300,
            child: Center(
              child: Material(
                color: Colors.transparent,
                shadowColor: Colors.red,
                elevation: 10,
                child: Container(
                  height: scrHeight * 0.80,
                  decoration: BoxDecoration(
                  gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [ Color.fromARGB(255, 231, 219, 182), Colors.white]
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: const Color.fromARGB(255, 94, 93, 88)),
                  ),
                  
                  padding: const EdgeInsets.all(15),
                  width: 1000,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      // scrollDirection: Axis.vertical,
                      // shrinkWrap: true,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 70, bottom: 40),
                          child: Text(
                            'Registration Screen',
                            style: TextStyle(
                                fontSize: 60,
                                fontFamily: 'AutourOne',
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(153, 0, 0, 0)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left:50,right:50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "Name: ",
                                      style: TextStyle(
                                        fontSize: 40, // Change the font size as needed
                                        // Add any other text styles here if desired
                                      ),
                                    ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Container(
                                        width: 500,
                                        child: TextFormField(
                                          style: const TextStyle(
                                            fontSize: 35,
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            return null;
                                          },
                                          onChanged: (val) {
                                            name = val;
                                          },
                                          decoration: const InputDecoration(
                                            isDense: true, // Added this
                                            contentPadding: EdgeInsets.all(12),
                                            border: OutlineInputBorder(),
                                            // labelText: 'Full Name',
                                            hintText: 'Enter Name',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "Age: ",
                                      style: TextStyle(
                                        fontSize: 40, // Change the font size as needed
                                        // Add an other text styles here if desired
                                      ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        width: 500,
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter age';
                                            }
                                            return null;
                                          },
                                          style: const TextStyle(
                                            fontSize: 35,
                                          ),
                                          onChanged: (val) {
                                            age = val;
                                          },
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]'))
                                          ],
                                          decoration: const InputDecoration(
                                            isDense: true, // Added this
                                            contentPadding: EdgeInsets.all(12),
                                            border: OutlineInputBorder(),
                                            labelText: 'Age',
                                            labelStyle: TextStyle(fontSize: 35),
                                            hintText: 'Enter Age',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ),

                              Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "Address: ",
                                      style: TextStyle(
                                        fontSize: 40, // Change the font size as needed
                                        // Add an other text styles here if desired
                                      ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: CompositedTransformTarget(
                                        link: this._layerLink,
                                        child: Container(
                                          width: 500,
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter some text';
                                              }
                                              return null;
                                            },
                                            style: const TextStyle(
                                              fontSize: 35,
                                            ),

                                            controller: addressController,
                                            onChanged: (value) {
                                              if (value.isNotEmpty) {
                                                autocomplete(value);
                                                _overlayEntry.remove();
                                                _overlayEntry =
                                                    this._createOverlayEntry();
                                                Overlay.of(context)!
                                                    .insert(_overlayEntry);
                                              } else {
                                                if (predictions.length > 0 &&
                                                    mounted) {
                                                  setState(() {
                                                    predictions = [];
                                                  });
                                                }
                                              }
                                            },
                                            focusNode: this._focusNode,
                                            //obscureText: true,
                                            decoration: const InputDecoration(
                                              isDense: true, // Added this
                                              contentPadding:
                                                  EdgeInsets.all(12),
                                              border: OutlineInputBorder(),
                                              labelText: 'Address',
                                              labelStyle: TextStyle(fontSize: 35),
                                              hintText: 'Enter Address',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ),

                              Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "Aadhar: ",
                                      style: TextStyle(
                                        fontSize: 40, // Change the font size as needed
                                        // Add an other text styles here if desired
                                      ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        width: 500,
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter Aadhar number';
                                            } else if (value.length != 12)
                                              return 'Please enter Valid Aadhar number';
                                            return null;
                                          },
                                          //maxLength: 12,
                                          style: const TextStyle(
                                            fontSize: 35,
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]'))
                                          ],
                                          onChanged: (val) {
                                            aadharNumber = val;
                                          },
                                          //obscureText: true,
                                          decoration: const InputDecoration(
                                            isDense: true, // Added this
                                            contentPadding: EdgeInsets.all(12),
                                            border: OutlineInputBorder(),
                                            labelText: 'Aadhar',
                                            labelStyle: TextStyle(fontSize: 35),
                                            hintText: 'Enter Aadhar Number',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ),

                              Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "Pan: ",
                                      style: TextStyle(
                                        fontSize: 40, // Change the font size as needed
                                        // Add an other text styles here if desired
                                      ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        width: 500,
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter Pan Number';
                                            } else if (value.length != 10)
                                              return 'Please enter Valid Pan number';
                                            return null;
                                          },
                                          style: const TextStyle(
                                            fontSize: 35,
                                          ),
                                          //maxLength: 10,

                                          onChanged: (val) {
                                            panNumber = val;
                                          },
                                          //obscureText: true,
                                          decoration: const InputDecoration(
                                            isDense: true, // Added this
                                            contentPadding: EdgeInsets.all(12),
                                            border: OutlineInputBorder(),
                                            labelText: 'Pan',
                                            labelStyle: TextStyle(fontSize: 35),
                                            hintText: 'Enter Pan Number',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ),
                              
                              Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "Email: ",
                                      style: TextStyle(
                                        fontSize: 40, // Change the font size as needed
                                        // Add an other text styles here if desired
                                      ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Container(
                                        width: 500,
                                        child: TextFormField(
                                          validator: (value) {
                                            RegExp regex = RegExp(
                                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                                r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                                r"{0,253}[a-zA-Z0-9])?)*$");
                                            if (!regex.hasMatch(value!) ||
                                                value == null)
                                              return 'Enter a valid email address';
                                            else
                                              return null;
                                          },
                                          style: const TextStyle(
                                            fontSize: 35,
                                          ),
                                          onChanged: (val) {
                                            email = val;
                                          },
                                          //obscureText: true,
                                          decoration: const InputDecoration(
                                            isDense: true, // Added this
                                            contentPadding: EdgeInsets.all(12),
                                            border: OutlineInputBorder(),
                                            labelText: 'Email',
                                            labelStyle: TextStyle(fontSize: 35),
                                            hintText: 'Enter Email',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ),

                              Padding(
                                    padding: const EdgeInsets.only(right:32,top:15),
                                    child: Row(
                                      children: [
                                        MaterialButton(
                                          color: Colors.black,
                                          onPressed: pickDocument,
                                          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 27), // Adjust padding to increase button size
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10), // Set the border radius here
                                          ),
                                          child: Text(
                                            'Upload Document',
                                            style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white, // Set the font color to white
                                            ),
                                          ),
                                        ),

                                        Padding(
                                        padding: const EdgeInsets.only(left:40),
                                        child: Text(
                                          docuName,
                                          style: TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black, // Set the font color to white
                                          ),
                                        ),
                                        ),

                                      ],
                                    ),
                                  ),

                              isAdded
                                  ? CustomButton('Contine to Login', () {
                                      Navigator.pop(context);
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => UserDashBoard()));
                                      Navigator.of(context).pushNamed(
                                        '/user',
                                      );
                                    })
                                  : CustomButton(
                                      'Add',
                                      isLoading
                                          ? null
                                          : () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                try {
                                                  SmartDialog.showLoading(
                                                      msg:
                                                          "Uploading Document");
                                                  bool isFileupload =
                                                      await uploadDocument();
                                                  SmartDialog.dismiss();
                                                  if (isFileupload) {
                                                    if (connectedWithMetamask)
                                                      await model2.registerUser(
                                                          name,
                                                          age,
                                                          addressController
                                                              .text,
                                                          aadharNumber,
                                                          panNumber,
                                                          docUrl,
                                                          email);
                                                    else
                                                      await model.registerUser(
                                                          name,
                                                          age,
                                                          addressController
                                                              .text,
                                                          aadharNumber,
                                                          panNumber,
                                                          docUrl,
                                                          email);
                                                    showToast(
                                                        "Successfully Registered",
                                                        context: context,
                                                        backgroundColor:
                                                            Colors.green);
                                                    isAdded = true;
                                                  }
                                                } catch (e) {
                                                  print(e);
                                                  showToast(
                                                      "Something Went Wrong",
                                                      context: context,
                                                      backgroundColor:
                                                          Colors.red);
                                                }

                                                setState(() {
                                                  isLoading = false;
                                                });
                                              }

                                              //model.makePaymentTestFun();
                                            }),
                              isLoading
                                  ? const CircularProgressIndicator()
                                  : Container()
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            height: scrHeight * 0.10,
            width: scrWidth,
            child: Material(
              elevation: 0,
              child: HeaderUserWidget(),
            ),
          ),
          Positioned(
            height: scrHeight * 0.17,
            width: scrWidth,
            child: Material(
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.all(0),
                child: HeaderUserWidget(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
