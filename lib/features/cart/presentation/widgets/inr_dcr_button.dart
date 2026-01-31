import 'package:ecommerce_assignment_module_31/app/app_colors.dart';
import 'package:flutter/material.dart';

class InrDcrButton extends StatefulWidget {
  const InrDcrButton({super.key, required this.onChange, this.maxValue = 100});

  final Function(int) onChange;
  final int maxValue;

  @override
  State<InrDcrButton> createState() => _InrDcrButtonState();
}

class _InrDcrButtonState extends State<InrDcrButton> {
  int _currentValue = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        spacing: 8,
        children: [
          _buildGestorDetector(
            onTap: () {
              if (_currentValue > 1) {
                _currentValue--;
                widget.onChange(_currentValue);
                setState(() {});
              }
            },
            icon: Icons.remove,
          ),
          Text("$_currentValue", style: TextTheme.of(context).titleLarge),
          _buildGestorDetector(
            onTap: () {
              if (widget.maxValue > _currentValue) _currentValue++;
              widget.onChange(_currentValue);
              setState(() {});
            },
            icon: Icons.add,
          ),
        ],
      ),
    );
  }

  Widget _buildGestorDetector({
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: AppColors.themeColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, size: 20, color: Colors.white),
      ),
    );
  }
}
