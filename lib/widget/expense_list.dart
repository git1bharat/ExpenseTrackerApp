import 'package:expense_app/model/expense.dart';
import 'package:expense_app/widget/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});
  final void Function(Expense expense) onRemoveExpense;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return Dismissible(
            key: ValueKey(expenses[index]),
            onDismissed: (direction) {
              onRemoveExpense(
                expenses[index],
              );
              print('your expense list after removing ${expenses.length}');
            },
            child: ExpenseItem(expenses[index]));
      },
    );
  }
}
