import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'about_screen.dart';
import 'welcome_screen.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const SettingsScreen({super.key, required this.onToggleTheme});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  String _language = 'English';
  String _profileName = 'Ananya Sharma';
  String _profilePhone = '+91 98765 43210';

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => WelcomeScreen(onToggleTheme: widget.onToggleTheme),
      ),
      (route) => false,
    );
  }

  Future<void> _editProfile() async {
    final nameController = TextEditingController(text: _profileName);
    final phoneController = TextEditingController(text: _profilePhone);
    final formKey = GlobalKey<FormState>();

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update profile'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Full name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Enter your name'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone number',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                validator: (value) => value == null || value.trim().length < 7
                    ? 'Enter a valid phone number'
                    : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (!formKey.currentState!.validate()) return;
              setState(() {
                _profileName = nameController.text.trim();
                _profilePhone = phoneController.text.trim();
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    nameController.dispose();
    phoneController.dispose();
  }

  void _showMessage(String title, String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  void _chooseLanguage() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['English', 'Hindi', 'Tamil', 'Bengali']
              .map(
                (language) => ListTile(
                  title: Text(language),
                  trailing: Icon(
                    _language == language
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: _language == language
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                  onTap: () {
                    setState(() => _language = language);
                    Navigator.pop(context);
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _section({required String title, required List<Widget> children}) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              color: colors.primary,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _settingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
    Widget? trailing,
    Color? iconColor,
  }) {
    final colors = Theme.of(context).colorScheme;
    return ListTile(
      leading: Icon(icon, color: iconColor ?? colors.primary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: subtitle == null ? null : Text(subtitle),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: colors.primary.withValues(alpha: 0.14),
                      child: Icon(
                        Icons.person,
                        size: 34,
                        color: colors.primary,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: CircleAvatar(
                        radius: 11,
                        backgroundColor: colors.secondary,
                        child: const Icon(
                          Icons.edit,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _profileName,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _profilePhone,
                        style: TextStyle(color: colors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: _editProfile,
                  tooltip: 'Edit profile',
                  icon: const Icon(Icons.edit_outlined),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _section(
            title: 'Account',
            children: [
              _settingTile(
                icon: Icons.manage_accounts_outlined,
                title: 'Update profile',
                subtitle: 'Name, phone number and profile picture',
                onTap: _editProfile,
              ),
              _settingTile(
                icon: Icons.person_add_alt_1_outlined,
                title: 'Add another account',
                subtitle: 'Connect another StayConnected profile',
                onTap: () => _showMessage(
                  'Add account',
                  'Account management will be available soon.',
                ),
              ),
              _settingTile(
                icon: Icons.people_outline,
                title: 'Your connections',
                subtitle: 'Manage people in your safety circle',
                onTap: () => _showMessage(
                  'Your connections',
                  'Your trusted contacts are available from the Contacts tab.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _section(
            title: 'Preferences',
            children: [
              _settingTile(
                icon: Icons.palette_outlined,
                title: 'Appearance',
                subtitle: 'Switch between light and dark themes',
                onTap: widget.onToggleTheme,
              ),
              _settingTile(
                icon: Icons.language_outlined,
                title: 'Language',
                subtitle: _language,
                onTap: _chooseLanguage,
              ),
              _settingTile(
                icon: Icons.notifications_none,
                title: 'Notifications',
                subtitle: 'Battery alerts and safety updates',
                trailing: Switch(
                  value: _notificationsEnabled,
                  onChanged: (value) =>
                      setState(() => _notificationsEnabled = value),
                ),
              ),
              _settingTile(
                icon: Icons.tune,
                title: 'General',
                subtitle: 'App behavior and alert preferences',
                onTap: () => _showMessage(
                  'General settings',
                  'General preferences will be available soon.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _section(
            title: 'Support and information',
            children: [
              _settingTile(
                icon: Icons.help_outline,
                title: 'Help center',
                subtitle: 'Find answers and safety guidance',
                onTap: () => _showMessage(
                  'Help center',
                  'Need help? StayConnected support will be here for you soon.',
                ),
              ),
              _settingTile(
                icon: Icons.feedback_outlined,
                title: 'Send feedback',
                subtitle: 'Tell us how we can improve',
                onTap: () => _showMessage(
                  'Feedback',
                  'Thanks for helping us make StayConnected better.',
                ),
              ),
              _settingTile(
                icon: Icons.system_update_outlined,
                title: 'Updates',
                subtitle: 'Stay up to date with the latest features',
                onTap: () => _showMessage(
                  'Updates',
                  'You are using the latest version of StayConnected.',
                ),
              ),
              _settingTile(
                icon: Icons.shield_outlined,
                title: 'Security & privacy',
                onTap: () => _showMessage(
                  'Security & privacy',
                  'Your information stays private and is used only to support your safety.',
                ),
              ),
              _settingTile(
                icon: Icons.description_outlined,
                title: 'Terms of service',
                onTap: () => _showMessage(
                  'Terms of service',
                  'StayConnected terms of service will be available here.',
                ),
              ),
              _settingTile(
                icon: Icons.info_outline,
                title: 'About us',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutScreen()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          OutlinedButton.icon(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
            label: const Text('Log out'),
            style: OutlinedButton.styleFrom(
              foregroundColor: colors.error,
              side: BorderSide(color: colors.error.withValues(alpha: 0.5)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ],
      ),
    );
  }
}
