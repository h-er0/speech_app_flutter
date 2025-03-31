import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_translate/app/features/home/presentation/widgets/grabber.dart';

Future<LocaleName?> languagesPicker(
  BuildContext context,
  List<LocaleName> localeNames,
  String selectedLocale,
) async {
  final result = await showModalBottomSheet<LocaleName?>(
    isScrollControlled: true,
    isDismissible: true,

    context: context,
    builder: (context) {
      return HookConsumer(
        builder: (context, ref, child) {
          final sheetPosition = useState(0.5);
          final dragSensitivity = useState(600);
          return DraggableScrollableSheet(
            minChildSize: .20,
            maxChildSize: .9,
            initialChildSize: sheetPosition.value,
            expand: false,
            builder: (BuildContext context, ScrollController scrollController) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Grabber(
                    onVerticalDragUpdate: (DragUpdateDetails details) {
                      sheetPosition.value -=
                          details.delta.dy / dragSensitivity.value;
                      if (sheetPosition.value < 0.25) {
                        sheetPosition.value = 0.25;
                      }
                      if (sheetPosition.value > 1.0) {
                        sheetPosition.value = 1.0;
                      }
                    },
                    child: SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Choose language",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Flexible(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: localeNames.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () {
                            context.pop(localeNames[index]);
                          },
                          title: Text(
                            localeNames[index].name,
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing:
                              localeNames[index].localeId == selectedLocale
                                  ? Icon(Icons.check)
                                  : null,
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
    },
  );

  return result;
}
