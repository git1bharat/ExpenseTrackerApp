import 'package:expense_app/model/expense.dart' as action;
import 'package:expense_app/model/expense.dart';
import 'package:expense_app/screen/new_expenseList.dart';
import 'package:expense_app/widget/expense_list.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final List<action.Expense> _expenses = [
    action.Expense(
        title: 'Cinema',
        amount: 500.40,
        date: DateTime.now(),
        category: action.Categories.leisure),
    action.Expense(
        title: 'groceries',
        amount: 5001.40,
        date: DateTime.now(),
        category: action.Categories.food),
    action.Expense(
        title: 'hotel',
        amount: 500.40,
        date: DateTime.now(),
        category: action.Categories.travel),
  ];
  void _openExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height *
            0.90, // Adjust the height as needed
        child: SingleChildScrollView(
          child: NewExpense(
            onAddExpense: (_expense) => _addExpense(_expense),
          ),
        ),
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
      print('your Expense length is after adding  ${_expenses.length}');
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _expenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [
          IconButton(
              onPressed: () => _openExpenseOverlay(),
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Charts'),
        Container(
            width: 390,
            height: 600,
            child: ExpensesList(
              expenses: _expenses,
              onRemoveExpense: _removeExpense,
            ))
      ]),
    );
  }
}
