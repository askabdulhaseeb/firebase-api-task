import 'package:firebase_api_task/database/aith_methods.dart';
import 'package:firebase_api_task/database/user_local_data.dart';
import 'package:firebase_api_task/screens/auth/login_screen.dart';
import 'package:firebase_api_task/screens/news_screen/news_screen.dart';
import 'package:firebase_api_task/utilities/utilities.dart';
import 'package:firebase_api_task/widgets/circular_profile_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(height: Utilities.padding * 2),
          _imageSection(context),
          const Divider(thickness: 0.8),
          Center(
            child: Text(
              'General News',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: const <Widget>[
                _NewsTile(keyword: 'today', title: 'About Today'),
                _NewsTile(keyword: 'covid', title: 'COVID-19'),
                _NewsTile(keyword: 'sports', title: 'Sports'),
                _NewsTile(keyword: 'space', title: 'Space'),
                _NewsTile(keyword: 'internet', title: 'Internet'),
                _NewsTile(keyword: 'google', title: 'Google'),
                _NewsTile(keyword: 'facebook', title: 'Facebook'),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              await AuthMethod().signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginScreen.routeName, (Route<dynamic> route) => false);
            },
          ),
          SizedBox(height: Utilities.padding),
        ],
      ),
    );
  }

  Padding _imageSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Utilities.padding),
      child: Row(
        children: <Widget>[
          CircularProfileImage(
            imageURL: UserLocalData.getUserImageUrl,
            radious: 44,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  UserLocalData.getUserDisplayName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  UserLocalData.getUserEmail,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _NewsTile extends StatelessWidget {
  const _NewsTile({required this.title, required this.keyword, Key? key})
      : super(key: key);
  final String title;
  final String keyword;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<NewsScreen>(
            builder: (BuildContext context) => NewsScreen(topic: keyword),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
            Icon(
              CupertinoIcons.forward,
              color: Theme.of(context).primaryColor.withOpacity(0.4),
            ),
          ],
        ),
      ),
    );
  }
}
