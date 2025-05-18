import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finance_app/features/transactions/domain/models/transaction.dart';
import 'package:finance_app/features/transactions/data/repositories/transaction_repository.dart';

// Events
abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class LoadTransactions extends TransactionEvent {}

class AddTransaction extends TransactionEvent {
  final String description;
  final String category;
  final double amount;
  final TransactionType type;
  final DateTime date;

  const AddTransaction({
    required this.description,
    required this.category,
    required this.amount,
    required this.type,
    required this.date,
  });

  @override
  List<Object> get props => [description, category, amount, type, date];
}

class UpdateTransaction extends TransactionEvent {
  final Transaction transaction;

  const UpdateTransaction(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class DeleteTransaction extends TransactionEvent {
  final String id;

  const DeleteTransaction(this.id);

  @override
  List<Object> get props => [id];
}

// States
abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;
  final double totalIncome;
  final double totalExpense;
  final Map<String, double> categoryTotals;

  const TransactionLoaded({
    required this.transactions,
    required this.totalIncome,
    required this.totalExpense,
    required this.categoryTotals,
  });

  @override
  List<Object> get props => [transactions, totalIncome, totalExpense, categoryTotals];
}

class TransactionError extends TransactionState {
  final String message;

  const TransactionError(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository _repository;

  TransactionBloc(this._repository) : super(TransactionInitial()) {
    on<LoadTransactions>(_onLoadTransactions);
    on<AddTransaction>(_onAddTransaction);
    on<UpdateTransaction>(_onUpdateTransaction);
    on<DeleteTransaction>(_onDeleteTransaction);
  }

  Future<void> _onLoadTransactions(
    LoadTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      emit(TransactionLoading());

      final transactions = await _repository.getTransactions();
      final totalIncome = await _repository.getTotalIncome();
      final totalExpense = await _repository.getTotalExpense();
      final categoryTotals = await _repository.getCategoryTotals();

      emit(TransactionLoaded(
        transactions: transactions,
        totalIncome: totalIncome,
        totalExpense: totalExpense,
        categoryTotals: categoryTotals,
      ));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }

  Future<void> _onAddTransaction(
    AddTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      final transaction = Transaction(
        id: _repository.generateId(),
        description: event.description,
        category: event.category,
        amount: event.amount,
        type: event.type,
        date: event.date,
      );

      await _repository.addTransaction(transaction);
      add(LoadTransactions());
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }

  Future<void> _onUpdateTransaction(
    UpdateTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      await _repository.updateTransaction(event.transaction);
      add(LoadTransactions());
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }

  Future<void> _onDeleteTransaction(
    DeleteTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      await _repository.deleteTransaction(event.id);
      add(LoadTransactions());
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }
} 