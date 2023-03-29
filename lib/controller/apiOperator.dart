import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/models/category_model.dart';
import 'package:wallpaper_app/models/photos_model.dart';

class ApiOperations{
  static List<PhotosModel> trendingWallpapers = [];
  static List<PhotosModel> searchWallpapers = [];
  static List<CategoryModel> cateogryModelList = [];

  static Future<List<PhotosModel>> getTrendingwallpapers() async{
       await http.get(
           Uri.parse("https://api.pexels.com/v1/curated"),
         headers: {"Authorization" : "43qAzQcJWd5j8MM0mCaxWQwAbBwf8sFrVN40wIyfuO2PZZjMwQUfshtU"}
       ).then((value) {
       Map<String, dynamic> jsonData = jsonDecode(value.body);
       List photos = jsonData['photos'];
       photos.forEach((element) {
         trendingWallpapers.add(PhotosModel.fromAPI2App(element));
        });
       });
       return trendingWallpapers;
  }



  static Future<List<PhotosModel>> getSearchWallpapers(String query) async{
    await http.get(
      Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
      headers: {"Authorization" :"43qAzQcJWd5j8MM0mCaxWQwAbBwf8sFrVN40wIyfuO2PZZjMwQUfshtU"}
    ).then((value) {
      Map<String, dynamic> jsonData= jsonDecode(value.body);
      List photos = jsonData['photos'];
      searchWallpapers.clear();
      photos.forEach((element){
        searchWallpapers.add(PhotosModel.fromAPI2App(element));
    });
    });
    return searchWallpapers;
  }

  static List<CategoryModel> getCategoriesList() {
    List cateogryName = [
      "Cars",
      "Nature",
      "Animals",
      "Street",
      "City",
      "Flowers"
    ];
    cateogryModelList.clear();
    cateogryName.forEach((catName) async {
      final _random = new Random();

      PhotosModel photoModel =
      (await getSearchWallpapers(catName))[0 + _random.nextInt(11 - 0)];
      print("IMG SRC IS HERE");
      print(photoModel.imgSrc);
      cateogryModelList
          .add(CategoryModel(catImgUrl: photoModel.imgSrc, catName: catName));
    });

    return cateogryModelList;
  }

}