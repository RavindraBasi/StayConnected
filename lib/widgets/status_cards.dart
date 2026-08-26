import 'package:flutter/material.dart';

// Shows dummy battery level, alert threshold, and monitoring status.
// Real battery data will be wired in later via a battery API.
class BatteryStatusCard extends StatelessWidget {
  final int batteryLevel; // dummy value, e.g. 82
  final int alertThreshold; // dummy value, e.g. 20
  final String statusLabel; // dummy value, e.g. "Monitoring normally"
  final String location;

  const BatteryStatusCard({
    super.key,
    this.batteryLevel = 82,
    this.alertThreshold = 20,
    this.statusLabel = 'Monitoring normally',
    this.location = 'Bengaluru, India',
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
          Text(
            'Device status',
            style: TextStyle(
              color: colors.primary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 14),
          _StatusDetailRow(
            icon: Icons.battery_charging_full,
            label: 'Battery',
            value: '$batteryLevel%',
            valueColor: colors.secondary,
          ),
          const SizedBox(height: 14),
          Divider(color: colors.onSurface.withValues(alpha: 0.1), height: 1),
          const SizedBox(height: 14),
          _StatusDetailRow(
            icon: Icons.location_on_outlined,
            label: 'Location',
            value: location,
            valueColor: colors.primary,
          ),
          const SizedBox(height: 14),
          Text('Alert threshold: $alertThreshold%'),
          const SizedBox(height: 4),
          Text('Status: $statusLabel'),
        ],
      ),
    );
  }
}

class _StatusDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color valueColor;

  const _StatusDetailRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: valueColor, size: 23),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(color: colors.onSurfaceVariant, fontSize: 13),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
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
