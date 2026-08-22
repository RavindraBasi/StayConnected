import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  // If true, screen opens already scrolled down to "How it works".
  final bool scrollToHowItWorks;

  const AboutScreen({super.key, this.scrollToHowItWorks = false});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final GlobalKey _howItWorksKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.scrollToHowItWorks) {
      // Wait for first frame so the section actually has a position to scroll to.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final context = _howItWorksKey.currentContext;
        if (context != null) {
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 300),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFBFB),
        elevation: 0,
        title: const Text(
          'About StayConnected',
          style: TextStyle(color: Color(0xFF161B1D)),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF161B1D)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              title: 'What is StayConnected?',
              body:
                  'StayConnected is a safety app that looks out for you '
                  'when your phone battery is about to die. Instead of '
                  'leaving loved ones wondering why you suddenly went '
                  'silent, the app lets them know in advance.',
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'Why it exists',
              body:
                  'A dead phone at the wrong moment can turn into hours '
                  'of worry for the people who care about you. '
                  'StayConnected closes that gap.',
            ),
            const SizedBox(height: 32),

            // "How it works" section — this is where we scroll to.
            // "How it works" section — this is where we scroll to.
            Container(key: _howItWorksKey),
            _buildSection(
              title: 'How it works',
              body: '',
            ),
            const SizedBox(height: 16),
            _buildStep(
              number: '1',
              icon: Icons.person_add_alt,
              title: 'Set up the app',
              description: 'Create your profile and add trusted contacts.',
            ),
            _buildStep(
              number: '2',
              icon: Icons.tune,
              title: 'Choose your alert settings',
              description: 'Decide when the app should alert them — like a critical battery level.',
            ),
            _buildStep(
              number: '3',
              icon: Icons.phone_iphone,
              title: 'Use your phone normally',
              description: 'StayConnected quietly keeps an eye on your battery in the background.',
            ),
            _buildStep(
              number: '4',
              icon: Icons.battery_alert,
              title: 'Battery gets critically low',
              description: 'The app detects your phone may soon switch off.',
            ),
            _buildStep(
              number: '5',
              icon: Icons.send,
              title: 'Alert is sent automatically',
              description: 'StayConnected messages your trusted contacts right away.',
            ),
            _buildStep(
              number: '6',
              icon: Icons.location_on,
              title: 'The message includes what matters',
              description:
                  'Your name, battery level, last known location, timestamp, and a note that you may become unreachable.',
            ),
            _buildStep(
              number: '7',
              icon: Icons.people,
              title: 'Your contact is in the loop',
              description: 'They know you may go offline soon — and where to start looking if needed.',
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String body}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF161B1D),
          ),
        ),
        if (body.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            body,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF5C6B70),
              height: 1.5,
            ),
          ),
        ],
      ],
    );
  }

Widget _buildStep({
  required String number,
  required IconData icon,
  required String title,
  required String description,
  bool isLast = false,
  }){
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFFEAF4F2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    number,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E9E6D),
                    ),
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: const Color(0xFFEAF4F2),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, size: 16, color: const Color(0xFF1D6FA5)),
                      const SizedBox(width: 6),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF161B1D),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF5C6B70),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}