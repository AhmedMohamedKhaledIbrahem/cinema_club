// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Select Language`
  String get languageLabel {
    return Intl.message(
      'Select Language',
      name: 'languageLabel',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get englishLanguageLabel {
    return Intl.message(
      'English',
      name: 'englishLanguageLabel',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabicLanguageLabel {
    return Intl.message(
      'Arabic',
      name: 'arabicLanguageLabel',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkModeLabel {
    return Intl.message(
      'Dark Mode',
      name: 'darkModeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Light Mode`
  String get lightModeLabel {
    return Intl.message(
      'Light Mode',
      name: 'lightModeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homeLabel {
    return Intl.message(
      'Home',
      name: 'homeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get searchLabel {
    return Intl.message(
      'Search',
      name: 'searchLabel',
      desc: '',
      args: [],
    );
  }

  /// `favorite`
  String get favoriteLabel {
    return Intl.message(
      'favorite',
      name: 'favoriteLabel',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get settingLabel {
    return Intl.message(
      'Setting',
      name: 'settingLabel',
      desc: '',
      args: [],
    );
  }

  /// `All Movies`
  String get allMoviesLabel {
    return Intl.message(
      'All Movies',
      name: 'allMoviesLabel',
      desc: '',
      args: [],
    );
  }

  /// `UpcomingMovies`
  String get upcomingMoviesLabel {
    return Intl.message(
      'UpcomingMovies',
      name: 'upcomingMoviesLabel',
      desc: '',
      args: [],
    );
  }

  /// `Top Rated Movies`
  String get topRatedMoviesLabel {
    return Intl.message(
      'Top Rated Movies',
      name: 'topRatedMoviesLabel',
      desc: '',
      args: [],
    );
  }

  /// `popular Movies`
  String get popularMoviesLabel {
    return Intl.message(
      'popular Movies',
      name: 'popularMoviesLabel',
      desc: '',
      args: [],
    );
  }

  /// `Search Movies`
  String get searchMoviesLabel {
    return Intl.message(
      'Search Movies',
      name: 'searchMoviesLabel',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logoutLabel {
    return Intl.message(
      'Logout',
      name: 'logoutLabel',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginLabel {
    return Intl.message(
      'Login',
      name: 'loginLabel',
      desc: '',
      args: [],
    );
  }

  /// `SignUp`
  String get signupLabel {
    return Intl.message(
      'SignUp',
      name: 'signupLabel',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password ?`
  String get forgetPasswordLabel {
    return Intl.message(
      'Forget Password ?',
      name: 'forgetPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `or Login With`
  String get orLoginwithLabel {
    return Intl.message(
      'or Login With',
      name: 'orLoginwithLabel',
      desc: '',
      args: [],
    );
  }

  /// `Don't Have an Account?`
  String get dontHaveAnAccountLabel {
    return Intl.message(
      'Don\'t Have an Account?',
      name: 'dontHaveAnAccountLabel',
      desc: '',
      args: [],
    );
  }

  /// `Aleardy Have an Account?`
  String get aleardyHaveAnAccountLabel {
    return Intl.message(
      'Aleardy Have an Account?',
      name: 'aleardyHaveAnAccountLabel',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get nameLabel {
    return Intl.message(
      'User Name',
      name: 'nameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailLabel {
    return Intl.message(
      'Email',
      name: 'emailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneLabel {
    return Intl.message(
      'Phone Number',
      name: 'phoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message(
      'Password',
      name: 'passwordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPasswordLabel {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get forgetPasswordButtonLabel {
    return Intl.message(
      'Confirm',
      name: 'forgetPasswordButtonLabel',
      desc: '',
      args: [],
    );
  }

  /// `please check your mail`
  String get forgetpasswordconfirmLabel {
    return Intl.message(
      'please check your mail',
      name: 'forgetpasswordconfirmLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a username`
  String get pleaseEnterUsernameLabel {
    return Intl.message(
      'Please enter a username',
      name: 'pleaseEnterUsernameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Username cannot start with a number`
  String get usernameCannotStartWithNumberLabel {
    return Intl.message(
      'Username cannot start with a number',
      name: 'usernameCannotStartWithNumberLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter an email`
  String get pleaseEnterAnEmailLabel {
    return Intl.message(
      'Please enter an email',
      name: 'pleaseEnterAnEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `valid email (e.g., example@gmail.com)`
  String get validEmailLabel {
    return Intl.message(
      'valid email (e.g., example@gmail.com)',
      name: 'validEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a phone number`
  String get pleaseEnterPhoneNumberLabel {
    return Intl.message(
      'Please enter a phone number',
      name: 'pleaseEnterPhoneNumberLabel',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number format`
  String get invalidPhoneLabel {
    return Intl.message(
      'Invalid phone number format',
      name: 'invalidPhoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a password`
  String get pleaseEnterPasswordLabel {
    return Intl.message(
      'Please enter a password',
      name: 'pleaseEnterPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get pleaseConfirmYourPasswordLabel {
    return Intl.message(
      'Please confirm your password',
      name: 'pleaseConfirmYourPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatchLabel {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatchLabel',
      desc: '',
      args: [],
    );
  }

  /// `Rating:`
  String get ratingLabel {
    return Intl.message(
      'Rating:',
      name: 'ratingLabel',
      desc: '',
      args: [],
    );
  }

  /// `No Search Found`
  String get NoSearchFoundLabel {
    return Intl.message(
      'No Search Found',
      name: 'NoSearchFoundLabel',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
