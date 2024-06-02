import 'package:expense_app/model/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(
      {super.key, required this.onAddExpense, });
  final void Function(Expense _expense) onAddExpense;
 

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final formater = DateFormat().add_yMd();
  final TextEditingController _titleEditngController = TextEditingController();
  final TextEditingController _ammountEditingController =
      TextEditingController();
  DateTime? _selectedDate;
  Categories _selectedCategory = Categories.leisure;

  void _datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_ammountEditingController.text);
    final amountInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleEditngController.text.isEmpty ||
        amountInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Invalid Text'),
            content: const Text(
                'please make sure a valid title,amount,date,category, was enterd'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Oky')),
            ],
          );
        },
      );
    }

    widget.onAddExpense(Expense(
        title: _titleEditngController.text,
        amount: enteredAmount!,
        date: _selectedDate!,
        category: _selectedCategory));
  }

  @override
  void dispose() {
    _titleEditngController.dispose();
    _ammountEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(children: [
        TextFormField(
          controller: _titleEditngController,
          maxLength: 50,
          decoration: const InputDecoration(label: Text('Title')),
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _ammountEditingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    label: Text('Amount'), prefixText: '\$'),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(_selectedDate == null
                    ? 'select Date'
                    : formater.format(_selectedDate!)),
                IconButton(
                    onPressed: () {
                      _datePicker();
                    },
                    icon: const Icon(Icons.calendar_month))
              ],
            ))
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            DropdownButton(
                value: _selectedCategory,
                items: Categories.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category.name.toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                }),
            Spacer(),
            TextButton(onPressed: () {}, child: const Text('Cancel')),
            ElevatedButton(
                onPressed: () {
                  _submitExpenseData();
                  Navigator.pop(context);
                },
                child: const Text('save expense'))
          ],
        )
      ]),
    );
  }
}
