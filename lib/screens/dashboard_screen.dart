import 'package:flutter/material.dart';
import '../widgets/status_cards.dart';
import '../widgets/quick_action_tile.dart';
import '../widgets/theme_toggle_button.dart';
import 'contacts_screen.dart';
import 'settings_screen.dart';
import 'history_screen.dart';

class DashboardScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const DashboardScreen({super.key, required this.onToggleTheme});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      _HomeTab(onToggleTheme: widget.onToggleTheme),
      const ContactsScreen(),
      SettingsScreen(onToggleTheme: widget.onToggleTheme),
    ];

    return Scaffold(
      body: SafeArea(child: pages[_selectedIndex]),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).colorScheme.error,
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('SOS'),
              content: const Text(
                'This will alert your trusted contacts.\n(Not yet connected to real alerts)',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Send SOS'),
                ),
              ],
            ),
          );
        },
        child: const Text(
          'SOS',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.people_outline), label: 'Contacts'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
      ),
    );
  }
}

// Home tab content — greeting, status cards, and quick actions.
class _HomeTab extends StatelessWidget {
  final VoidCallback onToggleTheme;

  const _HomeTab({required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting row: name, profile icon, theme toggle
          Row(
            children: [
              Expanded(
                child: Text(
                  'Hi, Ananya 👋',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const Icon(Icons.account_circle_outlined, size: 28),
              const SizedBox(width: 8),
              ThemeToggleButton(onToggleTheme: onToggleTheme),
            ],
          ),
          const SizedBox(height: 24),

          const BatteryStatusCard(),
          const SizedBox(height: 16),
          const SafetyStatusCard(),
          const SizedBox(height: 24),

          const Text(
            'Quick Actions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              QuickActionTile(
                icon: Icons.people_outline,
                label: 'Trusted Contacts',
                onTap: () {
                  // TODO: eventually could deep-link into Contacts tab
                },
              ),
              const SizedBox(width: 12),
              QuickActionTile(
                icon: Icons.tune,
                label: 'Alert Settings',
                onTap: () {
                  // TODO: eventually could deep-link into Settings tab
                },
              ),
              const SizedBox(width: 12),
              QuickActionTile(
                icon: Icons.history,
                label: 'History',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HistoryScreen()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}