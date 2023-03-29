import 'package:flutter/material.dart';
import 'package:wallpaper_app/views/category_screen.dart';

class Categories extends StatelessWidget {
  String categoryName;
  String categoryImgSrc;
  Categories({Key? key, required this.categoryImgSrc, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CategoryScreen(
                  catImgUrl: categoryImgSrc, catName: categoryName,)));
    },

      child :Container(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 15),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
              child: Image.network(
                height : 60,
                  width : 100,
                  fit : BoxFit.cover,
                  categoryImgSrc,
              )
          ),

          Container(
            height: 60,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(15)
            ),
          ),

          Positioned(
            left: 30,
            top: 22.5,
            child: Text(categoryName,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600
            ),),
          )

        ],
      ),
     ),
    );
  }
}
