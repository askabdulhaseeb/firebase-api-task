import 'package:firebase_api_task/models/news.dart';
import 'package:firebase_api_task/utilities/news_api_links.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class NewsAPI {
  Future<News?> getNews({String keyword = 'web'}) async {
    final DateFormat _formate = DateFormat('yyyy-MM-dd');
    final String _date = _formate.format(DateTime.now());
    print(_date);
    final http.Request request = http.Request(
      'GET',
      Uri.parse(
          '${NewsAPILinks.baseURL}q=$keyword&from=$_date&to=$_date&sortBy=popularity&apiKey=${NewsAPILinks.key}'),
    );
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final String respStr = await response.stream.bytesToString();
      final News _news = News.fromRawJson(respStr);
      return _news;
    } else {
      return null;
    }
  }
}
