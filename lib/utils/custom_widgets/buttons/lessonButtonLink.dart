
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../consts/my_screens.dart';


class LessonButtonLink extends ConsumerWidget {
  const LessonButtonLink({
    Key? key,
    required this.label,
    required this.url,
  }) : super(key: key);

  final String label;
  final String url;

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20.0),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.public),
        style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50)),
        onPressed: () => _launchUrl(Uri.parse(url)),
        //badgeNum > -1 - zmienić to na 0, jeśli przycisk ma być wyszarzony, gdy nie ma pytań
        label: Row(
          children: [
            Expanded(child: Text(label, textAlign: TextAlign.center,)),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}