// Adapted from: https://medium.com/flutter-community/flutter-implementing-google-sign-in-71888bca24ed
import 'package:flutter/material.dart';
import 'package:macrobaseapp/logic/usecases/login/firebase_auth.dart';
import 'package:macrobaseapp/model/entities/user.dart';
import 'package:provider/provider.dart';

import '../pages/macro_table_page.dart';
import '../pages/new_marco_page.dart';

class MainNavigator extends StatefulWidget {
  @override
  _MainNavigatorState createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  context.read<FirebaseAuthService>().signOut();
                },
              )
            ],
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.add),
                  text: 'New Macro',
                ),
                Tab(
                  icon: Icon(Icons.view_list),
                  text: 'Macro Instances',
                ),
                Tab(
                  icon: Icon(Icons.settings),
                  text: 'Setting',
                ),
              ],
            ),
            title: Text("Macrobase Platform"),
          ),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                Container(
                  child: DrawerHeader(
                    child: CircleAvatar(),
                  ),
                ),
                Container(
                  child: new Column(children: <Widget>[
                    Text("${user.displayName}"),
                    Text("${user.email}"),
                  ]),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              MyCustomForm(),
              MacroTable(),
              Center(
                child: Text("SETTINGS"),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Add', // used by assistive technologies
            child: Icon(Icons.add),
            onPressed: null
          ),
        ));
  }
}
