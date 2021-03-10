import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class ApiCalls{

    Future<List> apiCall()async{
     Response response=await _readRegRoom();
     List<dynamic> regRoom=jsonDecode(response.body);
     for(var i=0;i<regRoom.length;i++){

     }

   }

    Future<Response> _readRegRoom()async{
      var url =
          'http://25.110.41.176/housekeeping/soba.php';
     return await http.get(url);
   }

}