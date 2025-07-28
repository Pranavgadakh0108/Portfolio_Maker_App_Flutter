import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> sendEmail(BuildContext context, String? path) async {
    try {
      final emailUri = Uri(scheme: 'mailto', path: path);

      final canLaunch = await canLaunchUrl(emailUri);

      if (!canLaunch) {
        // Try web fallback
        final webFallback = await _tryWebEmailFallback(context, path);
        if (!webFallback) return;
      } else {
        await launchUrl(emailUri);
      }
    } catch (e) {
      _showErrorDialog(
        context,
        'Failed to send email',
        'Please check your email configuration or try again later.',
      );
    }
  }

  Future<bool> _tryWebEmailFallback(BuildContext context, String? myEmail) async {
    try {
      final gmailUri = Uri(
        scheme: 'https',
        host: 'mail.google.com',
        path: 'mail',
        queryParameters: {'view': 'cm', 'fs': '1', 'to': myEmail},
      );

      if (await canLaunchUrl(gmailUri)) {
        await launchUrl(gmailUri);
        return true;
      }
    } catch (e) {
      // Ignore and show error
    }

    _showErrorDialog(
      context,
      'No email app found',
      'Please install an email app or configure one in your device settings.',
    );
    return false;
  }

  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }