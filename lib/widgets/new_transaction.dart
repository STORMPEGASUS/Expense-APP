// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, sized_box_for_whitespace, unused_element

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Newtransaction extends StatefulWidget {
  final Function tx;
  Newtransaction(this.tx);

  @override
  State<Newtransaction> createState() => _NewtransactionState();
}

class _NewtransactionState extends State<Newtransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _selecteddate;
  //function for submiting data
  void _submit() {
    final enteredtitle = _titleController.text;
    final enteredamount = double.parse(_amountController.text);

    if (enteredtitle.isEmpty || enteredamount <= 0 || _selecteddate == null) {
      return;
    }

    widget.tx(enteredtitle, enteredamount, _selecteddate);

    Navigator.of(context).pop();
  }

  void _presentdatepicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickeddate) {
      if (pickeddate == null) {
        return;
      }

      setState(() {
        _selecteddate = pickeddate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 6,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submit(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submit(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selecteddate == null
                            ? 'No Date Chosen'
                            : 'Picked Date :${DateFormat.yMEd().format(_selecteddate)}',
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: _presentdatepicker,
                      child: Text(
                        'Choose date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _submit,
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                child: Text(
                  'Add Transaction',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
