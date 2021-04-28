import 'package:http/http.dart';

class AppData {
  static const _timeout_duration = Duration(seconds: 5);
  static const _hamachi_kuca = '25.107.64.34';
  static const _hamachi_srecko = '25.110.41.176';
  static const _server_temp = 'housekeeping777.000webhostapp.com';
  static const _server = '';

  static const _address = _server_temp;

  static Future<Response> retrieveRoomData([Function func]) async {
    print('https://$_address/api_php/soba.php');
    return await get(Uri.parse('https://$_address/api_php/soba.php')).timeout(
      _timeout_duration,
      onTimeout: func,
    );
  }

  static Future<Response> updateRoomStatus(int roomNumber, String isClean,
      [Function func]) async {
    print('http://$_address/api_php/soba_status.php'
        '?json={"soba":$roomNumber,"status":"$isClean"}');
    return await post(Uri.parse('http://$_address/api_php/soba_status1.php'
            '?json={"soba":$roomNumber,"status":"$isClean"}'))
        .timeout(
      _timeout_duration,
      onTimeout: func,
    );
  }

  static Future<Response> sendLoginData(
      {String uid, String token, String email, String password,Function func}) async {
    print('https://$_address/api_php/android_users_insert.php?'
        'json={"users_id":"$uid","email":"$email","password":"$password","token":"$token"}');
    return await post(Uri.parse(
        'https://$_address/api_php/android_users_insert.php?'
        'json={"users_id":"$uid","email":"$email","password":"$password","token":"$token"}')).timeout(
      _timeout_duration,
      onTimeout: func
    );
  }
}
