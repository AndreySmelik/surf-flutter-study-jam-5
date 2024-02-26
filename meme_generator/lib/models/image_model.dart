import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class ImageModel extends ChangeNotifier {
  List<AssetEntity> assetFile = [];
  int currentPage = 0;
  int lastPage = 0;
  File selectImage = File('assets/thisisfine.png');
  modelRebild() {
    notifyListeners();
  }

  initAlbum() async {
    currentPage = 0;
    lastPage = 0;
  }

  loadImage() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      lastPage = currentPage;
      List<AssetEntity> buffer = [];
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(onlyAll: true);
      //print(albums);
      if (albums.isNotEmpty) {
        buffer = await albums[0].getAssetListPaged(size: 60, page: currentPage);
      }
      if (buffer.isNotEmpty) {
        for (int i = 0; i < buffer.length; i++) {
          assetFile.add(buffer[i]);
        }
        currentPage++;
        notifyListeners();
      }
    } else {
      PhotoManager.openSetting();
    }
  }
}
