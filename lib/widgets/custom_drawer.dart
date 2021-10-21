import 'package:firebase_api_task/database/user_local_data.dart';
import 'package:firebase_api_task/screens/auth/login_screen.dart';
import 'package:firebase_api_task/screens/news_screen/news_screen.dart';
import 'package:firebase_api_task/utilities/utilities.dart';
import 'package:firebase_api_task/widgets/circular_profile_image.dart';
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
          const Divider(),
          ListTile(
            leading: const Icon(Icons.description_sharp, size: 36),
            title: const Text('News'),
            subtitle: const Text('Get updated news'),
            onTap: () {
              Navigator.of(context).pushNamed(NewsScreen.routeName);
            },
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
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
