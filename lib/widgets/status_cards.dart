import 'package:flutter/material.dart';

// Shows dummy battery level, alert threshold, and monitoring status.
// Real battery data will be wired in later via a battery API.
class BatteryStatusCard extends StatelessWidget {
  final int batteryLevel; // dummy value, e.g. 82
  final int alertThreshold; // dummy value, e.g. 20
  final String statusLabel; // dummy value, e.g. "Monitoring normally"

  const BatteryStatusCard({
    super.key,
    this.batteryLevel = 82,
    this.alertThreshold = 20,
    this.statusLabel = 'Monitoring normally',
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.battery_charging_full, color: colors.secondary),
              const SizedBox(width: 8),
              Text(
                'Battery: $batteryLevel%',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text('Alert threshold: $alertThreshold%'),
          const SizedBox(height: 4),
          Text('Status: $statusLabel'),
        ],
      ),
    );
  }
}

// Shows a dummy "protection active" state.
// Will eventually reflect real monitoring/alert status.
class SafetyStatusCard extends StatelessWidget {
  final bool isActive; // dummy value

  const SafetyStatusCard({super.key, this.isActive = true});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(
            isActive ? Icons.shield_outlined : Icons.shield_moon_outlined,
            color: isActive ? colors.secondary : colors.primary,
          ),
          const SizedBox(width: 12),
          Text(
            isActive ? 'Protection Active' : 'Protection Paused',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}