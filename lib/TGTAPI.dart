import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'TGTAPI.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:4000")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/oproduct")
  Future<List<Oproduct>> getoproduct();
}

@JsonSerializable()
class Oproduct {
  int id;
  int inguser;
  int nowuser;
  String user;
  String title;
  String detail;

  Oproduct({
    required this.id,
    required this.inguser,
    required this.nowuser,
    required this.user,
    required this.title,
    required this.detail,
});

  factory Oproduct.fromJson(Map<String, dynamic> json) => _$OproductFromJson(json);
  Map<String, dynamic> toJson() => _$OproductToJson(this);
}
