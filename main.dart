import 'package:flash_chat/screens/myorders.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/checkout.dart';
import 'screens/checkout.dart';
import 'screens/Total_Cost.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flash_chat/screens/homeScreen.dart';
import 'package:flash_chat/screens/menupage.dart';
import 'constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flash_chat/screens/Orders.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  notLogin = prefs.getBool('boolValue') ?? true;
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme:
            GoogleFonts.sourceSansProTextTheme(Theme.of(context).textTheme),
      ),
      initialRoute: Orders.id, //notLogin ? LoginPage.id : Menupage.id, //
      routes: {
        Orders.id: (context) => Orders(),
        Menupage.id: (context) => Menupage(),
        LoginPage.id: (context) => LoginPage(),
        MyOrders.id: (context) => MyOrders(),
        CheckOut.id: (context) => CheckOut(),
        CostDisplay.id: (context) => CostDisplay()
      },
    );
  }
}
