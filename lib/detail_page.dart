import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:show_list/show.dart';

class DetailPage extends StatelessWidget{
  const DetailPage({super.key, required this.show});

  final Show show;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var appBarTitleStyle = TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Detail Show", style: appBarTitleStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.black.withOpacity(0.1),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: size.width / 1.8,
                  child: Image.network(
                    show.image.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: size.width,
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      show.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
              child: Text(removeTags(show.desc),textAlign: TextAlign.justify,),
            )
          ],
        ),
      ),
    );
  }

  //menghapus tags html yang ada di desc
  String removeTags(String text) {
    final regex = RegExp(r'<[^>]*>', multiLine: true);
    final cleanText = text.replaceAll(regex, '');
    return cleanText;
  }
}