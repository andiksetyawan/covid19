import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:covid19/models/country-model.dart';

class CountryService {
  static const url =
      'https://corona.lmao.ninja/v2/countries?yesterday&sort=cases';

  Future<List<Country>> getCountryApi() async {
    Dio dio = new Dio();
    dio.interceptors
        .add(DioCacheManager(CacheConfig(baseUrl: url)).interceptor);

    try {
      Response res = await dio.get(
        url,
        options: buildCacheOptions(
          Duration(hours: 12),
          maxStale: Duration(hours: 24),
        ),
      );
      List<Country> counties = [];

      for (var country in res.data) {
        Country list = Country.fromJson(country);
        counties.add(list);
      }

      return counties;
    } catch (e) {
      throw e;
    }
  }
}
