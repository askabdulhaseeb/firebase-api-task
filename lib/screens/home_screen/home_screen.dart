import 'package:firebase_api_task/database/aith_methods.dart';
import 'package:firebase_api_task/screens/auth/login_screen.dart';
import 'package:firebase_api_task/screens/news_screen/news_screen.dart';
import 'package:firebase_api_task/widgets/custom_textformfield.dart';
import 'package:firebase_api_task/widgets/custom_toast.dart';
import 'package:flutter/material.dart';

import 'package:firebase_api_task/database/user_local_data.dart';
import 'package:firebase_api_task/utilities/utilities.dart';
import 'package:firebase_api_task/widgets/custom_drawer.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/HomeScreen-';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _search = TextEditingController();
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.portrait) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            ),
            drawer: const CustomDrawer(),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: Utilities.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    Utilities.getGreetingsText(),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    UserLocalData.getUserDisplayName,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const Divider(),
                  const Text(
                    'Welcome to our News',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const Text(
                    'From where you can get updated and latest news in free anytime anywhere',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.grey,
                    ),
                  ),
                  CustomTextFormField(
                    title: 'Search News',
                    controller: _search,
                    hint: 'Write any topic to search news',
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_search.text.isEmpty) {
                          CustomToast.errorToast(
                            message: 'Please write something to search',
                          );
                          return;
                        }
                        Navigator.of(context).push(
                          MaterialPageRoute<NewsScreen>(
                            builder: (BuildContext context) => NewsScreen(
                              topic: _search.text,
                            ),
                          ),
                        );
                      },
                      child: const Text('Search'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '''Today's Topics''',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _listOfNews(),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 60,
                      child: CustomTextFormField(
                        title: 'Search News',
                        controller: _search,
                        hint: 'Write any topic to search news',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_search.text.isEmpty) {
                        CustomToast.errorToast(
                          message: 'Please write something to search',
                        );
                        return;
                      }
                      Navigator.of(context).push(
                        MaterialPageRoute<NewsScreen>(
                          builder: (BuildContext context) => NewsScreen(
                            topic: _search.text,
                          ),
                        ),
                      );
                    },
                    child: const Text('Search'),
                  ),
                ],
              ),
              iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
            ),
            drawer: const CustomDrawer(),
            body: Padding(
              padding: EdgeInsets.symmetric(
                // vertical: Utilities.padding,
                horizontal: Utilities.padding * 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: Utilities.getGreetingsText(),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: UserLocalData.getUserDisplayName,
                          style: TextStyle(
                            fontSize: 32,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'Welcome to our News',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const Text(
                    'From where you can get updated and latest news in free anytime anywhere',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.grey,
                    ),
                  ),
                  const Divider(),
                  const Text(
                    '''Today's Topics''',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _listOfNews(),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Expanded _listOfNews() {
    return Expanded(
      child: ListView(
        children: const <Widget>[
          _TopicTile(
            title: 'COVID-19',
            subtitle:
                ''''The coronavirus, or COVID-19, is inciting panic for a number of reasons. It's a new virus, meaning no one has immunity.''',
            keyword: 'COVID',
          ),
          _TopicTile(
            title: 'Bitcoin(₿)',
            subtitle:
                'Bitcoin (₿) is a decentralized digital currency, without a central bank or single administrator.',
            keyword: 'Bitcoin',
          ),
          _TopicTile(
            title: 'BBC News',
            subtitle:
                'Visit BBC News for up-to-the-minute news, breaking news, video, audio and feature stories. BBC News provides trusted World and UK news.',
            keyword: 'BBC',
          ),
          _TopicTile(
            title: 'Work From Home',
            keyword: 'Work From Home',
            subtitle:
                '''The Most Relevant information. 100% Privacy Protected! Find what you are looking for Here. 99% Match on Work Online From Home Uk.''',
          ),
          _TopicTile(
            title: 'Football',
            keyword: 'Football',
            subtitle:
                '''Nowadays the game of football is presided over globally by FIFA, which was established in 1904 (41 years after the FA).''',
          ),
          _TopicTile(
            title: 'Cricket',
            keyword: 'Cricket',
            subtitle:
                '''Official T20 World Cup website - live matches, scores, news, highlights, commentary, rankings, videos and fixtures from the International Cricket Council.''',
          ),
          _TopicTile(
            title: 'SpaceX',
            keyword: 'SpaceX',
            subtitle:
                '''SpaceX designs, manufactures and launches advanced rockets and spacecraft. The company was founded in 2002 to revolutionize space technology, ...''',
          ),
          _TopicTile(
            title: 'Google',
            keyword: 'Google',
            subtitle:
                '''Search the world's information, including webpages, images, videos and more. Google has many special features to help you find exactly what you're looking ...''',
          ),
          _TopicTile(
            title: 'Facebook',
            keyword: 'Facebook',
            subtitle:
                '''Keeping up with friends is faster and easier than ever. Share updates and photos, engage with friends and Pages, and stay connected to communities important ...''',
          ),
        ],
      ),
    );
  }
}

class _TopicTile extends StatelessWidget {
  const _TopicTile({
    required this.title,
    required this.subtitle,
    required this.keyword,
    Key? key,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final String keyword;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<NewsScreen>(
              builder: (BuildContext context) => NewsScreen(topic: keyword),
            ),
          );
        },
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
