import 'package:http/http.dart';

class AppData{

  static const _hamachi_kuca='25.107.64.34';
  static const _hamachi_srecko='25.110.41.176';
  static const _server_temp='housekeeping777.000webhostapp.com';
  static const _server='';


  static const _address=_server_temp;

  static Future<Response> retrieveRoomData() async{
    return await get(Uri.parse('https://$_address/api_php/soba.php'));
  }

  static Future<Response> updateRoomStatus(int roomNumber, String isClean) async{
    return await post(Uri.parse(
        'http://$_address/api_php/soba_status.php'
            '?json={"soba":$roomNumber,"status":"$isClean"}'));
  }

  static Future<Response> sendLoginData({String uid,String token,String email,String password})async{
     return await post(Uri.parse(
         'https://$_address/api_php/users_android.php?'
             'json={"users_id":"$uid","email":"$email","password":"$password","token":"$token"}'));
  }

}