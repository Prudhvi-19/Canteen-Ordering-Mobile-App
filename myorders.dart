import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/constants.dart';
import 'package:intl/intl.dart';

class MyOrders extends StatefulWidget {
  static String id = 'my_orders';

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('ORDERS')
            .where('userEmail', isEqualTo: userEmail.toString())
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
                return Card(
                  elevation: 5,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            DateFormat.yMMMd().add_jm().format(
                                (snapshot.data.documents[index].data['time'])
                                    .toDate()),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
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
                            snapshot.data.documents[index].data['orderStatus'],
                            style: TextStyle(
                                color: (snapshot.data.documents[index]
                                            .data['orderStatus'] ==
                                        'Order Received')
                                    ? Colors.blueAccent
                                    : (snapshot.data.documents[index]
                                                .data['orderStatus']) ==
                                            'Order Prepared'
                                        ? Colors.teal
                                        : (snapshot.data.documents[index]
                                                    .data['orderStatus']) ==
                                                'Order Paid'
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
                            snapshot.data.documents[index].data['totalCost']
                                .toString(),
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
                          rows: snapshot.data.documents[index].data['order']
                              .map<DataRow>(
                                ((element) => DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text(element['name'])),
                                        DataCell(
                                            Text(element['cost'].toString())),
                                        DataCell(Text(
                                            element['quantity'].toString())),
                                        DataCell(Text(
                                            element['itemtotal'].toString())),
                                      ],
                                    )),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
