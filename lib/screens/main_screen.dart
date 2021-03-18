import 'package:flutter/material.dart';
import 'package:pediatric_dosage/providers/dosage_provider.dart';
import 'package:pediatric_dosage/screens/details.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoriesData = Provider.of<CategoryProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: categoriesData.categories.length,
              itemBuilder: (context, index) => CatItem(
                    image: categoriesData.categories[index].image,
                    arguments: categoriesData.categories[index].name,
                    txt: categoriesData.categories[index].name,
                  )),
        ),
      ),
    );
  }
}

class CatItem extends StatelessWidget {
  final String arguments;
  final AssetImage image;
  final String txt;

  CatItem({this.txt, this.arguments, this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Details.id, arguments: arguments);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xff8ac4d0),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Image(
              image: image,
              height: 160,
            ),
            Text(
              txt,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
