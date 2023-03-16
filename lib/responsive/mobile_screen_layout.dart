import 'package:flutter/material.dart';
import 'package:instagram_flutter/model/user.dart' as model;
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model.User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Center(
        child: user == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Text(user.username),
      ),
    );
  }
}
