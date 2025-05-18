import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

enum TransactionType {
  income,
  expense,
}

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required String id,
    required String description,
    required String category,
    required double amount,
    required TransactionType type,
    required DateTime date,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
} 