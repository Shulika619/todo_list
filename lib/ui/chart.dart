import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/ui/chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.lastSevenTransaction}) : super(key: key);

  final List<Transaction> lastSevenTransaction;

  List<Map<String, Object>> get groupTransactionValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < lastSevenTransaction.length; i++) {
        if (lastSevenTransaction[i].date.day == weekDay.day &&
            lastSevenTransaction[i].date.month == weekDay.month &&
            lastSevenTransaction[i].date.year == weekDay.year) {
          totalSum += lastSevenTransaction[i].amount;
        }
      }
      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupTransactionValue.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactionValue.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: data['day'] as String,
                spendingAmoun: data['amount'] as double,
                spendingPctOfTotal: totalSpending == 0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
