import 'package:flutter/material.dart';
import 'package:finance_app/features/transactions/domain/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionListItem({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isExpense = transaction.type == TransactionType.expense;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isExpense
              ? colorScheme.error.withOpacity(0.1)
              : colorScheme.primary.withOpacity(0.1),
          child: Icon(
            isExpense ? Icons.arrow_downward : Icons.arrow_upward,
            color: isExpense ? colorScheme.error : colorScheme.primary,
          ),
        ),
        title: Text(
          transaction.description,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          DateFormat('MM/dd/yyyy').format(transaction.date),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              NumberFormat.currency(
                locale: 'en_US',
                symbol: '\$',
              ).format(transaction.amount),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isExpense ? colorScheme.error : colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              transaction.category,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        onTap: () {
          // TODO: Implementar edição de transação
        },
      ),
    );
  }
} 