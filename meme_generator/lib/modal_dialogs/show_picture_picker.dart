import 'dart:io';
import 'dart:core';
//import 'package:file_picker/file_picker.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:meme_generator/models/image_button_model.dart';
import 'package:meme_generator/models/image_model.dart';
import 'package:provider/provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:typed_data';

void showPicturePicker(BuildContext context) async {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return GridImageWidget();
    },
  );
}

class GridImageWidget extends StatefulWidget {
  const GridImageWidget({super.key});

  @override
  State<GridImageWidget> createState() => _GridImageWidgetState();
}

class _GridImageWidgetState extends State<GridImageWidget> {
  final ScrollController _scrollController = ScrollController();
  bool isGallery = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      ImageModel imageModel = Provider.of<ImageModel>(context, listen: false);
      if (imageModel.currentPage != imageModel.lastPage) {
        if (_scrollController.position.pixels > _scrollController.position.maxScrollExtent - 15) {
          imageModel.loadImage();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ImageModel imageModel = Provider.of<ImageModel>(context, listen: true);
    //FormModel model = Provider.of<FormModel>(context, listen: false);
    return SizedBox(
      height: 450,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ImageButtonWidget(),
            Container(
              height: 350,
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    // A grid view with 3 items per row
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: imageModel.assetFile.length,
                itemBuilder: (context, index) {
                  return imageModel.assetFile.isNotEmpty
                      ? AssetThumbnail(asset: imageModel.assetFile[index], index: index)
                      : const CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AssetThumbnail extends StatelessWidget {
  final AssetEntity asset;
  final int index;

  const AssetThumbnail({
    super.key,
    required this.asset,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // We're using a FutureBuilder since thumbData is a future
    return FutureBuilder<Uint8List?>(
      future: asset.thumbnailData,
      builder: (_, snapshot) {
        final bytes = snapshot.data;
        // If we have no data, display a spinner
        if (bytes == null) return const CircularProgressIndicator();
        // If there's data, display it as an image
        return ImagePickerWidget(bytes: bytes, index: index);
      },
    );
  }
}

class ImagePickerWidget extends StatefulWidget {
  final Uint8List bytes;
  final int index;
  const ImagePickerWidget({super.key, required this.bytes, required this.index});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  @override
  Widget build(BuildContext context) {
    ImageButtonModel imageButtonModel = Provider.of<ImageButtonModel>(context, listen: true);
    return Container(
      padding: imageButtonModel.assetFileSelect[widget.index] ? const EdgeInsets.all(5) : const EdgeInsets.all(0),
      child: Container(
        alignment: Alignment.topRight,
        padding: EdgeInsets.only(
            right: imageButtonModel.assetFileSelect[widget.index] ? 0 : 5.0, top: imageButtonModel.assetFileSelect[widget.index] ? 0 : 5.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.memory(widget.bytes).image,
            fit: BoxFit.cover,
          ),
        ),
        child: InkWell(
          onTap: () {
            imageButtonModel.assetFileSelect[widget.index] = !imageButtonModel.assetFileSelect[widget.index];
            imageButtonModel.isSelect();
            setState(() {});
          },
          child: imageButtonModel.assetFileSelect[widget.index]
              ? const Icon(Icons.check_circle_outline_outlined, size: 30, color: Colors.blue)
              : const Icon(Icons.circle_outlined, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}

class ImageButtonWidget extends StatefulWidget {
  const ImageButtonWidget({super.key});

  @override
  State<ImageButtonWidget> createState() => _ImageButtonWidgetState();
}

class _ImageButtonWidgetState extends State<ImageButtonWidget> {
  @override
  Widget build(BuildContext context) {
    ImageModel imageModel = Provider.of<ImageModel>(context, listen: true);
    ImageButtonModel imageButtonModel = Provider.of<ImageButtonModel>(context, listen: true);

    return SizedBox(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Отмена',
                    style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.w400),
                  )),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: imageButtonModel.fileSelect
                  ? () async {
                      Navigator.of(context).pop();
                      int i = 0;
                      while (!imageButtonModel.assetFileSelect[i]) {
                        i++;
                      }
                      File? file = await imageModel.assetFile[i].file;
                      context.read<ImageModel>().selectImage = file!;
                      //await model.fileNameLoad(widget.requestID, file!, context);
                      imageModel.assetFile.clear();
                    }
                  : null,
              child: Text(
                'Выбрать',
                style: TextStyle(color: imageButtonModel.fileSelect ? Colors.blue : Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
