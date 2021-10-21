import 'package:firebase_api_task/apis/news_api.dart';
import 'package:firebase_api_task/models/news.dart';
import 'package:flutter/material.dart';
import 'news_card_widget.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);
  static const String routeName = '/NewsScreen';
  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: FutureBuilder<News?>(
        future: NewsAPI().getNews(),
        builder: (BuildContext context, AsyncSnapshot<News?> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return _issueWidget();
            case ConnectionState.waiting:
              return _loadingWidget();
            case ConnectionState.active:
              return _loadingWidget();
            case ConnectionState.done:
              final News? _news = snapshot.data;
              return _news == null
                  ? _issueWidget()
                  : ListView.builder(
                      itemCount: _news.articles!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return NewsCardWidget(article: _news.articles![index]);
                      },
                    );
          }
        },
      ),
    );
  }

  Center _loadingWidget() {
    return const Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(),
      ),
    );
  }

  Center _issueWidget() {
    return const Center(
      child: Text(
        'Issue!!!',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
      ),
    );
  }
}
