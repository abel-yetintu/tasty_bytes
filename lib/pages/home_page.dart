import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tasty_bytes/pages/about.dart';
import 'package:tasty_bytes/pages/home.dart';
import 'package:tasty_bytes/pages/saved_recipes.dart';
import 'package:tasty_bytes/pages/search.dart';
import 'package:tasty_bytes/shared/color_palette.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _title = '';
  final List<Widget> _pages = const [Home(), Search(), SavedRecipes(), About()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: secondaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                builder: (context) {
                  return GestureDetector(
                    child: const Icon(
                      Icons.menu,
                      color: colorBlack,
                      size: 28,
                    ),
                    onTap: () => Scaffold.of(context).openDrawer(),
                  );
                }
              ),
              Text(_title, style: const TextStyle(color: colorBlack, fontSize: 16, fontWeight: FontWeight.w500),),
              ClipOval(
                child: Image.asset(
                  'assets/images/avatar.jpg',
                  width: 35,
                  height: 35,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: secondaryColor,
          child: ListView(
            children:  [
              const DrawerHeader(
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/avatar.jpg',),
                      radius: 50,
                    ),
                    SizedBox(height: 10,),
                    Text('Vin', style: TextStyle(color: colorBlack, fontSize: 16),)
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home', style: TextStyle(fontSize: 16),),
                minLeadingWidth: 10,
                onTap: () {
                  if(_selectedIndex != 0) {
                    setState(() {
                    _selectedIndex = 0;
                    _title = '';
                   });
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Search', style: TextStyle(fontSize: 16),),
                minLeadingWidth: 10,
                onTap: () {
                  if(_selectedIndex != 1) {
                    setState(() {
                    _selectedIndex = 1;
                    _title = 'Search for recipes';
                   });
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.bookmark_outline),
                title: const Text('Saved', style: TextStyle(fontSize: 16),),
                minLeadingWidth: 10,
                onTap: () {
                  if(_selectedIndex != 2) {
                    setState(() {
                    _selectedIndex = 2;
                    _title = 'Saved recipes';
                   });
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('About', style: TextStyle(fontSize: 16),),
                minLeadingWidth: 10,
                onTap: () {
                  if(_selectedIndex != 3) {
                    setState(() {
                    _selectedIndex = 3;
                    _title = 'About';
                   });
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: colorWhite,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: GNav(
          selectedIndex: _selectedIndex,
          onTabChange: (value) {
            setState(() {
              _selectedIndex = value;
              switch(value) {
                case 0 : _title = '';
                break;
                case 1 : _title = 'Search for recipes';
                break;
                case 2 : _title = 'Saved recipes';
                break;
                case 3 : _title = 'About';
                break;
              }
            });
          },
          backgroundColor: colorWhite,
          color: accentColor,
          activeColor: primaryColor,
          tabActiveBorder: Border.all(color: accentColor),
          gap: 8,
          duration: const Duration(milliseconds: 500),
          padding: const EdgeInsets.all(12),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.search,
              text: 'Search',
            ),
            GButton(
              icon: Icons.bookmark_outline,
              text: 'Saved',
            ),
            GButton(
              icon: Icons.info_outline,
              text: 'About',
            ),
          ],
        ),
      ),
    );
  }
}
