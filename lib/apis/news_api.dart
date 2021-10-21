import 'package:firebase_api_task/models/news.dart';
import 'package:firebase_api_task/utilities/news_api_links.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class NewsAPI {
  Future<News?> getNews({String keyword = 'web'}) async {
    final DateFormat _formate = DateFormat('yyyy-MM-dd');
    final String _today = _formate.format(DateTime.now());
    final String _yesterday =
        _formate.format(DateTime.now().subtract(const Duration(days: 1)));
    final http.Request request = http.Request(
      'GET',
      Uri.parse(
          '${NewsAPILinks.baseURL}q=$keyword&from=$_yesterday&to=$_today&sortBy=popularity&apiKey=${NewsAPILinks.key}'),
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
