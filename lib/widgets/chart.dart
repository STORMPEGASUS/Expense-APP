// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, missing_return, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  chart(this.recentTransaction);
  List<Map<String, Object>> get groupedtransactionvalue {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalsum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekday.day &&
            recentTransaction[i].date.month == weekday.month &&
            recentTransaction[i].date.year == weekday.year) {
          totalsum += recentTransaction[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekday), 'amount': totalsum};
    }).reversed.toList();
  }

  double get totalspending {
    return groupedtransactionvalue.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedtransactionvalue.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: chartbar(
                data['day'],
                data['amount'],
                totalspending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalspending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
