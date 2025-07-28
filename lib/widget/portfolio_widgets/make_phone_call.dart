import 'package:url_launcher/url_launcher.dart';

Future<void> makePhoneCall(String? path) async {
    final Uri launchUri = Uri(scheme: 'tel', path: path);

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }