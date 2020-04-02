import 'dart:async';

import 'package:flutter/material.dart';

import '../../../business/main/history/history.dart';
import '../../../business/main/history/entry.dart';
import '../../../presentation/main/history/entry.dart';
import '../../../defines.dart';

class HistoryPage extends StatefulWidget {
  @override
  HistoryState createState() {
    return HistoryState();
  }
}

class HistoryState extends State<HistoryPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  final _historyEntries = <HistoryEntry>[];

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      child: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/wallpaper.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: _buildList(),
      ),
      onRefresh: () => _handleRefresh(),
      key: _refreshIndicatorKey,
      color: Color(ACCENT_PINK),
    );
  }

  Future<Null> _handleRefresh() async {
    List data = await History().getHistory();
    _buildHistoryEntries(data);
    _refreshIndicatorKey.currentState.show();
    setState(() {});
  }

  Widget _buildEmpty() {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
           new Card(
            child:Container(
              child: Column(
                children: <Widget>[
                  new Container(
                    child: new Text(
                      "\nNo Orders",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Color(ACCENT_PINK),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  new Container(
                    child: new Divider(
                      color: Color(ACCENT_PINK),
                    ),
                    margin: EdgeInsets.fromLTRB(32.0, 12.0, 32.0, 0.0),
                  ),
                  new Container(
                    child: Image(
                      image: AssetImage("assets/images/history/no_orders.png"),
                      height: 150,
                    ),
                    margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                  ),
                ],
              )
            ),
            margin: EdgeInsets.fromLTRB(64.0, 16.0, 64.0, 6.0),
            elevation: 3.0,
          ),
          new Card(
            child: new ListTile(
              title: Text(
                "Refresh",
                textAlign: TextAlign.center,
                style:TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )
              ),
              onTap: () async {
                _handleRefresh();
              },
            ),
            margin: EdgeInsets.fromLTRB(64.0, 6.0, 64.0, 12.0),
            elevation: 4.0,
            color: Color(ACCENT_PINK),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    if(_historyEntries.length == 0) {
      return _buildEmpty();
    }
    return ListView.builder(
      itemCount: _historyEntries.length,
      itemBuilder: (context, index) {
        final item = _historyEntries[index];
        return new Dismissible(
          child: new Card(
            child: new ListTile(
              leading: Icon(Icons.shopping_cart, color: Color(ACCENT_PINK)),
              title: Text(
                item.getQuantityFormatted(),
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(ACCENT_PINK),
                ),
              ),
              subtitle: Padding(
                child: Text(
                  item.getIdAndDatetime(),
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 8.0),
              ),
              trailing: Padding(
                child: item.getStatusIcon(),
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 6.0),
              ),
              contentPadding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 2.0),
              onTap: () {
                _enterDetails(item);
              },
            ),
            elevation: 3.0,
            margin: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 8.0),
          ),
          key: Key(item.getOrderId()),
          confirmDismiss: (direction) async {
            String status = _historyEntries[index].getStatus();
            if(status != "PROCESSING") {
              if(await _showDeleteDialog()) {
                if(await History().removeHistory(item.getOrderId())) {
                  return true;
                } else {
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Error: Try refreshing and try again')));
                }
              }
            } else {
              Scaffold.of(context).showSnackBar(SnackBar(content: Text('You cannot delete orders that are in process')));
            }
            return false;
          },
          onDismissed: (direction) async {
              _historyEntries.removeAt(index);
              setState(() {
                Scaffold.of(context).showSnackBar(SnackBar(content: Text('Order deleted')));
              });
          },
          background: Container(
            child: Icon(Icons.delete, color: Colors.white),
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(24.0),
            margin: EdgeInsets.symmetric(vertical: 6.0),
          ),
          direction: DismissDirection.endToStart,
        );
      },
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
    );
  }

  void _buildHistoryEntries(List data) {
    _historyEntries.clear();
    for(int i=0; i<data.length; i++) {
      _historyEntries.add(
        new HistoryEntry(
          data[i]['order_id'],
          data[i]['first_name'],
          data[i]['last_name'],
          data[i]['timestamp'],
          data[i]['detail']['base'],
          data[i]['detail']['icing'],
          data[i]['detail']['deco'],
          data[i]['detail']['other_request'],
          data[i]['amount'],
          data[i]['status']
        )
      );
    }
  }

  void _enterDetails(HistoryEntry entry) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EntryPage(details: entry),
      )
    );
    if(result != null) {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text("$result")));
      _handleRefresh();
    }
  }

  Future<bool> _showDeleteDialog() async {
    bool flag = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Order?'),
          content: Text('Do you want to delete this order?\n\nDeleting this order will also remove the ability to easily reorder with this configuration!'),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                'Cancel',
                style: TextStyle(
                  color: Color(ACCENT_COLOUR),
                ),
              ),
              onPressed: () {
                flag = false;
                Navigator.of(context).pop();
              }
            ),
            new FlatButton(
              child: new Text(
                'Delete Order',
                style: TextStyle(
                  color: Color(ACCENT_PINK),
                ),
              ),
              onPressed: () {
                flag = true;
                Navigator.of(context).pop();
              }
            ),
          ],
        );
      }
    );
    return flag;
  }
}
