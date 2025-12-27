import 'package:flutter/material.dart';
import 'package:not_hesapla/components/input_widget.dart';

class PointPercentWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextEditingController? percentController;

  const PointPercentWidget({
    super.key,
    required this.label,
    required this.controller,
    this.percentController,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Not",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          InputWidget(
                            controller: controller,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                    if (percentController != null) ...[
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "% Oran",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            InputWidget(
                              controller: percentController!,
                              width: double.infinity,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Not",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      InputWidget(controller: controller),
                    ],
                  ),
                ),
                if (percentController != null) ...[
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "% Oran",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        InputWidget(
                          controller: percentController!,
                          width: 80,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
    );
  }
}