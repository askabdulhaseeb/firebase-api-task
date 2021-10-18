import 'package:firebase_api_task/apis/news_api.dart';
import 'package:firebase_api_task/database/aith_methods.dart';
import 'package:firebase_api_task/models/news.dart';
import 'package:firebase_api_task/screens/auth/login_screen.dart';
import 'package:firebase_api_task/widgets/show_loading.dart';
import 'package:flutter/material.dart';
import 'news_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/HomeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        actions: [
          IconButton(
            onPressed: () async {
              showLoadingDislog(context);
              await AuthMethod().signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                LoginScreen.routeName,
                // ignore: always_specify_types
                (Route route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
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
