import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finance_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:finance_app/features/transactions/presentation/pages/transactions_page.dart';
import 'package:finance_app/core/navigation/navigation_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationManager>(
      builder: (context, navigationManager, child) {
        return Scaffold(
          body: IndexedStack(
            index: navigationManager.currentIndex,
            children: const [
              DashboardPage(),
              TransactionsPage(),
            ],
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: navigationManager.currentIndex,
            onDestinationSelected: navigationManager.setIndex,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              NavigationDestination(
                icon: Icon(Icons.receipt_long_outlined),
                selectedIcon: Icon(Icons.receipt_long),
                label: 'Transactions',
              ),
            ],
          ),
        );
      },
    );
  }
} 