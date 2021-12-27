// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mlogin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

getstate _$getstateFromJson(Map<String, dynamic> json) => getstate(
      state: json['state'] as String,
    );

Map<String, dynamic> _$getstateToJson(getstate instance) => <String, dynamic>{
      'state': instance.state,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient2 implements RestClient2 {
  _RestClient2(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://192.168.11.101:4000';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<getstate> getkakao(m) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(m.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<getstate>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/mlogin/kakao',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = getstate.fromJson(_result.data!);
    return value;
  }

  @override
  Future<getstate> getnaver(m) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = m;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<getstate>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/mlogin/naver',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = getstate.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
