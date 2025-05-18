import 'package:flutter/material.dart';
import 'package:finance_app/features/transactions/presentation/pages/add_transaction_page.dart';

class AddTransactionFAB extends StatelessWidget {
  const AddTransactionFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddTransactionPage(),
          ),
        );
      },
      icon: const Icon(Icons.add),
      label: const Text('New Transaction'),
    );
  }
} 