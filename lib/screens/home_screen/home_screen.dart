import 'package:flutter/material.dart';

import 'package:firebase_api_task/database/user_local_data.dart';
import 'package:firebase_api_task/utilities/utilities.dart';
import 'package:firebase_api_task/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/HomeScreen-';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const SizedBox(height: 20),
            const Text(
              '''Today's Topics''',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _TopicTile(
                    title: 'COVID-19',
                    subtitle:
                        ''''The coronavirus, or COVID-19, is inciting panic for a number of reasons. It's a new virus, meaning no one has immunity''',
                    onTap: () {},
                  ),
                  _TopicTile(
                    title: 'Bitcoin(₿)',
                    subtitle:
                        'Bitcoin (₿) is a decentralized digital currency, without a central bank or single administrator',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopicTile extends StatelessWidget {
  const _TopicTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        onTap: onTap,
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
