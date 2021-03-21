import 'package:espich_app/constants.dart';
import 'package:espich_app/src/pages/speech_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: Scaffold(
        bottomNavigationBar: _Navigation(),
        body: _Pages(),
      ),
    );
  }

  /* _changeLanguage() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                  child: Column(
                children: [
                  Text(
                    'Cambiar idioma',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  ListTile(
                    title: Text('Español'),
                    trailing:
                        _selectedLanguage == 'es_ES' ? Icon(Icons.check) : null,
                    onTap: () => setState(() {
                      _selectedLanguage = 'es_ES';
                    }),
                  ),
                  ListTile(
                    title: Text('Inglés'),
                    trailing:
                        _selectedLanguage == 'en_EN' ? Icon(Icons.check) : null,
                    onTap: () => setState(() {
                      _selectedLanguage = 'en_EN';
                    }),
                  ),
                  ListTile(
                    title: Text('Chino'),
                    trailing:
                        _selectedLanguage == 'zh' ? Icon(Icons.check) : null,
                    onTap: () => setState(() {
                      _selectedLanguage = 'zh';
                    }),
                  ),
                ],
              )),
            );
          });
        });
  } */
}

class _Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
        fixedColor: Constants.primaryColor,
        currentIndex: navigationModel.currentPage,
        onTap: (i) => navigationModel.currentPage = i,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.record_voice_over_rounded,
                color: Constants.lightGreyColor,
              ),
              label: 'Speech',
              activeIcon: Icon(
                Icons.record_voice_over_rounded,
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.bookmark,
                color: Constants.lightGreyColor,
              ),
              activeIcon: Icon(Icons.bookmark),
              label: 'Guardadas'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.highlight,
                color: Constants.lightGreyColor,
              ),
              activeIcon: Icon(
                Icons.highlight,
              ),
              label: 'Highlights'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Constants.lightGreyColor,
              ),
              activeIcon: Icon(
                Icons.settings,
              ),
              label: 'Ajustes')
        ]);
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: navigationModel.pageController,
      children: [SpeechPage()],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _currentPage = 0;
  PageController _pageController = PageController();

  int get currentPage => _currentPage;
  PageController get pageController => _pageController;

  set currentPage(int value) {
    this._currentPage = value;
    _pageController.animateToPage(value,
        duration: Duration(milliseconds: 300), curve: Curves.decelerate);
    notifyListeners();
  }
}
