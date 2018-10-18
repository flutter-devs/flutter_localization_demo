import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appName': 'Localization Demo',
      'appNameShort': 'Localization',
      'title': 'FlutterDevs',
      'desc': 'FlutterDevs intent to deliver Flutter apps with '
          'high quality. We’ve adopted Design First attitude '
          'which helps us deliver applications of highest quality.',
    },
    'hi': {
      'appName': 'लोकलाइजेशन डेमो',
      'appNameShort': 'लोकलाइजेशन',
      'title': 'फ्लूटेरडेव्स',
      'desc': 'FlutterDevs उच्च गुणवत्ता वाले Flutter ऐप्स वितरित करने '
          'का इरादा रखता है। हमने डिजाइन फर्स्ट रवैया अपनाया है जो हमें '
          'उच्चतम गुणवत्ता के अनुप्रयोगों को वितरित करने में मदद करता है।',
    },
  };

  String get appName {
    return _localizedValues[locale.languageCode]['appName'];
  }
  String get appNameShort {
    return _localizedValues[locale.languageCode]['appNameShort'];
  }
  String get title {
    return _localizedValues[locale.languageCode]['title'];
  }
  String get desc {
    return _localizedValues[locale.languageCode]['desc'];
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hi'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}