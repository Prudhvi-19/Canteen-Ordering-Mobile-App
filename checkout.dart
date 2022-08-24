import 'package:flash_chat/screens/Total_Cost.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../constants.dart';

class CheckOut extends StatefulWidget {
  static String id = 'checkout_screen';
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('CART'),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  var post = selectedItems[index];
                  var item = post['name'];
                  var price = post['cost'];
                  var quantity = post['quantity'];
                  return Card(
                    elevation: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          item,
                          style: TextStyle(fontSize: 18),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Rs.' + price.toString(),
                              style: TextStyle(fontSize: 15),
                            ),
                            ReusableCard(
                              cardChild: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        height: 25,
                                        width: 40,
                                        child: FlatButton(
                                          child: Icon(
                                            FontAwesomeIcons.minus,
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                          color: Colors.red,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          onPressed: () {
                                            if (post['quantity'] > 1) {
                                              setState(
                                                () {
                                                  post['quantity'] -= 1;
                                                  quantity = post['quantity'];
                                                  print(selectedItems);
                                                },
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        quantity.toString(),
                                        style: kNumTextStyle,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        height: 25,
                                        width: 40,
                                        child: FlatButton(
                                          child: Icon(FontAwesomeIcons.plus,
                                              color: Colors.white, size: 14),
                                          color: Colors.green,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          onPressed: () {
                                            setState(
                                              () {
                                                post['quantity'] += 1;
                                                quantity = post['quantity'];
                                                print(selectedItems);
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                itemCount: selectedItems.length,
              ),
            ),
            FlatButton(
              child: Text(
                'Place Order',
                style: kSendButtonTextStyle,
              ),
              onPressed: () {
                onAlertButtonsPressed(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

void onAlertButtonsPressed(context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Confirm Order",
    desc: "Press Confirm to place order.\n",
    buttons: [
      DialogButton(
        child: Text(
          "Confirm",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pushNamed(context, CostDisplay.id),
        color: Color.fromRGBO(0, 179, 134, 1.0),
      ),
      DialogButton(
        child: Text(
          "Check Again",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        gradient: LinearGradient(colors: [
          Color.fromRGBO(116, 116, 191, 1.0),
          Color.fromRGBO(52, 138, 199, 1.0)
        ]),
      )
    ],
  ).show();
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton({this.icon, this.onPressed});
  final IconData icon;
  Function onPressed;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon),
      shape: CircleBorder(),
      constraints: BoxConstraints.tightFor(
        width: 6.0,
        height: 6.0,
      ),
      //fillColor: Color(0xFF4C4F5E),
      onPressed: onPressed,
    );
  }
}

class ReusableCard extends StatelessWidget {
  ReusableCard({@required this.colour, this.cardChild, this.onPress});
  final Color colour;
  final cardChild;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

const kBottomContainerHeight = 80.0;
const kActiveCardcolour = Color(0xFF1D1E33);
const kBottomContainerColour = Color(0xFFEA1556);
const kInactiveCardcolour = Color(0xFF111328);

const kLabelTextStyle = TextStyle(
  fontSize: 18.0,
  color: Color(0xFF8D8E98),
);

const kNumTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w900,
);

const kLargeButtonTextStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);

const kTitleTextStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.bold,
);

const kResultTextStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
  color: Color(0xFF24D876),
);

const kBMITextStyle = TextStyle(
  fontSize: 100.0,
  fontWeight: FontWeight.bold,
);

const kBodyTextStyle = TextStyle(
  fontSize: 22.0,
);
