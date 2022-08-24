import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/constants.dart';

class Categories extends StatefulWidget {
  _Categoriesstate createState() => _Categoriesstate();
}

class _Categoriesstate extends State<Categories> {
//  List<String> categs = [
//    "Milk shakes",
//    "Chicken curries",
//    "Veg curries",
//    "Cool drinks",
//    'Snakcs',
//    'Rices',
//    'Breads'
//  ];
//  RefreshController _refreshController =
//      RefreshController(initialRefresh: false);
//
//  static List<Items> _gettrending() {
//    var tcount = 4;
//    List<String> names = [
//      "Chicken fried rice",
//      "Chicken fingers",
//      "Chicken noodles",
//      "Chicken roll"
//    ];
//    List<String> images = ["cfr.jpg", "cf.jpg", "cn.jpg", "cr.jpg"];
//    List<int> prices = [50, 20, 50, 20];
//    List<Items> items = [];
//    for (var i = 0; i < tcount; i++) {
//      Items item = Items(names[i], images[i], prices[i]);
//      items.add(item);
//    }
//    return items;
//  }

//  Stream menu;

  getData() async {
    return await Firestore.instance
        .collection('menu')
//        .where('timestamp',
//            isGreaterThan: DateTime.now().subtract(Duration(days: 2)))
        .orderBy('cat') //, descending: true
        .snapshots();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    getData().then((results) {
//      setState(() {
//        menu = results;
//        print(menu);
//      });
//    });
  }

  bool notSelected = true;
  //List<Items> trending = _gettrending();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream:
            Firestore.instance.collection('menu').orderBy('cat').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black54,
              ),
            );
          }
          final items = snapshot.data.documents;
          List itemsList = [];
          List cats = [];
//          CollectionReference reference = Firestore.instance.collection('menu');
//          reference.snapshots().listen((querySnapshot) {
//            querySnapshot.documentChanges.forEach((change) {
//              // Do something with change
//              flag = false;
//            });
//          });
          for (var it in items) {
            final cat = it.data['cat'];
            cats.add(cat);
            final templist = it.data['items'];
            itemsList.add(templist);
//            for (var i in templist) {
//              final item = i['Name'];
//              final price = i['Price'];
//              final imageLink = i['Image'];
//              final itemCard = {
//                'name': item,
//                'cost': price,
//                'image': imageLink
//              };
//              itemsList.add(itemCard);
//            }
          }
          //print(itemsList);
//          if (flag == false) {
//            colorselected = List.generate(itemsList.length, (i) => false);
//            flag = true;
//          }
          final int intmes = cats.length;
          //This Loop is Problem if we add new data...... //TODO
          if (flag == false) {
            colorsSelected = [];
            for (int i = 0; i < intmes; i++) {
              List<bool> tempHere =
                  List.generate(itemsList[i].length, (i) => false);
              colorsSelected.add(tempHere);
            }
            flag = true;
          }
          //print(colorsSelected);

          return ListView.builder(
              itemCount: cats.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 5, bottom: 10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                cats[index],
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            )),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          height: MediaQuery.of(context).size.height * 0.37,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: itemsList[index].length,
                            itemBuilder: (BuildContext context, int ind) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 10),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 8,
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            spreadRadius: 2)
                                      ]),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.25,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight:
                                                      Radius.circular(10)),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      itemsList[index][ind]
                                                          ['Image']),
                                                  fit: BoxFit.cover))),
                                      Text(
                                        itemsList[index][ind]['Name'],
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            "Rs " +
                                                itemsList[index][ind]['Price'],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.032,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.13,
                                            child: FlatButton(
                                              child: colorsSelected[index][ind]
                                                  ? Icon(Icons.check)
                                                  : Icon(Icons.add),
                                              color: colorsSelected[index][ind]
                                                  ? Colors.green
                                                  : Color(0xFF4B9DFE),
                                              textColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              onPressed: () {
                                                var p = {
                                                  'name': itemsList[index][ind]
                                                      ['Name'],
                                                  'cost': itemsList[index][ind]
                                                      ['Price'],
                                                  'quantity': 1
                                                };
                                                colorsSelected[index][ind]
                                                    ? selectedItems.removeWhere(
                                                        (i) =>
                                                            i['name'] ==
                                                            p['name'])
                                                    : selectedItems.add(p);
                                                print(selectedItems);
                                                setState(() {
                                                  colorsSelected[index][ind] =
                                                      !colorsSelected[index]
                                                          [ind];
                                                });
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}

class Items {
  final String name;
  final String image;
  final int price;

  Items(this.name, this.image, this.price);
}
