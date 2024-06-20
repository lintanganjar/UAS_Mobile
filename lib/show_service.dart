import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:show_list/show.dart';

class ShowService{
  static Future<List<Show>> getAllShows() async{
    const baseUrl = 'https://api.tvmaze.com/shows';
    final response = await http.get(Uri.parse(baseUrl));
    if(response.statusCode==200){
      List<dynamic> data = jsonDecode(response.body);
      List<Show> shows = data.map((showsData)=>Show.fromJson(showsData)).toList();
      return shows;
    }else{
      if (kDebugMode) {
        print('Error: ${response.body}');
        print('Status Code: ${response.statusCode}');
      }
      throw Exception('Could not retrieve data from api');
    }
  }

}