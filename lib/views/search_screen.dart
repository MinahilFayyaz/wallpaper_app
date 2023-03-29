import 'package:flutter/material.dart';
import 'package:wallpaper_app/controller/apiOperator.dart';
import 'package:wallpaper_app/models/photos_model.dart';
import 'package:wallpaper_app/views/full_screen.dart';
import 'package:wallpaper_app/views/widgets/custom_appbar.dart';
import 'package:wallpaper_app/views/widgets/search_bar.dart';

class SearchScreen extends StatefulWidget {
  String query;
  SearchScreen({Key? key, required this.query}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late List<PhotosModel> searchList;
  bool isLoading = true;

  GetSearchWallpapers() async{
    searchList = await ApiOperations.getSearchWallpapers(widget.query);
    setState(() {
     isLoading= false;
    });
  }

  @override
  void initState() {
    super.initState();
    GetSearchWallpapers();
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
      body: isLoading ? Center(child: CircularProgressIndicator(),) :SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SearchBox()),


            SizedBox(
              height: 30,
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
                  itemCount: searchList.length,
                  itemBuilder: ((context, index) => GridTile(
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FullScreen(
                                  imgUrl:
                                  searchList[index].imgSrc)));
                      },
                      child: Hero(
                        tag: searchList[index].imgSrc,
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
                               searchList[index].imgSrc,
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
