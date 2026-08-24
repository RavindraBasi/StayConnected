import 'package:flutter/material.dart';
import '../widgets/contacts_card.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final List<TrustedContact> _contacts = [
    const TrustedContact(
      name: 'Maya Sharma',
      phoneNumber: '+91 98765 43210',
      avatarIcon: Icons.person_outline,
    ),
    const TrustedContact(
      name: 'Rohan Mehta',
      phoneNumber: '+91 91234 56789',
      avatarIcon: Icons.person_outline,
    ),
    const TrustedContact(
      name: 'Ananya Iyer',
      phoneNumber: '+91 99887 66554',
      avatarIcon: Icons.family_restroom_outlined,
    ),
    const TrustedContact(
      name: 'Kabir Singh',
      phoneNumber: '+91 97654 32109',
      avatarIcon: Icons.work_outline,
    ),
    const TrustedContact(
      name: 'Diya Kapoor',
      phoneNumber: '+91 98760 12345',
      avatarIcon: Icons.favorite_border,
    ),
  ];

  Future<void> _openContactForm({TrustedContact? contact}) async {
    final result = await showDialog<TrustedContact>(
      context: context,
      builder: (_) => _ContactFormDialog(contact: contact),
    );

    if (!mounted || result == null) return;
    setState(() {
      if (contact == null) {
        _contacts.add(result);
      } else {
        final index = _contacts.indexOf(contact);
        if (index != -1) _contacts[index] = result;
      }
    });
  }

  Future<void> _deleteContact(TrustedContact contact) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete contact?'),
        content: Text('Remove ${contact.name} from your trusted contacts?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (shouldDelete == true && mounted) {
      setState(() => _contacts.remove(contact));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Trusted Contacts',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
        children: [
          Text(
            'Your safety circle',
            style: TextStyle(
              color: colors.primary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            _contacts.isEmpty
                ? 'Add someone you trust to reach quickly in an emergency.'
                : 'People who will be alerted when you need help.',
            style: TextStyle(color: colors.onSurfaceVariant, fontSize: 14),
          ),
          const SizedBox(height: 20),
          if (_contacts.isEmpty)
            _EmptyContacts(onAdd: () => _openContactForm())
          else
            ..._contacts.map(
              (contact) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ContactsCard(
                  contact: contact,
                  onEdit: () => _openContactForm(contact: contact),
                  onDelete: () => _deleteContact(contact),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openContactForm(),
        icon: const Icon(Icons.add),
        label: const Text('Add contact'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

class _EmptyContacts extends StatelessWidget {
  final VoidCallback onAdd;

  const _EmptyContacts({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 36, 24, 32),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(Icons.people_alt_outlined, size: 52, color: colors.primary),
          const SizedBox(height: 16),
          const Text(
            'No trusted contacts yet',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            'Your trusted contacts can be notified when you send an SOS.',
            textAlign: TextAlign.center,
            style: TextStyle(color: colors.onSurfaceVariant, height: 1.4),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.person_add_alt_1_outlined),
            label: const Text('Add first contact'),
          ),
        ],
      ),
    );
  }
}

class _ContactFormDialog extends StatefulWidget {
  final TrustedContact? contact;

  const _ContactFormDialog({this.contact});

  @override
  State<_ContactFormDialog> createState() => _ContactFormDialogState();
}

class _ContactFormDialogState extends State<_ContactFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  IconData _selectedIcon = Icons.person_outline;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact?.name);
    _phoneController = TextEditingController(text: widget.contact?.phoneNumber);
    _selectedIcon = widget.contact?.avatarIcon ?? Icons.person_outline;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      TrustedContact(
        name: _nameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        avatarIcon: _selectedIcon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final icons = [
      Icons.person_outline,
      Icons.family_restroom_outlined,
      Icons.work_outline,
      Icons.favorite_border,
    ];

    return AlertDialog(
      title: Text(
        widget.contact == null ? 'Add trusted contact' : 'Edit contact',
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Enter a name'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone number',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                validator: (value) => value == null || value.trim().length < 7
                    ? 'Enter a valid phone number'
                    : null,
              ),
              const SizedBox(height: 18),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose an avatar',
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: icons
                    .map(
                      (icon) => ChoiceChip(
                        label: Icon(icon, size: 20),
                        selected: _selectedIcon == icon,
                        onSelected: (_) => setState(() => _selectedIcon = icon),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _save, child: const Text('Save contact')),
      ],
    );
  }
}
