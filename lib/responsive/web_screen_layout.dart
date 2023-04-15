import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_flutter/utils/colors.dart';

import '../utils/global_variable.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  late PageController pageController;
  int _page = 0;

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          centerTitle: false,
          title: SvgPicture.asset(
            'assets/ic_instagram.svg',
            colorFilter: const ColorFilter.mode(
              primaryColor,
              BlendMode.srcIn,
            ),
            height: 32,
          ),
          actions: [
            IconButton(
              onPressed: () => navigationTapped(0),
              icon: const Icon(Icons.home),
              color: _page == 0 ? primaryColor : secondaryColor,
            ),
            IconButton(
              onPressed: () => navigationTapped(1),
              icon: const Icon(Icons.search),
              color: _page == 1 ? primaryColor : secondaryColor,
            ),
            IconButton(
              onPressed: () => navigationTapped(2),
              icon: const Icon(Icons.add_a_photo),
              color: _page == 2 ? primaryColor : secondaryColor,
            ),
            IconButton(
              onPressed: () => navigationTapped(3),
              icon: const Icon(Icons.favorite),
              color: _page == 3 ? primaryColor : secondaryColor,
            ),
            IconButton(
              onPressed: () => navigationTapped(4),
              icon: const Icon(Icons.person),
              color: _page == 4 ? primaryColor : secondaryColor,
            ),
          ],
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: onPageChanged,
          children: homeScreenItems,
        ));
  }
}
