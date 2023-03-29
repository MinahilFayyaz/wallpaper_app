import 'package:flutter/material.dart';
import 'package:wallpaper_app/controller/apiOperator.dart';
import 'package:wallpaper_app/models/photos_model.dart';
import 'package:wallpaper_app/views/full_screen.dart';
import 'package:wallpaper_app/views/widgets/custom_appbar.dart';

class CategoryScreen extends StatefulWidget {
  String catName;
  String catImgUrl;
  CategoryScreen({Key? key, required this.catImgUrl, required this.catName}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isLoading = true;
  late List<PhotosModel> categoryResults ;

  GetCatRelWall() async {
     categoryResults = await ApiOperations.getSearchWallpapers(widget.catName);

    setState(() {
     isLoading=false;
    });
  }

  @override
  void initState() {
    GetCatRelWall();
    super.initState();
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
      body: isLoading  ? Center(child: CircularProgressIndicator(),)  : SingleChildScrollView(
        child: Column(
          children: [
            Stack(
        children: [
        Image.network(
            height: 150,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
             widget.catImgUrl,
        ),
        Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          color: Colors.black38,
        ),
        Positioned(
          left: 157,
          top: 45,
          child: Column(
            children: [
              Text("Category",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w300)),
              Text(
                widget.catName,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              )
             ],
            ),
            ),
          ],
        ),

          const SizedBox(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 700,
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 400,
                  crossAxisCount:2,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 10,
                ),
                itemCount: categoryResults.length,
                itemBuilder: ((context, index) => GridTile(
                  child : InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FullScreen(
                                imgUrl:
                                categoryResults[index].imgSrc)));
                  },
                  child: Hero(
                    tag: categoryResults[index].imgSrc,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                          height: 500,
                          width: 50,
                          fit: BoxFit.cover,
                          categoryResults[index].imgSrc),
                    ),
                  ),
                  ),
                )) ,
              ),
          ),
        ],
        ),
      ),
    );
  }
}
