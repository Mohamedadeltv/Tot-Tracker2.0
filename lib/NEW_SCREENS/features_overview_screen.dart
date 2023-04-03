import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:tottracker/NEW_SCREENS/app_drawer.dart';
import 'package:tottracker/widgets/features_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class FeaturesOverviewScreen extends StatefulWidget {
  const FeaturesOverviewScreen({super.key});
  static const routeName = '/features';

  @override
  State<FeaturesOverviewScreen> createState() => _FeaturesOverviewScreenState();
}

class _FeaturesOverviewScreenState extends State<FeaturesOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 224, 224),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 15, 53, 143),
        title: Center(
            child: Text(
          'Features',
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Silom'),
        )),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: FeaturesGrid(_showOnlyFavorites),
    );
  }
}
