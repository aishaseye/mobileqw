import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// The name of the application
  ///
  /// In en, this message translates to:
  /// **'QualyWatch'**
  String get appName;

  /// Welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// Get started button text
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// Next button text
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Skip button text
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// Back button text
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Finish button text
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// Scan QR code action
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get scanQrCode;

  /// Give feedback action
  ///
  /// In en, this message translates to:
  /// **'Give Feedback'**
  String get giveFeedback;

  /// Earn rewards action
  ///
  /// In en, this message translates to:
  /// **'Earn Rewards'**
  String get earnRewards;

  /// First onboarding screen title
  ///
  /// In en, this message translates to:
  /// **'Monitor Customer Feedback'**
  String get onboardingTitle1;

  /// First onboarding screen description
  ///
  /// In en, this message translates to:
  /// **'Track and analyze customer feedback from QR code scans to improve your services and customer satisfaction'**
  String get onboardingDesc1;

  /// Second onboarding screen title
  ///
  /// In en, this message translates to:
  /// **'Real-Time Insights'**
  String get onboardingTitle2;

  /// Second onboarding screen description
  ///
  /// In en, this message translates to:
  /// **'Get instant notifications about customer feedback and respond quickly to improve your business reputation'**
  String get onboardingDesc2;

  /// Third onboarding screen title
  ///
  /// In en, this message translates to:
  /// **'Grow Your Business'**
  String get onboardingTitle3;

  /// Third onboarding screen description
  ///
  /// In en, this message translates to:
  /// **'Use detailed analytics and customer insights to make data-driven decisions and enhance your services'**
  String get onboardingDesc3;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Login button text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Register button text
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// Feedback label
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// Rewards label
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get rewards;

  /// Profile label
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Settings label
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Language setting
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// French language option
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Manager information title
  ///
  /// In en, this message translates to:
  /// **'Manager Information'**
  String get managerInfo;

  /// Company information title
  ///
  /// In en, this message translates to:
  /// **'Company Information'**
  String get companyInfo;

  /// Photos title
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get photos;

  /// Step indicator
  ///
  /// In en, this message translates to:
  /// **'Step {current}/{total}'**
  String step(String current, String total);

  /// First name field label
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// Last name field label
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// Phone field label
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// Confirm password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// Company name field label
  ///
  /// In en, this message translates to:
  /// **'Company Name'**
  String get companyName;

  /// Company email field label
  ///
  /// In en, this message translates to:
  /// **'Company Email'**
  String get companyEmail;

  /// Category field label
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// Number of employees field label
  ///
  /// In en, this message translates to:
  /// **'Number of Employees'**
  String get numberOfEmployees;

  /// Description field label
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// Creation date field label
  ///
  /// In en, this message translates to:
  /// **'Creation Date'**
  String get creationDate;

  /// Location field label
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// Company photo label
  ///
  /// In en, this message translates to:
  /// **'Company Photo'**
  String get companyPhoto;

  /// Manager logo label
  ///
  /// In en, this message translates to:
  /// **'Manager Logo'**
  String get managerLogo;

  /// Already have an account text
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// Enter your name hint
  ///
  /// In en, this message translates to:
  /// **'Enter your last name'**
  String get enterLastName;

  /// Enter your first name hint
  ///
  /// In en, this message translates to:
  /// **'Enter your first name'**
  String get enterFirstName;

  /// Enter your phone hint
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterPhone;

  /// Enter your email hint
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// Create a password hint
  ///
  /// In en, this message translates to:
  /// **'Create a password'**
  String get createPassword;

  /// Confirm your password hint
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirmPasswordHint;

  /// Enter company name hint
  ///
  /// In en, this message translates to:
  /// **'Enter company name'**
  String get enterCompanyName;

  /// Company email hint
  ///
  /// In en, this message translates to:
  /// **'contact@company.com'**
  String get companyEmailHint;

  /// Enter phone number hint
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get enterPhoneNumber;

  /// Describe your company hint
  ///
  /// In en, this message translates to:
  /// **'Describe your company'**
  String get describeCompany;

  /// Date format hint
  ///
  /// In en, this message translates to:
  /// **'DD/MM/YYYY'**
  String get dateFormat;

  /// City, Country hint
  ///
  /// In en, this message translates to:
  /// **'City, Country'**
  String get cityCountry;

  /// Add photos description
  ///
  /// In en, this message translates to:
  /// **'Add a photo of your company and your logo'**
  String get addPhotosDescription;

  /// Choose source dialog title
  ///
  /// In en, this message translates to:
  /// **'Choose a source'**
  String get chooseSource;

  /// Gallery option
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// Camera option
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// Please enter last name error
  ///
  /// In en, this message translates to:
  /// **'Please enter your last name'**
  String get pleaseEnterLastName;

  /// Please enter first name error
  ///
  /// In en, this message translates to:
  /// **'Please enter your first name'**
  String get pleaseEnterFirstName;

  /// Please enter phone error
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get pleaseEnterPhone;

  /// Invalid phone error
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get invalidPhone;

  /// Please enter email error
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterEmail;

  /// Invalid email error
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmail;

  /// Please enter password error
  ///
  /// In en, this message translates to:
  /// **'Please enter a password'**
  String get pleaseEnterPassword;

  /// Password too short error
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// Please confirm password error
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get pleaseConfirmPassword;

  /// Passwords do not match error
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// Please select category error
  ///
  /// In en, this message translates to:
  /// **'Please select a category'**
  String get pleaseSelectCategory;

  /// Please select employees error
  ///
  /// In en, this message translates to:
  /// **'Please select number of employees'**
  String get pleaseSelectEmployees;

  /// Please enter company name error
  ///
  /// In en, this message translates to:
  /// **'Please enter company name'**
  String get pleaseEnterCompanyName;

  /// Please enter description error
  ///
  /// In en, this message translates to:
  /// **'Please enter a description'**
  String get pleaseEnterDescription;

  /// Please select date error
  ///
  /// In en, this message translates to:
  /// **'Please select a date'**
  String get pleaseSelectDate;

  /// Please enter location error
  ///
  /// In en, this message translates to:
  /// **'Please enter location'**
  String get pleaseEnterLocation;

  /// Please add both photos error
  ///
  /// In en, this message translates to:
  /// **'Please add both photos'**
  String get pleaseAddBothPhotos;

  /// Registration successful message
  ///
  /// In en, this message translates to:
  /// **'Registration successful!'**
  String get registrationSuccessful;

  /// Selection error message
  ///
  /// In en, this message translates to:
  /// **'Error during selection: {error}'**
  String selectionError(String error);

  /// Photo error message
  ///
  /// In en, this message translates to:
  /// **'Error taking photo: {error}'**
  String photoError(String error);

  /// Enter name hint
  ///
  /// In en, this message translates to:
  /// **'Enter name'**
  String get enterName;

  /// Please enter name error
  ///
  /// In en, this message translates to:
  /// **'Please enter name'**
  String get pleaseEnterName;

  /// Please enter phone number error
  ///
  /// In en, this message translates to:
  /// **'Please enter phone number'**
  String get pleaseEnterPhoneNumber;

  /// Please select number of employees error
  ///
  /// In en, this message translates to:
  /// **'Please select number of employees'**
  String get pleaseSelectNumberOfEmployees;

  /// Describe your company hint
  ///
  /// In en, this message translates to:
  /// **'Describe your company'**
  String get describeYourCompany;

  /// Error during selection message
  ///
  /// In en, this message translates to:
  /// **'Error during selection'**
  String get errorDuringSelection;

  /// Error during photo capture message
  ///
  /// In en, this message translates to:
  /// **'Error during photo capture'**
  String get errorDuringPhotoCapture;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
