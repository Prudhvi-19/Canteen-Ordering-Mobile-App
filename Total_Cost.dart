import 'package:flash_chat/screens/menupage.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CostDisplay extends StatefulWidget {
  static String id = 'cost_display';
  @override
  _CostDisplayState createState() => _CostDisplayState();
}

class _CostDisplayState extends State<CostDisplay> {
  final _firestore = Firestore.instance;
  var addedSuccsses = true;

  @override
  void dispose() {
    totalcost = 0;
    selectedItems = [];
//    for (int i = 0; i < colorsSelected.length; i++) {
//      for (int j = 0; j < colorsSelected[i].length; j++) {
//        colorsSelected[i][j] = false;
//      }
//    }
    // flag = false;

    super.dispose();
  }

  void addData() async {
    await _firestore.collection('ORDERS').add({
      'userEmail': userEmail,
      'userName': name,
      'userPhoneNumber': phoneNumber,
      'order': selectedItems,
      'totalCost': totalcost,
      'time': Timestamp.now(),
      'orderStatus': 'Order Received'
    }).then((onValue) {
      setState(() {
        addedSuccsses = false;
      });
    });
    //print(userDetails);
    print(userEmail);
  }

  void initState() {
    super.initState();
    for (var i = 0; i < selectedItems.length; i++) {
      selectedItems[i]['itemtotal'] = selectedItems[i]['quantity'].toDouble() *
          double.parse(selectedItems[i]['cost']);
      totalcost += selectedItems[i]['itemtotal'];
    }

    addData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              flag = false;
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Menupage.id, (Route<dynamic> route) => false);
            },
          ),
          title: Text('Order Details'),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: addedSuccsses
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.teal,
                ),
              )
            : ListView(
                children: <Widget>[
                  Container(
                    child: Card(
                      color: Colors.green,
                      elevation: 10,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            'ORDER CONFIRMED',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'TOTAL : ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                totalcost.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  FittedBox(child: DataTableWidget()),
                  Container(
                    color: Colors.white38,
                    child: FlatButton(
                      child: Text(
                        'MENU',
                        style: kSendButtonTextStyle,
                      ),
                      onPressed: () {
                        flag = false;
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Menupage.id, (Route<dynamic> route) => false);
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

class DataTableWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Item')),
        DataColumn(label: Text('Price')),
        DataColumn(label: Text('Quantity')),
        DataColumn(label: Text('Total')),
      ],
      rows: selectedItems
          .map(
            ((element) => DataRow(
                  cells: <DataCell>[
                    DataCell(Text(element['name'])),
                    DataCell(Text(element['cost'].toString())),
                    DataCell(Text(element['quantity'].toString())),
                    DataCell(Text(element['itemtotal'].toString())),
                  ],
                )),
          )
          .toList(),
    );
  }
}

//ListView.builder(
//itemCount: selectedItems.length,
//itemBuilder: (BuildContext context, int index) {
//var itemname = selectedItems[index][0];
//var itemprice = selectedItems[index][1];
//var itemquantity = selectedItems[index][2];
////                var itemtotal = itemprice * itemquantity;
////                totalcost += itemtotal;
//return Row(
//mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//children: <Widget>[
//Text(itemname),
//Text(itemprice.toString()),
//Text(itemquantity.toString()),
////                    Text(itemtotal.toString())
//],
//);
//},
//),
