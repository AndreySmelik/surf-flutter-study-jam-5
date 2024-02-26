import 'package:flutter/material.dart';
import 'package:meme_generator/models/meme_model.dart';
import 'package:provider/provider.dart';

Future<void> showTextDialog(BuildContext context) {
  TextEditingController controller = TextEditingController();

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Введите текст мема'),
        content: TextField(
          controller: controller,
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Отмена'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Подтвердить'),
            onPressed: () {
              context.read<MemeModel>().setMemeText(controller.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
