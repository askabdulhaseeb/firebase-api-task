import 'package:firebase_api_task/screens/auth/login_screen.dart';
import 'package:firebase_api_task/screens/home_screen/tile_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_api_task/utilities/utilities.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/HomeScreen-';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginScreen.routeName, (Route<dynamic> route) => false);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Utilities.padding),
        child: ListView.builder(
          itemCount: 100,
          itemBuilder: (BuildContext context, int index) => _TopicTile(
              index: index,
              subtitle: 'This is the subtitle of the tile no $index'),
        ),
      ),
    );
  }
}

class _TopicTile extends StatelessWidget {
  const _TopicTile({
    required this.index,
    required this.subtitle,
    Key? key,
  }) : super(key: key);
  final int index;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                TileDetailPage(pageNumber: index),
          ));
        },
        title: Text(
          'Tile No: $index',
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
