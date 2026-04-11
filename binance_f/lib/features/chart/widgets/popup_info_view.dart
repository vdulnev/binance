import 'package:flutter/material.dart';
import 'package:k_chart_plus/k_chart_plus.dart';

class PopupInfoView extends StatelessWidget {
  const PopupInfoView({
    super.key,
    required this.entity,
    required this.chartColors,
    this.fixedLength = 2,
  });

  final KLineEntity entity;
  final KChartColors chartColors;
  final int fixedLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: 150,
      decoration: BoxDecoration(
        color: chartColors.selectFillColor.withAlpha((0.8 * 255).toInt()),
        border: Border.all(color: chartColors.selectBorderColor, width: 0.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildItem("Open", entity.open.toStringAsFixed(fixedLength)),
          _buildItem("High", entity.high.toStringAsFixed(fixedLength)),
          _buildItem("Low", entity.low.toStringAsFixed(fixedLength)),
          _buildItem("Close", entity.close.toStringAsFixed(fixedLength)),
          _buildItem("Vol", entity.vol.toStringAsFixed(2)),
        ],
      ),
    );
  }

  Widget _buildItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: Colors.white),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
