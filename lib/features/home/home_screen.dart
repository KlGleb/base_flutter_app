import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends StatefulWidget {
  static const homeKey = Key('HomeBottomNavigationBarItem');
  static const billsKey = Key('BillsBottomNavigationBarItem');
  static const settingsKey = Key('SettingsBottomNavigationBarItem');

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final pageState = IndexedPage.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: PageStackNavigator(
          key: ValueKey(pageState.index),
          stack: pageState.stacks[pageState.index],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined, key: HomeScreen.homeKey), label: 'Главная'),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money_outlined, key: HomeScreen.billsKey), label: 'Счета'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined, key: HomeScreen.settingsKey), label: 'Настройки'),
        ],
        currentIndex: pageState.index,
        onTap: (index) {
          setState(() {
            pageState.index = index;
          });
        },
      ),
    );
  }
}
