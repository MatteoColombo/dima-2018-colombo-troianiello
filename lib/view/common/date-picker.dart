import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///Given a [DateTime], allows to show it formatted and to edit with a new date.
class DateTimeItem extends StatelessWidget {
  ///The date to show and edit.
  final DateTime date;

  ///Callbacks that report that the value of this [date] has change.
  final ValueChanged<DateTime> onChanged;

  ///Constructor of DateTimeItem.
  ///
  ///[onChanged] is required and must be not null. If [dateTime] is null,
  ///this variable is initialized by [DateTime.now()].
  ///[key] is an identifier for this [Widget].
  DateTimeItem({Key key, DateTime dateTime, @required this.onChanged})
      : assert(onChanged != null),
        date = dateTime == null
            ? DateTime.now()
            : DateTime(dateTime.year, dateTime.month, dateTime.day),
        super(key: key);
  //Shows this [date] and creates a buttom, that opens a dialog to edit [date].
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: (() => _showDatePicker(context)),
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(DateFormat('EEEE,d MMMM y').format(date))),
          ),
        ),
      ],
    );
  }

  ///Shows a dialog, that allows to edit [date].
  Future _showDatePicker(BuildContext context) async {
    DateTime dateTimePicked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: date.subtract(const Duration(days: 20000)),
        lastDate: DateTime.now());
    if (dateTimePicked != null) {
      onChanged(DateTime(
          dateTimePicked.year, dateTimePicked.month, dateTimePicked.day));
    }
  }
}
