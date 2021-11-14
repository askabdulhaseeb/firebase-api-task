import 'package:firebase_api_task/models/news.dart';
import 'package:firebase_api_task/screens/news_detail_screen/news_detail_screen.dart';
import 'package:firebase_api_task/utilities/utilities.dart';
import 'package:firebase_api_task/widgets/circular_profile_image.dart';
import 'package:flutter/material.dart';

class NewsCardWidget extends StatelessWidget {
  const NewsCardWidget({required Article article, Key? key})
      : _article = article,
        super(key: key);
  final Article _article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<NewsDetailScreen>(
          builder: (BuildContext context) =>
              NewsDetailScreen(article: _article),
        ),
      ),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(Utilities.padding / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _header(),
              const SizedBox(height: 10),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: Utilities.padding / 2),
                child: Text(_article.content!),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _header() {
    return Row(
      children: <Widget>[
        CircularProfileImage(
          radious: 32,
          imageURL: _article.urlToImage!,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _article.title!,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _article.source!.name!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
