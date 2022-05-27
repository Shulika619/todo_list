import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(
      {required this.label,
      required this.spendingAmoun,
      required this.spendingPctOfTotal,
      Key? key})
      : super(key: key);

  final String label;
  final double spendingAmoun;
  final double spendingPctOfTotal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 20,
            child: FittedBox(
                child: Text('\$${spendingAmoun.toStringAsFixed(0)}'))),
        SizedBox(
          width: 10,
          height: 60,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(20)),
            ),
            FractionallySizedBox(
              heightFactor: spendingPctOfTotal,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ]),
        ),
        const SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}
