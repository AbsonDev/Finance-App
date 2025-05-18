import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:finance_app/core/theme/app_theme.dart';
import 'package:finance_app/features/transactions/data/repositories/transaction_repository.dart';
import 'package:finance_app/features/transactions/presentation/bloc/transaction_bloc.dart';
import 'package:finance_app/features/transactions/presentation/pages/transactions_page.dart';
import 'package:finance_app/core/presentation/pages/home_page.dart';
import 'package:finance_app/core/navigation/navigation_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  final transactionRepository = TransactionRepository();
  await transactionRepository.init();
  
  runApp(MyApp(transactionRepository: transactionRepository));
}

class MyApp extends StatelessWidget {
  final TransactionRepository transactionRepository;

  const MyApp({
    super.key,
    required this.transactionRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationManager()),
        BlocProvider(
          create: (context) => TransactionBloc(transactionRepository)
            ..add(LoadTransactions()),
        ),
      ],
      child: MaterialApp(
        title: 'Finance App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const HomePage(),
      ),
    );
  }
} 