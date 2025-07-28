// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildInfoCard extends StatelessWidget {
  String title;
  String? subtitle;
  String? period;
  String? description;
  Uri? url;

  BuildInfoCard({super.key, required this.title, this.subtitle, this.period, this.description, this.url});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(subtitle!, style: TextStyle(fontSize: 12)),
            ],
            if (period != null) ...[
              const SizedBox(height: 4),
              Text(period!, style: TextStyle(fontSize: 12)),
            ],
            if (description != null) ...[
              const SizedBox(height: 8),
              Text(description!, style: TextStyle(fontSize: 12, height: 1.4)),
            ],
            if (url != null) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () async {
                    try {
                      await launchUrl(
                        url!,
                        mode: LaunchMode.externalApplication,
                      );
                    } catch (e) {
                      debugPrint("Error: $e");
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "View",
                        style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.w500,
                          fontSize: 12
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.open_in_new, size: 14, color: Colors.purple),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
