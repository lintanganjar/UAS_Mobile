import 'package:flutter/material.dart';
import 'package:show_list/show.dart';
import 'package:show_list/show_service.dart';

import 'detail_page.dart';


class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState(){
    ShowService.getAllShows();
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    var appBarTitleStyle = const TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20);
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Show List", style: appBarTitleStyle,), backgroundColor: Colors.blue,),
      body: FutureBuilder(
        future: ShowService.getAllShows(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data != null) {
            final shows = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(6),
                  sliver: SliverGrid.count(
                    crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    childAspectRatio: 0.75,
                    children: List.generate(shows.length, (index) {
                      return ItemShow(show: shows[index]);
                    }),
                  ),
                ),
              ],
            );
          }
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        },
      ),
    );
  }
}


class ItemShow extends StatelessWidget{
  const ItemShow({super.key, required this.show});

  final Show show;

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;
    var nameStyle = const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16);
    var genreStyle = const TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 12);
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0)
      ),
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=> DetailPage(show: show,)));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Stack(
            children: [
              SizedBox(
                width: size.width,
                height: size.height,
                child:
                Image.network(
                  show.image.image,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: orientation==Orientation.portrait?size.width/2.1:size.width/4.2,
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 4),
                          child: Text(show.name, style: nameStyle),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(show.genres.join(', '),  style: genreStyle),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}