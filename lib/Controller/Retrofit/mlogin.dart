import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'mlogin.g.dart';

@RestApi(baseUrl: "http://192.168.11.101:4000")
abstract class RestClient2 {
  factory RestClient2(Dio dio, {String baseUrl}) = _RestClient2;

  @POST("/mlogin/kakao")
  Future<getstate> getkakao(@Body() User m);

  @POST("/mlogin/naver")
  Future<getstate> getnaver(@Body() NaverAccountResult m); //Map<String, dynamic>
}

@JsonSerializable()
class getstate {

  String state;

  getstate({
    required this.state,
  });

  factory getstate.fromJson(Map<String, dynamic> json) => _$getstateFromJson(json);
  Map<String, dynamic> toJson() => _$getstateToJson(this);
}