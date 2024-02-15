import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              // Custom Tab Bar
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      _tabController.animateTo(0);
                    },
                    child: Text('Simple', style: TextStyle(color: _tabController.index == 0 ? Colors.blue : Colors.black)),
                  ),
                  Container(
                    height: 15,
                    width: 1,
                    color: Color.fromARGB(255, 181, 181, 181).withOpacity(0.4),
                  ),
                  GestureDetector(
                    onTap: () {
                       _tabController.animateTo(1);
                    },
                    child: Text('Advanced', style: TextStyle(color: _tabController.index == 1 ? Colors.blue : Colors.black)),
                  ),
                ],
              ),
              // Tab Bar View
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Simple Tab View
                    Container(
                      child: Center(
                        child: Text('Simple Tab Content', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    // Advanced Tab View
                    Container(
                      child: Center(
                        child: Text('Advanced Tab Content', style: TextStyle(fontSize: 20)),
                    ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}