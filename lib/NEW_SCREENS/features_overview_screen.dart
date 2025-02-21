import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tottracker/NEW_SCREENS/app_drawer.dart';
import 'package:tottracker/NEW_SCREENS/profile_screen.dart';
import 'package:tottracker/widgets/features_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.home),
    title: const Text("Home"),
    selectedColor: Colors.purple,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.person),
    title: const Text("Profile"),
    selectedColor: Colors.teal,
  ),
];

class FeaturesOverviewScreen extends StatefulWidget {
  const FeaturesOverviewScreen({super.key});
  static const routeName = '/features';

  @override
  State<FeaturesOverviewScreen> createState() => _FeaturesOverviewScreenState();
}

class _FeaturesOverviewScreenState extends State<FeaturesOverviewScreen> {
  var _showOnlyFavorites = false;
  int _selectedIndex = 0;
  late final List<Widget> _pages;
  _FeaturesOverviewScreenState() {
    _pages = [
      FeaturesGrid(_showOnlyFavorites),

      ProfileScreens(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press manually
        if (_selectedIndex == 0) {
          // If we're on the first tab, exit the app
          return true;
        } else {
          // Otherwise, switch to the first tab and consume the back button press
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 228, 224, 224),
        appBar: _selectedIndex == 0
            ? AppBar(
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
              )
            : null,
        drawer: AppDrawer(),
        body: _pages[_selectedIndex],
        bottomNavigationBar: SalomonBottomBar(
            currentIndex: _selectedIndex,
            selectedItemColor: const Color(0xff6200ee),
            unselectedItemColor: const Color(0xff757575),
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: _navBarItems),
      ),
    );
  }
}
