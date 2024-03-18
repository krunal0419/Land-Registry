import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:land_registration/providers/LandRegisterModel.dart';
import 'package:land_registration/widget/menu_item_tile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../constant/utils.dart';
import '../providers/MetamaskProvider.dart';
import '../widget/header_user.dart';

class AddLandInspector extends StatefulWidget {
  const AddLandInspector({Key? key}) : super(key: key);

  @override
  _AddLandInspectorState createState() => _AddLandInspectorState();
}

class _AddLandInspectorState extends State<AddLandInspector> {
  late String address, name, age, desig, city, newaddress;
  var model, model2;
  double scrWidth = 0.0;
  double scrHeight = 0.0;
  double width = 600;
  int screen = 0;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isFirstTimeLoad = true;
  dynamic userCount = -1, landCount = -1;

  List<Menu> menuItems = [
    Menu(title: 'Add Land Inspector', icon: Icons.person_add,titleSize:70,iconSize: 70),
    Menu(title: 'All Land Inspectors', icon: Icons.group),
    Menu(title: 'Change Contract Owner', icon: Icons.change_circle),
    Menu(title: 'Logout', icon: Icons.logout),
  ];

  List<List<dynamic>> allLandInspectorInfo = [];
  getUserCount() async {
    if (connectedWithMetamask) {
      userCount = await model2.userCount();
      landCount = await model2.landCount();
    } else {
      userCount = await model.userCount();
      landCount = await model.landCount();
    }
    isFirstTimeLoad = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    scrWidth = MediaQuery.of(context).size.width;
    scrHeight = MediaQuery.of(context).size.height;

    model = Provider.of<LandRegisterModel>(context);
    model2 = Provider.of<MetaMaskProvider>(context);
    if (isFirstTimeLoad) {
      getUserCount();
    }
    if (kIsWeb) {
      isDesktop = true;
    }

    if (scrWidth < 600) {
      isDesktop = false;
    }
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          width: scrWidth,
          top: scrHeight * 0.16,
          height: scrHeight * 0.90,
          child: Scaffold(
            backgroundColor: Colors.white,
            key: _scaffoldKey,
            // appBar: AppBar(
            //   centerTitle: false,
            //   backgroundColor: const Color(0xFF272D34),
            //   leading: !isDesktop
            //       ? Container()
            //       : GestureDetector(
            //           child: const Padding(
            //             padding: EdgeInsets.all(8.0),
            //             child: Icon(
            //               Icons.menu,
            //               color: Colors.black,
            //             ), //AnimatedIcon(icon: AnimatedIcons.menu_arrow,progress: _animationController,),
            //           ),
            //           onTap: () {
            //             _scaffoldKey.currentState!.openDrawer();
            //           },
            //         ),

            // ),
            drawer: drawer2(),
            drawerScrimColor: Colors.transparent,
            body: Row(
              children: [
                isDesktop ? drawer2() : Container(),
                if (screen == 0)
                  addLandInspector()
                else if (screen == 1)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      child: landInspectorList(),
                    ),
                  )
                else if (screen == 2)
                  changeContractOwner()
              ],
            ),
          ),
        ),
        Positioned(
          height: scrHeight * 0.16,
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
    );
  }

getLandInspectorInfo() async {
    setState(() {
      isLoading = true;
    });
    List<dynamic> landList;
    if (connectedWithMetamask)
      landList = await model2.allLandInspectorList();
    else
      landList = await model.allLandInspectorList();

    List<List<dynamic>> info = [];
    List<dynamic> temp;
    for (int i = 0; i < landList.length; i++) {
      if (connectedWithMetamask)
        temp = await model2.landInspectorInfo(landList[i]);
      else
        temp = await model.landInspectorInfo(landList[i]);
      info.add(temp);
    }
    allLandInspectorInfo = info;
    setState(() {
      isLoading = false;
    });
    print(info);
  }

  Widget landInspectorList() {
  if (isLoading) return const Center(child: CircularProgressIndicator());
  return Padding(
    padding: const EdgeInsets.only(bottom: 20.0), // Add bottom padding here
    child: ListView.builder(
      itemCount:
          allLandInspectorInfo == null ? 1 : allLandInspectorInfo.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Column(
            children: [
              const Divider(
                height: 15,
                thickness: 2,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0), // Adjust the left padding as needed
                child: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        '#',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                        'LandInspector\'s Address',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      flex: 5,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      flex: 3,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'City',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Remove',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      flex: 2,
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 15,
                thickness: 2,
                color: Colors.black,     
              )
            ],
          );
        }
        index -= 1;
        List<dynamic> data = allLandInspectorInfo[index];
        return Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        data[1].toString(),
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                      ),
                    ),
                    flex: 5,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        data[2].toString(),
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                      ),
                    ),
                    flex: 3,
                  ),

                Expanded(
                    child: Center(
                      child: Text(
                        data[5].toString(),
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                      ),
                    ),
                    flex: 2,
                  ),
                  
                  Expanded(
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: () async {
                          confirmDialog('Are you sure to remove?', context, () async {
                            SmartDialog.showLoading();
                            if (connectedWithMetamask)
                              await model2.removeLandInspector(data[1]);
                            else
                              await model.removeLandInspector(data[1]);
                            Navigator.pop(context);
                            await getLandInspectorInfo();
                            SmartDialog.dismiss();
                          });
                        },
                        child: const Text(
                          'Remove',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    flex: 2,
                  ),
                ],
              ),
            ),
            Divider(
              height: 25, // Adjust the height of the divider as needed
              thickness: 1, // Adjust the thickness of the divider as needed
              color: Colors.black, // Adjust the color of the divider as needed
            ),
          ],
        );

      },
    ),
  );
}


  Widget changeContractOwner() {
  return Center(
    widthFactor: isDesktop ? 3.5 : 1,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 300.0), // Adjust top padding as needed
      child: SizedBox(
        height: 600, // Adjust the height as needed
        child: Center(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Color.fromARGB(255, 221, 220, 216), // Set the background color of the Card
            child: Container(
              width: 700,
              padding: const EdgeInsets.all(70),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Change Contract Owner",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
                      textAlign: TextAlign.center, // Align text to center
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        newaddress = val;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Address',
                        labelStyle: TextStyle(fontSize: 30),
                        hintText: 'Enter new Contract Owner Address',
                        hintStyle: TextStyle(fontSize: 30),
                      ),
                    ),
                    SizedBox(height: 150),
                    SizedBox(
                        height: 80, // Adjust the height as needed
                        width: double.infinity, // Set the width to match the parent's width
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    if (connectedWithMetamask)
                                      await model2.changeContractOwner(newaddress);
                                    else
                                      await model.changeContractOwner(newaddress);
                                    showToast("Successfully Changed",
                                        context: context,
                                        backgroundColor: Colors.green);
                                  } catch (e) {
                                    print(e);
                                    showToast("Something Went Wrong",
                                        context: context, backgroundColor: Colors.red);
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                },
                          child: Text(
                            'Change',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ),

                    SizedBox(height: 20),
                    isLoading ? const CircularProgressIndicator() : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}



 Widget addLandInspector() {
  return Padding(
    padding: const EdgeInsets.only(top:50,left:900,bottom: 200), // Adjust padding as needed
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.amber),
        color: const Color(0xfff5f0e1),
      ),
      child: SizedBox(
        width: isDesktop ? 875 : scrWidth * 0.9, // Adjust the width as needed
        height: 1300,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Text(
                    'Add Land Inspector',
                    style: TextStyle(
                      color: Colors.brown,
                      fontSize: 75,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(
                  width: isDesktop ? 750 : scrWidth * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Address: ', style: TextStyle(fontSize: 38)),
                      Flexible(
                        child: Container(
                          width: isDesktop ? 475 : scrWidth * 0.8,
                          child: Padding(
                            padding: const EdgeInsets.all(25),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onChanged: (val) {
                                address = val;
                              },
                              style: TextStyle(fontSize: 35),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Address',
                                hintText:'Enter Land Inspector Address(0xc5aEabE793B923981fc401bb8da620FDAa45ea2B)',
                                labelStyle: TextStyle(fontSize: 30),
                                hintStyle: TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
               	SizedBox(
                width: isDesktop ? 750 : scrWidth * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Name:', style: TextStyle(fontSize: 38)),
                    Flexible(
                      child: Container(
                        width: isDesktop ? 475 : scrWidth * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              name = val;
                            },
                            style: TextStyle(fontSize: 35), // Set text size here
                            //obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name',
                              hintText: 'Enter Name',
                              labelStyle: TextStyle(fontSize: 30),
                              hintStyle: TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

                SizedBox(
                  width: isDesktop ? 750 : scrWidth * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Age:', style: TextStyle(fontSize: 38)),
                      Flexible(
                        child: Container(
                          width: isDesktop ? 475 : scrWidth * 0.8,
                        
                          child: Padding(
                            padding: const EdgeInsets.all(25),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onChanged: (val) {
                                age = val;
                              },
                              //obscureText: true,
                              style: TextStyle(fontSize: 35),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Age',
                                hintText: 'Enter Age',
                                labelStyle: TextStyle(fontSize: 30),
                                hintStyle: TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: isDesktop ? 750 : scrWidth * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Designation:', style: TextStyle(fontSize: 38)),
                      Flexible(
                        child: Container(
                          width: isDesktop ? 475 : scrWidth * 0.8,
                        
                          child: Padding(
                            padding: const EdgeInsets.all(25),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onChanged: (val) {
                                desig = val;
                              },
                              //obscureText: true,
                              style: TextStyle(fontSize: 35),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Designation',
                                hintText: 'Enter Designation',
                                labelStyle: TextStyle(fontSize: 30),
                                hintStyle: TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: isDesktop ? 750 : scrWidth * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('City :', style: TextStyle(fontSize: 38)),
                      Flexible(
                        child: Container(
                          width: isDesktop ? 475 : scrWidth * 0.8,
                        
                          child: Padding(
                            padding: const EdgeInsets.all(25),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onChanged: (val) {
                                city = val;
                              },
                              //obscureText: true,
                              style: TextStyle(fontSize: 35),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'City',
                                hintText: 'Enter City',
                                labelStyle: TextStyle(fontSize: 30),
                                hintStyle: TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: CustomButton(
                    'Add',
                    isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                if (connectedWithMetamask)
                                  await model2.addLandInspector(
                                      address, name, age, desig, city);
                                else
                                  await model.addLandInspector(
                                      address, name, age, desig, city);
                                showToast("Successfully Added",
                                    context: context,
                                    backgroundColor: Colors.green);
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
                          },
                  ),
                ),
                isLoading 
                    ? const CircularProgressIndicator()
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}


  Widget drawer2() {
    
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.transparent, spreadRadius: 2)
        ],
        color: Colors.transparent,
      ),
      width: 600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            width: 30,
            height: 30,
          ),
          const Icon(
            Icons.person,
            size: 190,
          ),
          const SizedBox(
            height: 0,
            width: 30,
          ),
          const Text('Contract Owner',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 45,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, counter) {
                return const Divider(
                  height: 2,
                );
              },
              itemCount: menuItems.length,
              itemBuilder: (BuildContext context, int index) {
                return MenuItemTile(
                  title: menuItems[index].title,
                  icon: menuItems[index].icon,
                  titleSize: menuItems[index].titleSize,
                  iconSize: menuItems[index].iconSize,
                  isSelected: screen == index,
                  onTap: () {
                    if (index == 3) {
                      Navigator.pop(context);
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => home_page()));
                      Navigator.of(context).pushNamed(
                        '/',
                      );
                    }
                    if (index == 1) getLandInspectorInfo();

                    setState(() {
                      screen = index;
                    });
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
