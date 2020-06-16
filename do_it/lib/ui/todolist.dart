import 'package:do_it/model/items.dart';
import 'package:do_it/util/database_client.dart';
import 'package:do_it/util/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final TextEditingController _textEditingController =
      new TextEditingController();

  @override
  void initState() {
    super.initState();
    _readItemList();
  }

  var db = new DatabaseHelper();
  final List<Items> _itemList = <Items>[];

  void _handleSubmitted(String text) async {
    _textEditingController.clear();
    Items items = new Items(text, dateFormatted());
    int savedItemId = await db.saveItem(items);
    Items addedItem = await db.getItem(savedItemId);
    // print('Saved Item\'s ID: $savedItemId');
    setState(() {
      _itemList.insert(0, addedItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
                padding: new EdgeInsets.all(8.0),
                reverse: false,
                itemCount: _itemList.length,
                itemBuilder: (_, int index) {
                  return new Card(
                    color: Colors.white10,
                    child: new ListTile(
                      onLongPress: () => _updateItem(_itemList[index], index),
                      title: _itemList[index],
                      trailing: new Listener(
                        key: new Key(_itemList[index].item),
                        child: new Icon(Icons.remove_circle, color: Colors.red),
                        onPointerDown: (pointerEvent) =>
                            _deleteItem(_itemList[index].id, index),
                      ),
                    ),
                  );
                }),
          ),
          new Divider(height: 1.0)
        ],
      ),
      backgroundColor: Colors.yellow[100],
      floatingActionButton: FloatingActionButton(
          tooltip: "Add Item",
          onPressed: _showFormDialog,
          child: ListTile(title: Icon(Icons.add))),
      bottomNavigationBar: BottomAppBar(
        color: Colors.yellowAccent,
        child: Container(height: 70.0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _showFormDialog() {
    var alert = AlertDialog(
      content: new Row(children: <Widget>[
        new Expanded(
            child: new TextField(
          controller: _textEditingController,
          autofocus: true,
          decoration: InputDecoration(
              labelText: "TASK",
              hintText: "eg. Practise Aptitude",
              icon: Icon(Icons.note_add)),
        )),
      ]),
      actions: <Widget>[
        new FlatButton(
            onPressed: () {
              _handleSubmitted(_textEditingController.text);
              _textEditingController.clear();
              Navigator.pop(context);
            },
            child: Text('SAVE')),
        new FlatButton(
            onPressed: () => Navigator.pop(context), child: Text('CANCEL'))
      ],
    );

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  _readItemList() async {
    List items = await db.getItems();
    items.forEach((item) {
      // Items item_s = Items.map(items);
      setState(() {
        _itemList.add(Items.map(item));
      });
    });
  }

  _deleteItem(int id, int index) async {
    await db.deleteItem(id);
    setState(() {
      _itemList.removeAt(index);
    });
  }

  _updateItem(Items itemList, int index) {
    var alert = AlertDialog(
      title: new Text('UPDATE TASK'),
      content: new Row(children: <Widget>[
        new Expanded(
            child: new TextField(
          controller: _textEditingController,
          autofocus: true,
          decoration: InputDecoration(
              labelText: "TASK",
              hintText: "eg. Practise Aptitude",
              icon: Icon(Icons.update)),
        )),
      ]),
      actions: <Widget>[
        new FlatButton(
            onPressed: () async {
              Items newUpdatedItem = Items.fromMap({
                "item": _textEditingController.text,
                "date": dateFormatted(),
                "id": itemList.id 
              });
              _handleSubmittedUpdate(index, itemList);
              await db.updateItem(newUpdatedItem);
              setState(() {
                _readItemList();
              });
              Navigator.pop(context);
            },
            child: Text('UPDATE')),
        new FlatButton(
            onPressed: () => Navigator.pop(context), child: Text('CANCEL'))
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  void _handleSubmittedUpdate(int index, Items itemList) {
    setState(() {
      _itemList.removeWhere((element){
        _itemList[index].item == itemList.item; 
      });
    });
  }
}
