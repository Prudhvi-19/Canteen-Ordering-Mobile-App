import 'package:flash_chat/screens/homeScreen.dart';
import 'package:flash_chat/screens/myorders.dart';
import 'package:flutter/material.dart';
import './categories.dart';
import 'package:flash_chat/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'checkout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menupage extends StatefulWidget {
  static String id = 'menu_page';
  @override
  _Menupagestate createState() => _Menupagestate();
}

class _Menupagestate extends State<Menupage> {
  final _auth = FirebaseAuth.instance;

  void getUserData() async {
    final FirebaseUser user = await _auth.currentUser();
    userEmail = user.email.toString();
    var userDetails = Firestore.instance
        .collection('USERS')
        .where('email', isEqualTo: userEmail)
        .snapshots()
        .listen((onData) {
      name = onData.documents[0]['name'];
      phoneNumber = onData.documents[0]['phone'];
      print(name);
      print(phoneNumber);
    });
    print(userDetails);
  }

  void _logoutUser() async {
    try {
      await _auth.signOut().then((value) {
        print('loggedout');
        totalcost = 0;
        selectedItems = [];
//      for (int i = 0; i < colorsSelected.length; i++) {
//        for (int j = 0; j < colorsSelected[i].length; j++) {
//          colorsSelected[i][j] = false;
//        }
//      }
        flag = false;
        userEmail = null;
        name = null;
        notLogin = true;
        phoneNumber = null;
        addBoolToSF(true);
        Navigator.of(context).pushNamedAndRemoveUntil(
            LoginPage.id, (Route<dynamic> route) => false);
      });
    } catch (e) {
      print(e.toString());
    }
  }

//  @override
//  void dispose() {
//    // TODO: implement dispose
//    super.dispose();
//  }

  addBoolToSF(bool inputtbool) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('boolValue', inputtbool);
  }

  void initState() {
    super.initState();
    getUserData();
    addBoolToSF(false);
  }

  //List<Item> trending = _gettrending();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.teal, size: 40),
        title: Text(
          ' MENU',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Icon(
              Icons.shopping_cart,
              color: Colors.teal,
              size: 30,
            ),
            onPressed: () {
              if (selectedItems.length == 0) {
                onAlertButtonPressed(context);
              } else {
                Navigator.pushNamed(context, CheckOut.id);
              }
            },
          )
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    userEmail,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    phoneNumber,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  )
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
            ),
            ListTile(
              title: Text(
                'My Orders',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pushNamed(context, MyOrders.id);
              },
            ),
            ListTile(
              title: Text(
                'Log Out',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
              onTap: _logoutUser,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(children: <Widget>[SizedBox(height: 20), Categories()]),
      ),
    );
  }
}

class Item {
  final String name;
  final String image;
  final int price;

  Item(this.name, this.image, this.price);
}

void onAlertButtonPressed(context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "SELECT ITEMS",
    desc: "Select atleast One Item to Check out.",
    buttons: [
      DialogButton(
        child: Text(
          "Okay",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}
