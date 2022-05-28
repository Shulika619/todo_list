import 'dart:io';

import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'chart.dart';
import 'new_transaction.dart';
import 'transaction_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> userTransactions = [
    Transaction(
        id: "t1", title: "Сапоги", amount: 199.99, date: DateTime.now()),
    Transaction(
        id: "t2", title: "Футболка", amount: 95.55, date: DateTime.now()),
    Transaction(id: "t3", title: "Шапка", amount: 42.75, date: DateTime.now()),
  ];
  bool _isShowChart = false;

  List<Transaction> get lastSevenTransaction {
    return userTransactions.where((trans) {
      return trans.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: chosenDate);
    setState(() {
      userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(addFunc: _addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(title: const Text("Список покупок"), actions: [
      IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: const Icon(Icons.add))
    ]);
    final transactionListWidget = SizedBox(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.75,
        child: TransactionList(userTransactions, _deleteTransaction));
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!isLandScape)
                SizedBox(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.3,
                    child: Chart(lastSevenTransaction: lastSevenTransaction)),
              if (!isLandScape) transactionListWidget,
              if (isLandScape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Показать график'),
                    Switch.adaptive(
                        value: _isShowChart,
                        onChanged: (val) {
                          setState(() {
                            _isShowChart = val;
                          });
                        })
                  ],
                ),
              if (isLandScape)
                _isShowChart
                    ? SizedBox(
                        height: (mediaQuery.size.height -
                                appBar.preferredSize.height -
                                mediaQuery.padding.top) *
                            0.7,
                        child:
                            Chart(lastSevenTransaction: lastSevenTransaction))
                    : transactionListWidget
            ],
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: Platform.isIOS
          ? const SizedBox()
          : FloatingActionButton(
              onPressed: () => _startAddNewTransaction(context),
              child: const Icon(Icons.add),
            ),
    );
  }
}
