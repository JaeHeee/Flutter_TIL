import 'package:flutter/material.dart';

class DismissibleWidget extends StatefulWidget {
  static const routeName = '/dismissible-widget';
  DismissibleWidget({Key? key}) : super(key: key);

  @override
  _DismissibleWidgetState createState() => _DismissibleWidgetState();
}

class _DismissibleWidgetState extends State<DismissibleWidget> {
  final List<String> _items = List.generate(30, (index) => 'Item ${index + 1}');
  final List<String> _savedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dismissible Widget'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) => Dismissible(
          key: Key(_items[index]),
          onDismissed: (direction) => _onDismissed(direction, index),
          confirmDismiss: (direction) =>
              _confirmDismiss(direction, context, index),
          background: _buildBackgroundWidget,
          secondaryBackground: _buildSecondBackgroundWidget,
          child: _buildListItem(index),
        ),
      ),
    );
  }

  Future<bool> _confirmDismiss(
    DismissDirection direction,
    BuildContext context,
    int index,
  ) {
    if (direction == DismissDirection.endToStart) {
      return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Are you sure?'),
              content: Text('Now I am deleting ${_items[index]}'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    return Navigator.of(context).pop(false);
                  },
                  child: const Text('CANCEL'),
                ),
                ElevatedButton(
                  onPressed: () {
                    return Navigator.of(context).pop(true);
                  },
                  child: const Text('DELETE'),
                ),
              ],
            );
          }).then((value) => Future.value(value));
    } else if (direction == DismissDirection.startToEnd) {
      return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Are you sure?'),
              content: Text('Now saving ${_items[index]}'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    return Navigator.of(context).pop(false);
                  },
                  child: const Text('CANCEL'),
                ),
                ElevatedButton(
                  onPressed: () {
                    return Navigator.of(context).pop(true);
                  },
                  child: const Text('SAVE'),
                ),
              ],
            );
          }).then((value) => Future.value(value));
      ;
    }
    return Future.value(false);
  }

  void _onDismissed(DismissDirection direction, int index) {
    if (direction == DismissDirection.endToStart) {
      setState(() {
        _items.removeAt(index);
      });
    }
    if (direction == DismissDirection.startToEnd) {
      setState(() {
        _savedItems.add(_items[index]);
        _items.removeAt(index);
      });
    }
  }

  Card _buildListItem(int index) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 8,
      child: ListTile(
        leading: CircleAvatar(
          child: Text('${_items[index].split(' ')[1]}'),
        ),
        title: Text(
          _items[index],
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Container get _buildSecondBackgroundWidget => Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          size: 36,
          color: Colors.white,
        ),
      );

  Container get _buildBackgroundWidget => Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.green,
        alignment: Alignment.centerLeft,
        child: const Icon(
          Icons.save,
          size: 36,
          color: Colors.white,
        ),
      );
}
