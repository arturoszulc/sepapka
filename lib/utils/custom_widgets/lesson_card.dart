import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sepapka/services/user_service.dart';


class AcademyCard extends ConsumerWidget {
  const AcademyCard(
      {Key? key,
      this.upperText = '',
      required this.middleText,
      this.lowerText = '',
      this.proOnly = false,
      required this.onTap})
      : super(key: key);

  final String upperText;
  final String middleText;
  final String lowerText;

  // final Lesson lesson;
  final bool proOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isUserPro = ref.watch(userService).isPro;
    final bool isButtonActive = (proOnly && isUserPro) || !proOnly;
    return Card(
      elevation: isButtonActive ? 3 : 1,
      child: InkWell(
        onTap: isButtonActive ? onTap : null,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      upperText.isEmpty ? const SizedBox() : Text(
                        upperText,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          middleText,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      lowerText.isEmpty ? const SizedBox() : Text(lowerText, style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  )),
              Expanded(
                child: isButtonActive ? const Icon(Icons.arrow_forward_ios) : const Icon(Icons.lock),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
