import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEntryDialog extends StatefulWidget {
  @override
  AddEntryDialogState createState() => new AddEntryDialogState();
}

class AddEntryDialogState extends State<AddEntryDialog> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('New entry'),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            tooltip: "Done",
            color: Colors.white,
            onPressed: () => null,
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        TextField(
          controller: null,
          decoration: InputDecoration(
            hintText: 'Titolo',
            labelText: 'Title',
          ),
        ),
        Row(
          children: <Widget>[
            Text('Authors'),
            IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: () => null,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Autore1",
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => null,
            ),
          ],
        ),
        Text('Description'),
        TextFormField(
          decoration: InputDecoration(
            hintText:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer laoreet scelerisque mollis. '
                'Duis pharetra ex eget turpis feugiat, in sodales massa condimentum. Nulla ac aliquam augue. Mauris purus magna, sodales in varius ac, '
                'condimentum sit amet felis. Morbi eget ipsum accumsan, placerat mauris quis, feugiat massa. Cras eu sem at mi sagittis malesuada. '
                'Vestibulum nec risus cursus, scelerisque massa iaculis, hendrerit nibh.',
          ),
          maxLines: 10,
          keyboardType: TextInputType.multiline,
        ),
        Text('Release date'),
        ListTile(
          leading: new Icon(Icons.today, color: Colors.grey[500]),
          title: new DateTimeItem(
            dateTime: DateTime.now(),
            onChanged: (dateTime) => setState(() => null),
          ),
        ),
      ],
    );
  }
}

class DateTimeItem extends StatelessWidget {
  DateTimeItem({Key key, DateTime dateTime, @required this.onChanged})
      : assert(onChanged != null),
        date = dateTime == null
            ? new DateTime.now()
            : new DateTime(dateTime.year, dateTime.month, dateTime.day),
        super(key: key);

  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new InkWell(
            onTap: (() => _showDatePicker(context)),
            child: new Padding(
                padding: new EdgeInsets.symmetric(vertical: 8.0),
                child: new Text(new DateFormat('EEEE, MMMM d').format(date))),
          ),
        ),
      ],
    );
  }

  Future _showDatePicker(BuildContext context) async {
    DateTime dateTimePicked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: date.subtract(const Duration(days: 20000)),
        lastDate: new DateTime.now());

    if (dateTimePicked != null) {
      onChanged(new DateTime(dateTimePicked.year, dateTimePicked.month,
          dateTimePicked.day));
    }
  }
}
