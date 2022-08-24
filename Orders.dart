import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Orders extends StatefulWidget {
  static String id = 'Order_Main';

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(
            'ADMIN ORDERS',
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            indicatorColor: Colors.limeAccent,
            indicatorWeight: 5,
            tabs: [
              Tab(
                text: 'Received',
              ),
              Tab(
                text: 'Paid',
              ),
              Tab(
                text: 'Prepared',
              ),
              Tab(
                text: 'Delivered',
              )
            ],
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          children: <Widget>[
            StreamBuilder(
              stream: Firestore.instance
                  .collection('ORDERS')
                  .where('orderStatus', isEqualTo: 'Order Received')
                  .orderBy('time')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black54,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          OrderCard(
                            tempCost: snapshot
                                .data.documents[index].data['totalCost']
                                .toString(),
                            tempStatus: snapshot
                                .data.documents[index].data['orderStatus'],
                            tempArray:
                                snapshot.data.documents[index].data['order'],
                            tempTime:
                                snapshot.data.documents[index].data['time'],
                            tempName:
                                snapshot.data.documents[index].data['userName'],
                            tempEmail: snapshot
                                .data.documents[index].data['userEmail'],
                            tempPhone: snapshot
                                .data.documents[index].data['userPhoneNumber'],
                          ),
                          FlatButton(
                            child: Text(
                              'Paid',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            color: Colors.greenAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            onPressed: () {
                              var a = snapshot.data.documents[index].documentID;
                              Firestore.instance
                                  .collection('ORDERS')
                                  .document(a)
                                  .updateData({'orderStatus': 'Order Paid'});
                              print(a.toString());
                            },
                          )
                        ],
                      );
                    },
                  );
                }
              },
            ),
            StreamBuilder(
              stream: Firestore.instance
                  .collection('ORDERS')
                  .where('orderStatus', isEqualTo: 'Order Paid')
                  .orderBy('time')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black54,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          OrderCard(
                            tempCost: snapshot
                                .data.documents[index].data['totalCost']
                                .toString(),
                            tempStatus: snapshot
                                .data.documents[index].data['orderStatus'],
                            tempArray:
                                snapshot.data.documents[index].data['order'],
                            tempTime:
                                snapshot.data.documents[index].data['time'],
                            tempName:
                                snapshot.data.documents[index].data['userName'],
                            tempEmail: snapshot
                                .data.documents[index].data['userEmail'],
                            tempPhone: snapshot
                                .data.documents[index].data['userPhoneNumber'],
                          ),
                          FlatButton(
                            child: Text(
                              'Prepared',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            color: Colors.teal,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            onPressed: () {
                              var a = snapshot.data.documents[index].documentID;
                              Firestore.instance
                                  .collection('ORDERS')
                                  .document(a)
                                  .updateData(
                                      {'orderStatus': 'Order Prepared'});
                              print(a.toString());
                            },
                          )
                        ],
                      );
                    },
                  );
                }
              },
            ),
            StreamBuilder(
              stream: Firestore.instance
                  .collection('ORDERS')
                  .where('orderStatus', isEqualTo: 'Order Prepared')
                  .orderBy('time')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black54,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          OrderCard(
                            tempCost: snapshot
                                .data.documents[index].data['totalCost']
                                .toString(),
                            tempStatus: snapshot
                                .data.documents[index].data['orderStatus'],
                            tempArray:
                                snapshot.data.documents[index].data['order'],
                            tempTime:
                                snapshot.data.documents[index].data['time'],
                            tempName:
                                snapshot.data.documents[index].data['userName'],
                            tempEmail: snapshot
                                .data.documents[index].data['userEmail'],
                            tempPhone: snapshot
                                .data.documents[index].data['userPhoneNumber'],
                          ),
                          FlatButton(
                            child: Text(
                              'Delivered',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            onPressed: () {
                              var a = snapshot.data.documents[index].documentID;
                              Firestore.instance
                                  .collection('ORDERS')
                                  .document(a)
                                  .updateData(
                                      {'orderStatus': 'Order Delivered'});
                              print(a.toString());
                            },
                          )
                        ],
                      );
                    },
                  );
                }
              },
            ),
            StreamBuilder(
              stream: Firestore.instance
                  .collection('ORDERS')
                  .where('orderStatus', isEqualTo: 'Order Delivered')
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black54,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return OrderCard(
                        tempCost: snapshot
                            .data.documents[index].data['totalCost']
                            .toString(),
                        tempStatus:
                            snapshot.data.documents[index].data['orderStatus'],
                        tempArray: snapshot.data.documents[index].data['order'],
                        tempTime: snapshot.data.documents[index].data['time'],
                        tempName:
                            snapshot.data.documents[index].data['userName'],
                        tempEmail:
                            snapshot.data.documents[index].data['userEmail'],
                        tempPhone: snapshot
                            .data.documents[index].data['userPhoneNumber'],
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  //TODO USERNAME,PHONE,MAIL
  OrderCard(
      {this.tempCost,
      this.tempStatus,
      this.tempTime,
      this.tempArray,
      this.tempEmail,
      this.tempName,
      this.tempPhone});
  final String tempCost;
  final String tempStatus;
  final tempTime;
  final List tempArray;
  final String tempName;
  final String tempEmail;
  final String tempPhone;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                DateFormat.yMMMd().add_jm().format((tempTime).toDate()),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Text(
            tempName,
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
            tempPhone,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          Text(
            tempEmail,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          Row(
            children: <Widget>[
              Text(
                'Order Status : ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              Text(
                tempStatus,
                style: TextStyle(
                    color: (tempStatus == 'Order Received')
                        ? Colors.blueAccent
                        : (tempStatus) == 'Order Prepared'
                            ? Colors.teal
                            : (tempStatus) == 'Order Paid'
                                ? Colors.greenAccent
                                : Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                'Total Price : ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              Text(
                tempCost,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          FittedBox(
            child: DataTable(
              columns: [
                DataColumn(label: Text('Item')),
                DataColumn(label: Text('Price')),
                DataColumn(label: Text('Quantity')),
                DataColumn(label: Text('Total')),
              ],
              rows: tempArray
                  .map<DataRow>(
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
            ),
          ),
        ],
      ),
    );
  }
}

//   //Orders Array

//  //Total Cost

//  //Order Status
