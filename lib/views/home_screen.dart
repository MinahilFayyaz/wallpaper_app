// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:wallpaper_app/controller/apiOperator.dart';
import 'package:wallpaper_app/models/category_model.dart';
import 'package:wallpaper_app/models/photos_model.dart';
import 'package:wallpaper_app/views/full_screen.dart';
import 'package:wallpaper_app/views/widgets/categories_block.dart';
import 'package:wallpaper_app/views/widgets/custom_appbar.dart';
import 'package:wallpaper_app/views/widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<PhotosModel> trendingList;
  late List<CategoryModel> CatModList;
  bool isLoading = true;

  GetCatDetails() async {
    CatModList = await ApiOperations.getCategoriesList();
    print("GETTTING CAT MOD LIST");
    print(CatModList);
    setState(() {
      CatModList = CatModList;
    });
  }

  GetTrendingWallpapers() async{
    trendingList= await ApiOperations.getTrendingwallpapers();
    setState(() {
      isLoading= false;

    });
  }

  @override
  void initState() {
    super.initState();
    GetCatDetails();
    GetTrendingWallpapers();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: const CustomAppBar(),
          ),
          body: isLoading ? const Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const SearchBox()),

                Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: CatModList.length,
                        itemBuilder: ((context, index) => Categories(
                          categoryName: CatModList[index].catName,
                          categoryImgSrc: CatModList[index].catImgUrl,

                        )),
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 400,
                          crossAxisCount:2,
                        crossAxisSpacing: 13,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: trendingList.length,
                      itemBuilder: ((context, index) => GridTile(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> FullScreen(
                              imgUrl: trendingList[index].imgSrc,

                            )));
                          },
                          child: Hero(
                            tag: trendingList[index].imgSrc,
                            child: Container(
                              height: 500,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15),

                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                    height: 500,
                                    width: 50,
                                    fit: BoxFit.cover,
                                    trendingList[index].imgSrc
                                ),
                              ),
                            ),
                          ),
                        ),
                      )) ,
                    ),
                  ),
                )
              ],
            ),
          ),
    );
  }
}
