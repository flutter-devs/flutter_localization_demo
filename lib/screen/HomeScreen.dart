/*
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localization_app/main.dart';
import 'package:flutter_localization_app/model/RadioModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<RadioModel> _langList = new List<RadioModel>();

  int _index;

  @override
  void initState() {
    super.initState();
    _langList = _getLangList();

    _initLanguage();
  }

  bool isDevicePlatformAndroid() {
    return Theme.of(context).platform == TargetPlatform.android;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color(0xFFF6F8FA),
        appBar: AppBar(
          elevation: isDevicePlatformAndroid() ? 0.2 : 0.0,
          backgroundColor: const Color(0xFFF6F8FA),
          title: new Center(
            child: new Text(
              'Localization',
              style: TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: new Container(
            child: new Column(
          children: <Widget>[
            _buildMainWidget(),
            _buildLanguageWidget(),
          ],
        )));
  }

  Widget _buildMainWidget() {
    return new Flexible(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            _buildHeaderWidget(),
            _buildTitleWidget(),
            _buildDescWidget(),
          ],
        ),
      ),
      flex: 9,
    );
  }

  Widget _buildHeaderWidget() {
    return new Center(
      child: Container(
        margin: EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
        height: 180.0,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.all(
            new Radius.circular(8.0),
          ),
          image: new DecorationImage(
            fit: BoxFit.cover,
            image: new AssetImage(
              'assets/images/ic_banner.png',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleWidget() {
    return new Container(
      margin: EdgeInsets.only(top: 16.0, left: 12.0, right: 12.0),
      child: Text(
        'Lorem Ipsum',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDescWidget() {
    return new Center(
      child: Container(
        margin: EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0),
        child: Text(
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
              'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, '
              'when an unknown printer took a galley of type and scrambled it to make a '
              'type specimen book. It has survived not only five centuries, but also '
              'the leap into electronic typesetting, remaining essentially unchanged. '
              'It was popularised in the 1960s with the release of Letraset sheets containing'
              ' Lorem Ipsum passages, and more recently with desktop publishing software like '
              'Aldus PageMaker including versions of Lorem Ipsum',
          style: TextStyle(
              color: Colors.black87,
              inherit: true,
              fontSize: 13.0,
              wordSpacing: 8.0),
        ),
      ),
    );
  }

  Widget _buildLanguageWidget() {
    return new Flexible(
      child: Container(
        padding: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
        margin: EdgeInsets.only(left: 4.0, right: 4.0),
        color: Colors.grey[100],
        child: ListView.builder(
          itemCount: _langList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return new InkWell(
              splashColor: Colors.blueAccent,
              onTap: () {
                setState(() {
                  _langList.forEach((element) => element.isSelected = false);
                  _langList[index].isSelected = true;
                    _index = index;
                  _handleRadioValueChanged();
                });
              },
              child: new RadioItem(_langList[index]),
            );
          },
        ),
      ),
    );
  }

  List<RadioModel> _getLangList() {
    _langList.add(new RadioModel(true, 'English'));
    _langList.add(new RadioModel(false, 'Hindi'));
    _langList.add(new RadioModel(false, 'Marathi'));
    return _langList;
  }

  Future<String> _getLanguageCode() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('languageCode') == null) {
      return null;
    }
    print('_fetchLocale():' + prefs.getString('languageCode'));
    return prefs.getString('languageCode');
  }

  void _initLanguage() async {
    Future<String> status = _getLanguageCode();
    status.then((result) {
      if (result != null && result.compareTo('en') == 0) {
        setState(() {
          _index = 0;
        });
      }
      if (result != null && result.compareTo('hi') == 0) {
        setState(() {
          _index = 1;
        });
      } else {
        setState(() {
          _index = 0;
        });
      }
    });
  }

  void _updateLocale(String lang, String country) async {
    print(lang + ':' + country);

    var prefs = await SharedPreferences.getInstance();
    prefs.setString('languageCode', lang);
    prefs.setString('countryCode', country);

    MyApp.setLocale(context, Locale(lang, country));
  }

  void _handleRadioValueChanged() {
    print("SELCET_VALUE: " + _index.toString());
    setState(() {
      switch (_index) {
        case 0:
          print("English");
          _updateLocale('en', 'IN');
          break;
        case 1:
          print("Hindi");
          _updateLocale('hi', 'IN');
          break;
      }
    });
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;

  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
      margin: EdgeInsets.only(left: 4.0, right: 4.0),
      color: Colors.grey[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 4.0, right: 4.0),
            child: new Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Container(
                  width: 60.0,
                  height: 4.0,
                  decoration: new BoxDecoration(
                    color: _item.isSelected
                        ? Colors.redAccent
                        : Colors.transparent,
                    border: new Border.all(
                        width: 1.0,
                        color: _item.isSelected
                            ? Colors.redAccent
                            : Colors.transparent),
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(2.0)),
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.only(top: 8.0),
                  child: new Text(
                    _item.title,
                    style: TextStyle(
                      color:
                          _item.isSelected ? Colors.redAccent : Colors.black54,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/
