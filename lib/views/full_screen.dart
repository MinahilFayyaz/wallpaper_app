import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:open_file/open_file.dart';

class FullScreen extends StatefulWidget {
  String imgUrl;
  FullScreen({Key? key, required this.imgUrl}) : super(key: key);

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
 final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<void> setwallpaper() async {
    int location = WallpaperManager.BOTH_SCREEN; //can be Home/Lock Screen
    var file = await DefaultCacheManager().getSingleFile(widget.imgUrl);
    try{
      bool result = await WallpaperManager.setWallpaperFromFile(file.path, location);
    }on PlatformException {
      var result = 'Failed to get wallpaper.';
      print('failed to get wallpaper');
    }
  }




 Future<void> setWallpaperFromFile(
      String wallpaperUrl, BuildContext context) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Downloading Started...")));
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(wallpaperUrl);
      if (imageId == null) {
        return;
      }
      // Below is a method of obtaining saved image information.
      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Downloaded Sucessfully"),
        action: SnackBarAction(
            label: "Open",
            onPressed: () {
              OpenFile.open(path);
            }),
      ));
    } on PlatformException catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error Occured - $error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: ElevatedButton(
          onPressed: () async {
            await setWallpaperFromFile(widget.imgUrl, context);
            setwallpaper();
         /*   try {
              await GallerySaver.saveImage(widget.imgUrl,
                  albumName: 'Wallpaper')
                  .then((success) {
                //for hiding bottom sheet
                Navigator.pop(context);
                if (success != null && success) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("image saved...")));
                  print("Sucessfully");
                }
              });
            } catch (e) {
              print('ErrorWhileSavingImg: $e');
            }*/
          },
          child: const Text("Set Wallpaper")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.imgUrl), fit: BoxFit.cover)),
      ),
    );
  }
}
