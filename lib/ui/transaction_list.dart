import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/models/transaction.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> userTransactions;
  final Function delTransaction;

  const TransactionList(this.userTransactions, this.delTransaction, {Key? key})
      : super(key: key);

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: widget.userTransactions.isEmpty
          ? Column(
              children: [
                Text("Нет расходов...",
                    style: Theme.of(context).textTheme.titleSmall),
                const Icon(
                  Icons.not_interested_outlined,
                  size: 35,
                  color: Colors.redAccent,
                )
              ],
            )
          : ListView.builder(
              itemCount: widget.userTransactions.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text(
                                "\$${widget.userTransactions[index].amount.toStringAsFixed(2)}")),
                      ),
                    ),
                    title: Text(
                      widget.userTransactions[index].title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    subtitle: Text(
                      DateFormat('dd/MM/yyyy')
                          .format(widget.userTransactions[index].date),
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                        onPressed: () => widget
                            .delTransaction(widget.userTransactions[index].id)),
                  ),
                );
              },
            ),
    );
  }
}



//
//                         decoration: BoxDecoration(
//                             border: Border.all(
//                                 color: Theme.of(context).primaryColor,
//                                 width: 2)),
//                         child: Text(

//                           style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Theme.of(context).primaryColor),
//  