import 'package:flutter/material.dart';

class TransactionTypePicker extends StatelessWidget {
  final bool isIncome;
  final ValueChanged<bool> onChanged;

  const TransactionTypePicker({
    super.key,
    required this.isIncome,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<bool>(
      segments: const [
        ButtonSegment(
          value: true,
          label: Text('Income'),
        ),
        ButtonSegment(
          value: false,
          label: Text('Loss'),
        ),
      ],
      selected: {isIncome},
      onSelectionChanged: (value) {
        onChanged(value.first);
      },
    );
  }
}
