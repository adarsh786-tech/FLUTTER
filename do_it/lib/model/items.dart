import 'package:flutter/material.dart';

class Items extends StatelessWidget {
  String _item;
  String _date;
  int _id;
  Items(this._item, this._date);
  Items.map(dynamic obj) {
    this._item = obj["item"];
    this._date = obj["date"];
    this._id = obj["id"];
  }

  String get item => _item;
  String get date => _date;
  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["item"] = _item;
    map["date"] = _date;

    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Items.fromMap(Map<String, dynamic> map) {
    this._item = map["item"];
    this._date = map["date"];
    this._id = map["id"];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                _item,
                style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.9),
              ),
              new Container(
                  child: Text(
                "Created on: $_date",
                style: TextStyle(
                    color: Colors.grey[300],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 13.5),
              ))
            ],
          ),
        ],
      ),
    );
  }
}
