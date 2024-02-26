import 'package:flutter/material.dart';
import 'package:meme_generator/modal_dialogs/show_picture_picker.dart';
import 'package:meme_generator/models/image_button_model.dart';
import 'package:meme_generator/models/image_model.dart';
import 'package:meme_generator/models/meme_model.dart';
import 'package:meme_generator/modal_dialogs/show_select_pic_dialog.dart';
import 'package:meme_generator/modal_dialogs/show_text_dialog.dart';
import 'package:provider/provider.dart';

class MemeGeneratorDemotivator extends StatefulWidget {
  const MemeGeneratorDemotivator({super.key});

  @override
  State<MemeGeneratorDemotivator> createState() => _MemeGeneratorDemotivatorState();
}

class _MemeGeneratorDemotivatorState extends State<MemeGeneratorDemotivator> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 2,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ColoredBox(
          color: Colors.black,
          child: DecoratedBox(
            decoration: decoration,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () => context.read<MemeModel>().initPicturePicker(context),  //showSelectPicDialog(context),
                    child: SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: DecoratedBox(
                        decoration: decoration,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: /*Image.network(
                            context.watch<MemeModel>().getMemeUrl(),
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) => const Center(
                              child: Text(
                                'Ошибка загрузки картинки!',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ),
                            fit: BoxFit.cover,
                          ),*/
                         Image.file(context.watch<ImageModel>().selectImage, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => showTextDialog(context),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Text(
                        context.watch<MemeModel>().getMemeText(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Impact',
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
