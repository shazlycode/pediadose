import 'package:flutter/material.dart';
import 'package:pediatric_dosage/providers/dosage_provider.dart';
import 'package:pediatric_dosage/screens/contact_us.dart';
import 'package:pediatric_dosage/screens/details.dart';
import 'package:pediatric_dosage/screens/how_to_use.dart';
import 'package:pediatric_dosage/screens/resources.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoriesData = Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedia Dose'),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.info,
                        color: Color(0xff7868e6),
                      ),
                      title: Text('How to use Pedia Dose'),
                      onTap: () {
                        Navigator.pushNamed(context, HowToUse.id);
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.book,
                        color: Color(0xff7868e6),
                      ),
                      title: Text('Resources'),
                      onTap: () {
                        Navigator.pushNamed(context, Resources.id);
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.share,
                        color: Color(0xff7868e6),
                      ),
                      title: Text('Share Pedia dose'),
                      onTap: () {
                        //share
                        Share.share(
                            'https://play.google.com/store/apps/details?id=com.shazlycode.pediatric_dosage',
                            subject: 'Pedia Dose');
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.phone_android_sharp,
                        color: Color(0xff7868e6),
                      ),
                      title: Text('Our Apps'),
                      onTap: () async {
                        //our apps
                        var url =
                            'https://play.google.com/store/apps/dev?id=8403495839670533437';
                        await canLaunch(url)
                            ? await launch(url)
                            : throw 'Could not launch $url';
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.contact_mail,
                        color: Color(0xff7868e6),
                      ),
                      title: Text('Contact us'),
                      onTap: () {
                        Navigator.pushNamed(context, ContactUs.id);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
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
