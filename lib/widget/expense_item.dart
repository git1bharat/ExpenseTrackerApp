import 'package:expense_app/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(
    this.expenseList, {
    super.key,
  });
  final Expense expenseList;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              Text(expenseList.title),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text('\$${expenseList.amount.toStringAsFixed(2)}'),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(categoryIcons[expenseList.category]),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(expenseList.formettedDate)
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
