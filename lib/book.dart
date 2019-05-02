import 'package:flutter/material.dart';
import 'descriptionTextWidget.dart';
import 'package:intl/intl.dart';

class BookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Page(),
    );
  }
}

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildImageSection(context),
              _buildMainInfoSection(),
            ],
          ),
          _buildSecondSection(),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Book title"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          tooltip: "Modify",
          color: Colors.white,
          onPressed: () => _requestModifyDialog(context),
        ),
      ],
    );
  }

  Widget _buildImageSection(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    double _width = data.size.width * 2 / 5;
    double _height = _width * (4 / 3);
    return GestureDetector(
        onTap: () => _showImage(context),
        child: Container(
          padding: const EdgeInsets.only(top: 8.0),
          width: _width,
          height: _height,
          child: Image.network(
              'http://goodcomicbooks.com/wp-content/uploads/2011/02/flspcv01.jpg'),
        ));
  }

  Widget _buildMainInfoSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Title",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('Titolo'),
          Row(children: <Widget>[
            Text(
              "Authors",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ]),
          Row(
            children: <Widget>[
              Text("Autore 1"),
            ],
          ),
          Row(
            children: <Widget>[
              Text("Autore 2"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescSection() {
    String string =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer laoreet scelerisque mollis. '
        'Duis pharetra ex eget turpis feugiat, in sodales massa condimentum. Nulla ac aliquam augue. Mauris purus magna, sodales in varius ac, '
        'condimentum sit amet felis. Morbi eget ipsum accumsan, placerat mauris quis, feugiat massa. Cras eu sem at mi sagittis malesuada. '
        'Vestibulum nec risus cursus, scelerisque massa iaculis, hendrerit nibh.';
    return new DescriptionTextWidget(text: string);
  }

  Widget _buildSecondSection() {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(),
            Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
            _buildDescSection(),
            _buildSecondaryInformation(),
          ],
        ));
  }

  Widget _buildSecondaryInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Publisher:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Editore"),
          ],
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Release date:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("DD/MM/YYYY"),
          ],
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Pages:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("00000000"),
          ],
        ),
      ],
    );
  }

  void _showImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            alignment: Alignment.topRight,
            children: <Widget>[
              Container(
                //padding: const EdgeInsets.all(24.0),
                child: Image.network(
                  'http://goodcomicbooks.com/wp-content/uploads/2011/02/flspcv01.jpg',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _requestModifyDialog(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new AddEntryDialog();
        },
        fullscreenDialog: true));
  }
}

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
      body: _buildBody(),
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
            labelText: "Titolo",
          ),
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
        time = dateTime == null
            ? new DateTime.now()
            : new TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
        super(key: key);

  final DateTime date;
  final TimeOfDay time;
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
          dateTimePicked.day, time.hour, time.minute));
    }
  }
}
