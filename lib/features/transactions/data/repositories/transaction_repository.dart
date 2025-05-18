import 'package:hive/hive.dart';
import 'package:finance_app/features/transactions/domain/models/transaction.dart';
import 'package:uuid/uuid.dart';

class TransactionRepository {
  static const String _boxName = 'transactions';
  late Box<Map<dynamic, dynamic>> _box;
  final _uuid = const Uuid();

  Future<void> init() async {
    _box = await Hive.openBox<Map<dynamic, dynamic>>(_boxName);
  }

  Future<List<Transaction>> getTransactions() async {
    final transactions = _box.values
        .map((map) => Transaction.fromJson(Map<String, dynamic>.from(map)))
        .toList();
    return transactions..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<void> addTransaction(Transaction transaction) async {
    await _box.put(
      transaction.id,
      transaction.toJson(),
    );
  }

  Future<void> updateTransaction(Transaction transaction) async {
    await _box.put(
      transaction.id,
      transaction.toJson(),
    );
  }

  Future<void> deleteTransaction(String id) async {
    await _box.delete(id);
  }

  Future<List<Transaction>> getTransactionsByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    final transactions = await getTransactions();
    return transactions
        .where((t) => t.date.isAfter(start) && t.date.isBefore(end))
        .toList();
  }

  Future<List<Transaction>> getTransactionsByCategory(String category) async {
    final transactions = await getTransactions();
    return transactions.where((t) => t.category == category).toList();
  }

  Future<double> getTotalIncome() async {
    final transactions = await getTransactions();
    double total = 0.0;
    for (var transaction in transactions) {
      if (transaction.type == TransactionType.income) {
        total += transaction.amount;
      }
    }
    return total;
  }

  Future<double> getTotalExpense() async {
    final transactions = await getTransactions();
    double total = 0.0;
    for (var transaction in transactions) {
      if (transaction.type == TransactionType.expense) {
        total += transaction.amount;
      }
    }
    return total;
  }

  Future<Map<String, double>> getCategoryTotals() async {
    final transactions = await getTransactions();
    final categoryTotals = <String, double>{};

    for (var transaction in transactions) {
      if (transaction.type == TransactionType.expense) {
        categoryTotals[transaction.category] =
            (categoryTotals[transaction.category] ?? 0) + transaction.amount;
      }
    }

    return categoryTotals;
  }

  String generateId() => _uuid.v4();
} 